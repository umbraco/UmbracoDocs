---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Traditional (Legacy/Deprecated) load balancing

_Information on how to deploy Umbraco in a traditional Load Balanced scenario and other details to consider when setting up Umbraco for load balancing._

Traditional load balancing must be used for Umbraco versions less than 7.3.0.

:::note
If you are using Umbraco 7.3.0+ then it is highly recommended to use the new [Flexible Load Balancing](index.md)

Be sure you read the [Overview](index.md) before you begin!
:::

## Design

These instructions make the following assumptions:

* All servers are part of the same domain
* All servers are on the same network/subnet
* You have administration access to all servers
* All servers can communicate via HTTP protocol with each other
* You should be running in ASP.NET Full Trust (medium trust may cause some issues with load balancing)
* _**You will designate a single server to be the backoffice server for which your editors will log into for editing content.**_ Umbraco will not work if the backoffice is behind the load balancer *(see DNS for more information below)*.

There are two design alternatives you can use to effectively load balance servers:

1. Option #1 : Each server hosts copies of the load balanced website files and a file replication service is running to ensure that all files on all servers are up to date. __This is the recommended approach.__
2. Option #2 : The load balanced website files are located on a centralized file share (SAN/NAS/Clustered File Server/Network Share).

And you will need a load balancer to do your load balancing.

## DNS

Each server in your cluster will require a custom unique DNS name assigned to the host header for the IIS install for this website. This is so Umbraco knows which server nodes to replicate its cached content with.

An example of how to setup DNS and host headers between 3 load balanced servers:

Server 1

* Domain DNS name: server1.mydomain.local
* Internal website DNS name: server1.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.10

Server 2

* Domain DNS name: server2.mydomain.local
* Internal website DNS name: server2.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.11

Server 3

* Domain DNS name: server3.mydomain.local
* Internal website DNS name: server3.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.12

Keep in mind that you'll have your public website's DNS/address which you'll also need to add to the host header for each of your IIS server's websites. For instance, if the public website address is: `http://www.mywebsite.com` then you'll need to add www.mywebsite.com as a host header to IIS website on each server. This DNS entry will point to the public IP address of your load balancer.

### Backoffice server

You should designate one of these servers to be the backoffice server for which your editors will use to log in to and edit content. This can be achieved by creating another public DNS entry/host header that you can assign to your designated server.

As an example, you could assign Server 1 as the designated backoffice server. In this case you could create a DNS entry such as **admin.mywebsite.com** and add as a host header to Server 1.

You will then need to ensure that any public request going to this DNS entry only goes to Server 1. This can be achieved by assigning a secondary public IP address to the DNS entry and configuring your firewall to NAT this IP address to your Server 1 internal IP address. Other alternatives could possibly be achieved based on your firewall and the configuration that it supports.

## Load Balancer

A load balancer will balance the traffic between your servers. There are many load balancers out there and hardware ones are generally the most effective way to balance traffic. If you don't have a hardware load balancer, don't worry - you can use software. Windows Server comes with [NLB (Network Load Balancing)](https://technet.microsoft.com/en-us/library/cc758834%28WS.10%29.aspx).

Some important notes on NLB:

* [Load balancing with VMWare & NLB](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/techpaper/implmenting_ms_network_load_balancing.pdf)
* Ensure that the internal IP Addresses for NLB have DNS registration disabled, are not configured to a client for Microsoft Networks and have Netbios over TCP/IP disabled
* Windows Server 2008 changed the way that TCP-IP works and have disabled forwarding. In order for NLB to work with 2 network cards (the recommended way), you have to enable forwarding for the private NIC:
  * [Balancing Act: Dual-NIC Configuration with Windows Server 2008 NLB Clusters](https://blogs.technet.microsoft.com/networking/2008/11/20/balancing-act-dual-nic-configuration-with-windows-server-2008-nlb-clusters/)

## Option #1 : File Storage with File Replication

*This is the recommended setup.*

[See here for specific details about using Option #1: File Storage with Replication](files-replicated.md)

## Option #2 : File Storage on SAN/NAS/Clustered File Server/Network Share

Configuring your servers to work using a centrally located file system that is shared for all of your IIS instances can be tricky and can take a while to setup correctly.

[See here for specific details about using Option #2: File Storage on SAN/NAS/Clustered File Server/Network Share](files-shared.md)

## Umbraco Configuration

Configuring Umbraco to support load balanced clusters is probably the easiest part. In the /config/umbracoSettings.config file you need to updated the distributed call section to the following (as an example)

```xml
<distributedCall enable="true">
    <user>0</user>
    <servers>
        <server>server1.mywebsite.com</server>
        <server>server2.mywebsite.com</server>
        <server>server3.mywebsite.com</server>
    </servers>
</distributedCall>
```

As you can see in the above XML the distributed server names are the custom DNS names created for each IIS host name for each server.  Don't forget to enable the distributedCall.

There are a couple optional elements for the configuration of each server that allow you to specify a specific protocol or port number:

```xml
<server forceProtocol="http|https" forcePortnumber="80|443">server3.mywebsite.com</server>
```

If you only add https bindings to your site in IIS, then you will need to set umbracoUseSSL="true" in your web.config in order for publish to work.

### Correct config for scheduled publishing & tasks

As of Umbraco 6.2.1+ and 7.1.5+ there are another couple of options to take into account:

* If you have your load balancing environment setup with a 'master' server, Umbraco will assume that the **first** server listed in the configuration is the 'master'
* For scheduled publishing and scheduled tasks to work properly, each server listed needs to know if it is the 'master' server or not. In order to achieve this there are 2 optional attributes for a server configuration node: serverName or appId

**serverName** will be the most common attribute to use and will always work so long as you are not load balancing a single site on the same server. In this case you should add the serverName attribute to each server node listed.  They way each server knows if it is a master or replica and so that each server knows which internal URL it can use to ping itself. Take not that the serverName must match the machine name otherwise scheduled tasks will not work
Example:

```xml
<server serverName="MyServer1">server1.mywebsite.com</server>
<server serverName="MyServer2">server2.mywebsite.com</server>
<server serverName="MyServer3">server3.mywebsite.com</server>
```

**appId** is a less common attribute to use but will need to be used in the case where you are load balancing a single site on the same server. The appId is determined by the result of: `HttpRuntime.AppDomainAppId`. This is generally the id of the IIS site hosting the web app (i.e. the value might look something like: /LM/W3SVC/69/ROOT ). You shouldn't specify both the serverName and appId together on the same xml server node, if you do the appId will take precedence.
Example:

```xml
<server appId="/LM/W3SVC/987/ROOT">server1.mywebsite.com</server>
<server appId="/LM/W3SVC/123/ROOT">server2.mywebsite.com</server>
<server serverName="MyServer3">server3.mywebsite.com</server>
```

## Testing

The normal testing practices should be done (See [Common load balancing setup information](index.md)) with a traditional load balancing setup but specific testing can be done to ensure
that your distributed calls are being made correctly in a traditional setup. To test Umbraco distributed calls, create and publish some content on one server (i.e. `http://server1.mywebsite.com/umbraco/umbraco.aspx`).
Then browse to the front end content on another server (i.e. `http://server2.mywebsite.com/public/page1.aspx` if page1 was the newly published content).
If the page shows up on the 2nd server, though it was published from the 1st server, then distributed calls are working! You'll need to thoroughly test this though.

## Conclusion

Though this is somewhat detailed, this is still a basic overview since all environments are different in some way. Hopefully this guide will point you in the right direction!
