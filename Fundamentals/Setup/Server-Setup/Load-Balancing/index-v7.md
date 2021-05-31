---
versionFrom: 7.0.0
---

# Umbraco in Load Balanced Environments

_Information on how to deploy Umbraco in a Load Balanced scenario and other details to consider when setting up Umbraco for load balancing._

## Overview

Configuring and setting up a load balanced server environment requires planning, design and testing. This document should assist you in setting up your servers, load balanced environment and Umbraco configuration.

This document assumes that you have a fair amount of knowledge about:

* Umbraco
* IIS 7+
* Networking & DNS
* Windows Server (2008/2012)
* .NET Framework

:::note
It is highly recommended that you setup your staging environment to also be load balanced so that you can run all of your testing on a similar environment to your live environment.
:::

## Flexible load balancing

With Umbraco version 7.3.0, load balancing is easier than ever before.
Setting up a load balanced environment is achievable with a few configuration file changes.

[Full documentation is available here](flexible-v7.md)

## Legacy load balancing

Umbraco versions before 7.3.0 must use a legacy/deprecated load balancing technique.

[Full documentation is available here](traditional.md)

## Common load balancing setup information

_The below section is common for all load balancing configurations, ensure that the following  instructions are followed regardless of what load balancing setup you choose._

### ASP.NET Configuration

* You will need to use a custom machine key so that all your machine key level encryption values are the same on all servers, without this you will end up with view state errors, validation errors and encryption/decryption errors since each server will have its own generated key.
	* Here are a couple of tools that can be used to generate machine keys:
		* 	[Machine key generator on betterbuilt.com](http://www.betterbuilt.com/machinekey/)
		* 	[Machine key generator on developerfusion.com](https://www.developerfusion.com/tools/generatemachinekey/)
	* 	Then you need to update your web.config accordingly, note that the validation/decryption types may be different for your environment depending on how you've generated your keys.
    * Once the machine key has been changed, don't forget you will need to **reset your password** in order to log in to the backoffice.

```xml
<configuration>
  <system.web>
    <machineKey decryptionKey="Your decryption key here"
                validationKey="Your Validation key here"
                validation="SHA1"
                decryption="AES" />
  </system.web>
</configuration>
```

* If you use SessionState in your application, or are using the default TempDataProvider in MVC (which uses SessionState) then you will need to configure your application to use the SqlSessionStateStore provider (see [https://msdn.microsoft.com/en-us/library/aa478952.aspx](https://msdn.microsoft.com/en-us/library/aa478952.aspx) for more details).

### Logging

There are some logging configurations to take into account no matter what type of load balancing environment you are using.

[Full documentation is available here](logging.md)

### Testing

Your staging environment should also be load balanced so that you can see any issues relating to load balancing in that environment before going to production.

You'll need to test this solution **a lot** before going to production. You need to ensure there are no windows security issues, etc... The best way to determine issues is have a lot of people testing this setup and ensuring all errors and warnings in your application/system logs in Windows are fixed.

Ensure to analyze logs from all servers and check for any warnings and errors.

## FAQs

_Here's some common questions that are asked regarding Load Balancing with Umbraco:_

__Question>__ _Why do I need to have a single web instance for Umbraco admin?_

_TL:DR_ You must not load balance the Umbraco backoffice, you will end up with data integrity or corruption issues.

The reason you need a single server is because there is no way to guarantee transactional safety between servers. This is because we don't currently use database level locking, we only use application (c#) level locks to guarantee transactional data integrity which is only possible to work on one server. If you have multiple admins saving and publishing at once between servers then the order in which this data is read and written to the database absolutely must be consistent otherwise you will end up with data corruption.

Additionally the order in which cache instructions are written to the cache instructions table is very important for LB, this order is guaranteed by having a single admin server.

__Question>__ _Can my primary admin server also serve front-end requests?_

Yes. There are no problems with having your primary admin server also serve front-end request.

However, if you wish to have different security policies for your front-end servers and your back
office servers, you may choose to not do this.

__Question>__ _Can I use Courier combined with Load Balancing?_

Yes! However, it is critical that when you are pushing changes via Courier to your load balanced environment that you configure Courier to only push those changes to your primary server. If you are pushing Content or Media changes, you will need to ensure that your Schema elements (i.e. Document and Media Types, etc...) are identical on both environments otherwise you'll be presented with an error. You can also push schema changes via Courier between environments.



## More information
- Codegarden '15 session: [Umbraco Load Balancing](https://vimeo.com/132815038)
