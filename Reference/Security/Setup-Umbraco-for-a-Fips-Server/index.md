# Setup Umbraco for a FIPS Compliant Server

_This tutorial walks through configuring Umbraco and Lucene to be FIPS compliant and serve up websites on a server with FIPS enabled._

**_Disclaimer:_** FIPS should only be added for compliance. It is **NOT** a recommended approach for added security. For more information read [Why Microsoft is not recommending "FIPS Mode" anymore.](https://blogs.technet.microsoft.com/secguide/2014/04/07/why-were-not-recommending-fips-mode-anymore/)

## What is FIPS?

The Federal Information Processing Standard (FIPS) Publication 140-2, ([FIPS PUB 140-2][1]), is a U.S. government computer security standard used to define approved cryptographic modules. The FIPS 140 standard also sets forth requirements for key generation and for key management.

Microsoft Windows has a "FIPS mode" of operation where it detects the cryptographic algorithms used by software running on it and will throw exceptions if it detects the use of non-FIPS compliant algorithms.  Using MD5 hashing is generally the biggest culprit of issues running on FIPS enabled servers.

## How can I test my site with FIPS enabled?

FIPS can be enabled through your Local Group Policy, Registry Setting, or Network Adapter setting.  For more information about how to enable FIPS mode on Windows see this tutorial: [How-to Enable FIPS on Windows][2]

## What version of Umbraco is FIPS compliant?

Umbraco 7.6.4 has implemented checks for when FIPS mode is enabled on the server that it is installed on.  When FIPS mode is detected, the cryptographic algorithms for hashing are changed to a FIPS compliant algorithm.  When FIPS mode is disabled, then Umbraco uses backwards compatible algorithms (MD5) so as not to affect existing installs.  As of Umbraco version 7.6.4, the FIPS compliant cryptographic algorithm used is SHA1.

## Steps to making Umbraco FIPS compliant:

While Umbraco 7.6.4+ is FIPS compliant, one of its key dependencies, Lucene.Net, requires a flag to be set in order for FIPS compliant hashing algorithms to be used. This can be done in your Umbraco project and is detailed below.

Below are the steps to get an Umbraco project able to work with FIPS mode enabled:

### 1. Upgrade to Umbraco 7.6.4+

This is the lowest version that contains the detection of FIPS mode and switches the hashing to use a FIPS compliant hash. See the general instructions for [Upgrading Existing Installs][3] in the documentation for more information and help.

### 2. Set Lucene to use a FIPS compliant hashing algorithm

Lucene.Net doesn't have automatic detection of FIPS mode, but it does have a flag that can be set to enable FIPS compliant cryptographic algorithms to be used.  Umbraco/Examine currently has a dependency on Lucene.Net version 2.9.4 as of Umbraco 7.6.4+.

To set Lucene.Net to be FIPS compliant you will create a new class in your project that will run before Umbraco Application Startup.  This class will set the SupportClass.Cryptography.FIPSCompliant to detect the current machine state and set it to True if FIPS is required.

Create the following class and place it in your Umbraco project in a location that is appropriate for your project setup:

    using System.Security.Cryptography;
    using System.Web;
    using MyProject.Events;

    [assembly: PreApplicationStartMethod(typeof(LuceneFipsFlagOnAppStartup), "Initialize")]

    namespace MyProject.Events
    {
        public sealed class LuceneFipsFlagOnAppStartup
        {
            public static void Initialize()
            {
                SupportClass.Cryptography.FIPSCompliant = CryptoConfig.AllowOnlyFipsAlgorithms;
            }
        }
    }

You will likely want to rename the Namespace to conform to your Namespacing structure.

Once you build the project, you will be ready to test.


### 3. Test with FIPS enabled

Setup a VM, VPS, or extra Windows box and enable FIPS using one of the methods described in the "[How-to Enable FIPS on Windows][2]" article referenced above.

If any third-party dependencies or packages do not support FIPS, then you will likely see an IIS error page (YSOD).  Make sure you have debug and &lt;customErrors mode="On"&gt; in the web.config to help identify the source of the problem.

### 4. Fix any issues with packages or third-party tools

It's possible that you may need to contact a package developer or company to resolve any error you find.  If the package/library is open source, then search for the hashing cryptographic modules/algorithms used and verify they are all FIPS compliant.

If you find any issues with Umbraco, please submit an issue on the Issue Tracker.

## FAQ:

__Can I install Umbraco directly on a version of Windows with FIPS mode enabled?__

Installing to the FIPS server may not work.  It's best to deploy an existing known working version to the FIPS server.

[1]:https://csrc.nist.gov/publications/PubsFIPS.html#140-2
[2]:https://www.howtogeek.com/245859/why-you-shouldnt-enable-fips-compliant-encryption-on-windows/
[3]:../../../Getting-Started/Setup/Upgrading/
[4]:https://github.com/apache/lucenenet
[5]:https://github.com/apache/lucenenet/blob/Lucene.Net_2_9_4_RC3/src/core/SupportClass.cs#L1421
