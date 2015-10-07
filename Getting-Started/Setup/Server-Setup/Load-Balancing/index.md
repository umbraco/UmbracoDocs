#Umbraco in Load Balanced Environments

_Information on how to deploy Umbraco in a Load Balanced scenario and other details to consider when setting up Umbraco for load balancing._

##Overview

Configuring and setting up a load balanced server environment requires planning, design and testing. This document should assist you in setting up your servers, load balanced environment and Umbraco configuration.

This document assumes that you have a fair amount of knowledge about:

* Umbraco
* IIS 7+
* Networking & DNS
* Windows Server (2008/2012)
* .NET Framework

__It is highly recommended that you setup your staging environment to also be load balanced so that you can run all of your testing on a similar environment to your live environment.__

##Flexible load balancing

With Umbraco version 7.3.0, load balancing is easier than ever before.
Setting up a load balanced environment is reasonably easy to acheive and can be done with only a few configuration file changes.

[Full documentation is available here](flexible.md)  

##Traditional load balancing

Umbraco versions before 7.3.0 must use a traditional load balancing technique.

[Full documentation is available here](traditional.md)  

##ASP.NET Configuration

* You will need to use a custom machine key so that all your machine key level encryption values are the same on all servers, without this you will end up with view state errors, validation errors and encryption/decryption errors since each server will have its own generated key.
	* Here are a couple of tools that can be used to generate machine keys:
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

##Logging

There are some logging configurations to take into account no matter what type of load balancing environment you are using.

[Full documentation is available here](logging.md)

###More information
- Codegarden '15 session: [Umbraco Load Balancing](https://vimeo.com/channels/939955/132815038)
