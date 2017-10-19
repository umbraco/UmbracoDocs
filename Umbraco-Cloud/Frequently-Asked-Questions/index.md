# Frequently asked questions

## Testing

### Are we allowed to perform penetration tests on our Umbraco Cloud site?

Yes, we're happy for people to do penetration testing on the sites they have built on Cloud. We do ask you to please tell us about these tests beforehand so our support staff knows to look out for possible strange things happening on your site.

We are also happy to receive any test results you receive, so that we can improve security in Umbraco where necessary.

Please contact us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/). 

### Are we allowed to do (D)DOS testing on our Umbraco Cloud site?

It is strictly forbidden to attempt to do a denial of service attack on your Cloud sites.

### Are we allowed to do load testing on our Umbraco Cloud site?

We would like to talk to you beforehand about your test plan for a load test on your Cloud site.

Please contact us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/). 

## Security and encryption

### Does Umbraco Cloud support Let's Encrypt certificates?

Yes, any certificate that can be converted into a `pfx` file is supported on  Cloud.

However, we currently don't have an automated way to generate a Let's Encrypt certificate for you and bind it to your site. This means that you'll be responsible for generating a certificate every 90 days (the maximum validity period of a Let's Encrypt certificate) and updating your site with the new certificate.

Since it is easy to forget this, we recommend you use certificate monitoring tools on your site to remind you to do this.

### Does Umbraco Cloud support http/2?

The lowest version of IIS to support http/2 is version 10, which runs only on Windows Server 2016. Currently our infrastructure is limited to Windows Server 2012 R2 instances and as such we do not support http/2 directly.

As a workaround, you could consider setting up a product like CloudFlare, which offers free support for http/2 (they call it "Opportunistic Encryption") out of the box.

## Building and deploying

### Umbraco Cloud creates a SQL CE / LocalDb database for me, can I use a shared SQL Server for my development team instead?

No, you should not use a shared database for your team. Umbraco Cloud is made so that each team member can safely make any changes they need and then send them to your development environment on Cloud. Another developer can do the same and also send their changes to dev to test. Once you're happy with all of the changes, each developer can pull down the changes from development and continue working on the next change.

Not only does this promote working in small increments it also prevents two problems:

 1. If you share a database between multiple developers, [Umbraco's flexible load balancing](https://our.umbraco.org/Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/flexible) automatically kicks in. Without a proper load balancing setup this means that often you will not see changes another team member has made, potentially overwriting their changes with your own changes.
 2. Our deployment engine (Umbraco Deploy) is not made for this and your local site will quickly get out of sync with changes both developers are making. Once you push your changes up to your Cloud instance you can expect to see errors and mismatches because changes have not been saved correctly.

## Package support

### Do you support package "x" on Umbraco Cloud?

We have an indicator on each package in [the projects section of Our Umbraco](https://our.umbraco.org/projects/) which either says "Works on Umbraco Cloud" or "Untested or doesn't work on Umbraco Cloud".

If the indicator says "Works on Umbraco Cloud" then that means that Umbraco HQ has tested this package on Cloud and it works and changes made using this package are also deployable to the next environment.

If the indicator says "Untested or doesn't work on Umbraco Cloud" then we have not tested it and cannot vouch for it on Cloud. It might work, and we're happy for you to test it on Cloud. 

We're happy to hear from and work with package developers to make their packages Cloud compatible where possible. Make sure to reach out to us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/). 

### How do I make my package support Umbraco Cloud?

The biggest problem concerning Cloud support is when a package stored references to nodes, media items, or members in Umbraco.

There's 2 challenges here: 

 1. Your package is referring to an integer identifier, for example a content item with id `1023`. On the next environment that same content item exists but since the content is a bit different there, the id is `1039` instead. Umbraco Deploy needs to know how to connect the correct identifier.
 2. Even if the identifier is correct on both environments your package might rely on the other item (the one you're referring to) to exist in the next environment. So if the content item you're referring to (`1023`) does not exist on the environment where you're pushing the content to you might see errors in your package.

These problems can be solved with so-called Umbraco Deploy connectors. We've set up a project called [Umbraco Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib/) to collect these connectors together. Umbraco Deploy Contrib is included in all Cloud sites and we keep it upgraded to the latest version for every site. 

The code in the contrib project has plenty of code comments to help you understand what is going on and how you can build something like that for your own package.

If you need help with this, don't hesitate to reach out to us and we'll be happy to give you some tips.