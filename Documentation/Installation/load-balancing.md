#Umbraco in Load Balanced Environments

_Information on how to deploy Umbraco in a Load Balanced scenario and other details to consider when setting up Umbraco for load balancing_

##Overview
Configuring and setting up a load balanced server environment requires planning, design and testing. This document should assist you in setting up your servers, load balanced environment and Umbraco configuration. 

This document assumes that you have a fair amount of knowledge about:

* Umbraco
* IIS 7+
* Networking & DNS
* Windows Server (2008/2012)
* .Net Framework

##Design
For the sake if this document, the following assumptions will be made:

* All servers are part of the same domain
* All servers are on the same network/subnet
* You have administration access to all servers
* All servers can communicate via HTTP protocol with each other
* You should be running in ASP.Net Full trust (medium trust may cause some issues with load balancing)
* **You will designate a single server to be back-office server for which your editors will log in to for editing content.** Umbraco out-of-the-box currently *(coming soon...)* will not seamlessly work if the back-office is behind the load balancer *(see DNS for more information below)*. If you require that the back office is load balanced you may have to do additional custom development to ensure this works seamlessly.

There are 2 design alternatives you can use to effectively load balance servers:

1. Each server hosts copies of the load balanced website files and a file replication service is running to ensure that all files on all servers are up to date. *This is the recommended approach.* 
2. The load balanced website files are located on a centralized file share (SAN/NAS/Custered File Server/Network Share)

 

And, you'll need a load balancer to do your load balancing obviously!

##DNS
Each server in your cluster will require a custom unique DNS name assigned to the host header for the IIS install for this website. This is so Umbraco knows which server nodes to replicate it's cached content with.

An example of how to setup DNS and host headers between 3 load balanced servers:

Server 1

* domain DNS name: server1.mydomain.local
* internal website DNS name: server1.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.10

Server 2

* domain DNS name: server2.mydomain.local
* internal website DNS name: server2.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.11

Server 3

* domain DNS name: server3.mydomain.local
* internal website DNS name: server3.mywebsite.com (use for IIS host header)
* IP Address: 192.168.1.12

Of course you'll have your public website's DNS/address which you'll also need to add to the host header for each of your IIS server's websites. For instance, if the public website address is: http://www.mywebsite.com then you'll need to add www.mywebsite.com as a host header to IIS website on each server. This DNS entry will point to the public IP address of your load balancer.

###Back office server

You should designate one of these servers to be the back-office server for which your editors will use to log in to and edit content. This can be acheived by creating another public DNS entry/host header that you can assign to your designated server. 

As an example, you could assign Server 1 as the designated back-office server. In this case you could create a DNS entry such as **admin.mywebsite.com** and add as a host header to Server 1. 

You will then need to ensure that any public request going to this DNS entry only goes to Server 1. This can be acheived by assigning a secondary public IP address to the DNS entry and configuring your firewall to NAT this IP address to your Server 1 internal IP address. Other alternatives could possibly be acheived based on your firewall and the configuration that it supports.

##Load Balancer
A load balancer is what is going to balance the traffic between your servers. There's a ton of load balancers out there and hardware ones are generally the most effective way to go about balancing traffic. If you don't have a hardware load balancer, don't worry as you can use software. Windows server comes with [NLB (Network load balancing)](http://technet.microsoft.com/en-us/library/cc758834%28WS.10%29.aspx). It's relatively easy to setup and it's free. 

Some important notes on NLB:

* [Load balancing with VMWare & NLB](http://www.vmware.com/files/pdf/implmenting_ms_network_load_balancing.pdf)
* Ensure that the internal IP Addresses for NLB have DNS registration disabled, are not configured to a a client for Microsoft Networks and have Netbios over TCPIP disabled
* Windows Server 2008 changed the way that TCP-IP works and have disabled forwarding. In order for NLB to work with 2 network cards (the recommended way), you have to enable forwarding for the private NIC:
	* [Article 1](http://www.numtopia.com/terry/blog/archives/2008/10/windows_2008_nlb_with_2_nics.cfm)
	* [Article 2](http://www.windowsreference.com/windows-server-2008/dual-nic-nlb-configuration-with-windows-server-2008-nlb-clusters/)

##File Storage with File Replication

*This is the recommended setup*

A very common way to do file replication on Windows Server is to use [DFS](http://msdn.microsoft.com/en-us/library/windows/desktop/bb540031(v=vs.85).aspx) which comes with Windows Server for free. 

Additional DFS resources:

* [Implementing DFS Replication in Windows Server 2003](http://www.windowsnetworking.com/articles_tutorials/Implementing-DFS-Replication.html)
* [Overview of DFS Replication in Windows Server 2008 R2](http://technet.microsoft.com/en-us/library/cc771058.aspx)
* [Watch an intro to installing and working with DFS](http://www.youtube.com/watch?v=DYfBoUt2RVE)

There are other alternatives for file replication out there, some free and some licensed. You'll need to decide which solution is best for your environment.

###Non-replicated files

When deploying Umbraco in a load balanced scenario using file replication it is important to ensure that not all files are replicated otherwise you will get file locking issues. Here are the folders/files to ensure are not replicated:

* ~/App_Data/TEMP/*
* ~/App_Data/umbraco.config 
	* Alternatively you can change the web.config entry to store this file inside of the ~/App_Data/TEMP folder using this
	
			<add key="umbracoContentXML" value="~/App_Data/TEMP/umbraco.config" />
	* Another alternative is to have the umbraco.config file stored in the local server's 'temp' folder, this can be acheived by changing this configuration setting to 'true' in the web.config. The downside of this is that if you need to view this configuration file you'll have to find it in the temp files which isn't always clear.
			
			<add key="umbracoContentXMLUseLocalTemp" value="true" /> 
* ~/App_Data/Logs/*
	* This is **optional** and depends on how you want your logs configured (see below) 

If for some reason your file replication solution doesn't allow you to not replicate specific files folders (which it should!!) then you can use an alternative approach by using virtual directories. *This is not the recommended setup but it is a viable alternative:*

* Edit /web.config and change the umbracoContentXML to use ~/App_Data/TEMP/umbraco.config.
* Copy the /App_Data/TEMP directory to each server, outside of any replication areas or to a unique folder for each server.
* Create a virtual directory (not a virtual application) in the /App_Data folder, and name it TEMP.  Point the virtual directory to the folder you created in step 2.
* You may delete the /App_Data/TEMP folder from the file system (not IIS as this may delete the virtual directory) if you wish.

###Additional important notes

####Examine/Lucene
When running in a replicated environment Lucene/Examine indexes must not be replicated (as per above). It is also important to note that Lucene/Examine indexes will only contain published *content* on each server node. The only server node that will contain full Lucene/Examine indexes with unpublished content and media will be the server that you've designated as your back-office administration server. If you require your Lucene/Examine indexes to contain unpublished content and media on your additional servers it is probably possible but some custom setup will be required. 

####Logging
Since Umbraco is using log4net for logging there are various configurations that you can use to ensure logging is done the way that you'd like. If you are replicating your logs - which you may wish to do to ensure that all of your servers have the other server logs - then you'll want to ensure that your logs are named with file names that include the machine name, otherwise you'll get file locks or your logs will get overwritten. *(See below for details on how to do this)* 

Other options include changing your log4net setup to log to a centralized database - of course if your database cannot be accessed then no logging will occur so be aware of this.

###IIS Setup

IIS configuration is pretty straightforward with file replication because IIS is just reading files from it's own file system just like a normal IIS website.

##File Storage on SAN/NAS/Clustered File Server/Network Share

Configuring your servers to work using a centrally located file system that is shared for all of your IIS instances can be tricky and can take a while to setup correctly. 

**This is when it is very important to have one designated server operating as your back-office editing server.** If you have not configured your environment this way you will get file locks especially regarding Lucene/Examine indexes.  

A note when using this method to store your files centrally, you **must** make sure that your file storage system is HA (Highly Available) which means that there's not single point of failure. If you're hosting your files on a File Server share, you need to make the file share clustered (using [MSCS](http://en.wikipedia.org/wiki/Microsoft_Cluster_Server) or similar). Windows server 2008 supports connecting directly to a SAN via [iSCSI](http://en.wikipedia.org/wiki/ISCSI) if your SAN supports it (there are also many other ways to connect to a SAN to share folders), otherwise you should be able to connect to a NAS via a UNC path.

There's a lot of work required to get this working, but once it's done it's fairly easy to maintain. We've this same setup working for many websites so hopefully these notes help you get started:

###Umbraco configuration

One important configuration option that **must** be set when using a centralized storage is to store the umbraco.config file in the ASP.Net temp folder local to the individual server. Change this setting to 'true' in your web.config

	<add key="umbracoContentXMLUseLocalTemp" value="true" /> 



###Windows Setup

* Create domain user account that will run your IIS websites. Example: MyDomain\WebsiteUser
* Grant this domain user FULL access to your file share
* On each web server, add this user to the IIS Security group account. Server 2003: IIS_WPG, Server 2008: IIS_IUSRS
* The .Net Code Access Policy must be updated on each server to run with Full Trust for the UsterNC share:
** EXAMPLE: %windir%\Microsoft.NET\Framework64\v2.0.50727\caspol -m -ag 1. -url "file://\\fileserver.mydomain.local\Inetpub\MySite\*" FullTrust -name "WebsiteUser"
* The IIS user above needs to be granted the appropriate IIS permissions:
** EXAMPLE: %windir%\Microsoft.NET\Framework64\v2.0.50727\Aspnet_regiis.exe -ga ActiveDirectoryDomain\ProcessIdentity
* Restart the server

**Much of the above is covered in this Microsoft doc: [ASP.Net 3.5 Hosting](http://wiki.dev/GetFile.aspx?File=Wiggles-Hosting/ASPNET35_HostingDeploymentGuide.doc)**

###IIS Setup

Since the files for the website will be hosted centrally, each IIS website on your servers will need to point to the same UNC share for the files. For example: *\\fileserver.mydomain.local\Inetpub\MySite*

* point to the shared file server: \\fileserver.mydomain.local\Inetpub\MySite
* "Connect To" this share with the user account created above
* have their application pools run as the user above
* Have the IIS anonymous user account set to the application pool account (IIS 7)

###Additional important notes

####Examine/Lucene
As noted above if running Umbraco load balanced in a centralized SAN environment you must only have one designated server as the administration server otherwise it will not work, you will get file locks.

####Logging
Since Umbraco is using log4net for logging there are various configurations that you can use to ensure logging is done the way that you'd like. If you are using file based logs you'll want to ensure that your logs are named with file names that include the machine name, otherwise you'll get file locks. *(See below for details on how to do this)*

Other options include changing your log4net setup to log to a centralized database - of course if your database cannot be accessed then no logging will occur so be aware of this.

##ASP.Net Configuration

* You will need to use a custom machine key so that all your machine key level encryption values are the same on all servers, without this you will end up with view state errors, validation errors and encryption/decryption errors since each server will have it's own generated key.
	* Here's a couple of tools that can be used to generate machine keys:
		* 	[http://www.betterbuilt.com/machinekey/](http://www.betterbuilt.com/machinekey/)
		* 	[http://www.developerfusion.com/tools/generatemachinekey/](http://www.developerfusion.com/tools/generatemachinekey/)
	* 	Then you need to update your web.config accordingly, note that the validation/decryption types may be different for your environment depending on how you've generated your keys.

			<configuration>
			  <system.web>
			    <machineKey decryptionKey="Your decryption key here" 
			                validationKey="Your Validation key here"
							validation="SHA1"
							decryption="AES" />
			  </system.web>
			</configuration>
* If you use SessionState in your application, or are using the default TempDataProvider in MVC (which uses SessionState) then you will need to configure your application to use the SqlSessionStateStore provider (see [http://msdn.microsoft.com/en-us/library/aa478952.aspx](http://msdn.microsoft.com/en-us/library/aa478952.aspx) for more details).

##Umbraco Configuration

Configuring Umbraco to support load balanced clusters is probalby the easiest part. In the /config/umbracoSettings.config file you need to updated the distributed call section to the following (as an example)
	
	<distributedCall enable="true">
	    <user>0</user>
	    <servers>
	       <server>server1.mywebsite.com</server>
	        <server>server2.mywebsite.com</server>
	        <server>server3.mywebsite.com</server>
	    </servers>
	</distributedCall>

As you can see in the above XML the distributed server names are the custom DNS names created for each IIS host name for each server.  Don't forget to enable the distributedCall.

There's a couple optional elements for the configuration of each server that allow you to specify a specific protocol or port number:

	<server forceProtocol="http|https" forcePortnumber="80|443">server3.mywebsite.com</server>

##Testing
You'll need to test this solution **a lot** before going to production. You need to ensure there are no windows security issues, etc... The best way to determine issues is have a lot of people testing this setup and ensuring all errors and warnings in your application/system logs in Windows are fixed.

To test Umbraco distributed calls, just create and publish some content on one server (i.e. http://server1.mywebsite.com/umbraco/umbraco.aspx), then browse to the front end content on another server (i.e. http://server2.mywebsite.com/public/page1.aspx if page1 was the newly published content). If the page shows up on the 2nd server, though it was published from the 1st server, then distributed calls are working! You'll need to thoroughly test this though.

##Log4net file logging with machine name
This describes how you can configure log4net to write log files that are named with the machine name.

You'll have to create a custom log4net formatter:

    public sealed class MachineNameLogConverter : log4net.Util.PatternConverter
    {
        protected override void Convert(TextWriter writer, object state)
        {
            writer.Write(Environment.MachineName);
        }
    }

Then update your log4net configuration to use the pattern converter:

	  <appender name="AsynchronousLog4NetAppender"
	            type="Umbraco.Core.Logging.AsynchronousRollingFileAppender, Umbraco.Core">
	    <!--
			THIS IS THAT VALUE THAT UMBRACO IS SHIPPED WITH THAT DOES NOT
			INCLUDE THE MACHINE NAME IN THE FILE
			<file value="App_Data\Logs\UmbracoTraceLog.txt" />
		-->

		<!-- THIS IS THE NEW CHANGE TO HAVE A MACHINE NAME IN THE FILE NAME -->
	    <file type="log4net.Util.PatternString" >
	      <converter>
	        <name value="hostname" />
	        <type value="YourProject.MachineNameLogConverter, YourProject" />
	      </converter>
	      <conversionPattern value="App_Data\Logs\UmbracoTraceLog.%hostname{LocalApplicationData}.txt" />
	    </file>

	    <lockingModel type="log4net.Appender.FileAppender+MinimalLock" />
	    <appendToFile value="true" />
	    <rollingStyle value="Date" />
	    <maximumFileSize value="5MB" />
	    <layout type="log4net.Layout.PatternLayout">
	      <conversionPattern value="%date [%thread] %-5level %logger - %message%newline" />
	    </layout>
	  </appender>

##Conclusion
Though this is somewhat detailed, this is still a basic overview since all environments are different in some way. Hopefully this guide will point you in the right direction!
