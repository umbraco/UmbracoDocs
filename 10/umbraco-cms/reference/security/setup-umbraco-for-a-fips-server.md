---


---

# Setup Umbraco for a FIPS Compliant Server

_This tutorial walks through configuring Umbraco and Lucene to be FIPS compliant and serve up websites on a server with FIPS enabled._

{% hint style="warning" %}
FIPS should only be added for compliance. It is **not** a recommended approach for added security. For more information read [Why Microsoft is not recommending "FIPS Mode" anymore.](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/why-we-8217-re-not-recommending-8220-fips-mode-8221-anymore/ba-p/701037)
{% endhint %}

## What is FIPS?

The Federal Information Processing Standard (FIPS) Publication 140-2, ([FIPS PUB 140-2][1]), is a U.S. government computer security standard used to define approved cryptographic modules. The FIPS 140 standard also sets forth requirements for key generation and for key management.

Microsoft Windows has a "FIPS mode" of operation where it detects the cryptographic algorithms used by software running on it and will throw exceptions if it detects the use of non-FIPS compliant algorithms.  Using MD5 hashing is generally the biggest culprit of issues running on FIPS enabled servers.

## How can I test my site with FIPS enabled?

FIPS can be enabled through your Local Group Policy, Registry Setting, or Network Adapter setting.  For more information about how to enable FIPS mode on Windows see this tutorial: [How-to Enable FIPS on Windows][2]

## What version of Umbraco is FIPS compliant?

Umbraco 7.6.4+ has implemented checks for when FIPS mode is enabled on the server that it is installed on.  When FIPS mode is detected, the cryptographic algorithms for hashing are changed to a FIPS compliant algorithm. When FIPS mode is disabled, then Umbraco uses backward compatible algorithms (MD5) so as not to affect existing installs. As of Umbraco version 7.6.4, the FIPS compliant cryptographic algorithm used is SHA1.

## Umbraco 9.0.0 and key dependencies are FIPS compliant

Since Umbraco 9, the dependency to Lucene.NET is updated to version 4+. Thereby are both Umbraco and all key dependencies FIPS compliant.

## FAQ

__Can I install Umbraco directly on a version of Windows with FIPS mode enabled?__

Installing to the FIPS server may not work.  It's best to deploy an existing known working version to the FIPS server.

[1]:https://csrc.nist.gov/publications/PubsFIPS.html#140-2
[2]:https://www.howtogeek.com/245859/why-you-shouldnt-enable-fips-compliant-encryption-on-windows/
[3]:../../fundamentals/setup/upgrading/
