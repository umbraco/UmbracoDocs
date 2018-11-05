# Umbraco Latch

All new projects on Umbraco Cloud are automatically protected by Umbraco Latch. This means, that the default Umbraco Cloud URL for your project as well as any new hostnames you add will be assigned a TLS certificate automatically.

![Adding a hostname](images/adding-hostname-to-cloud.gif)

In order for Umbraco Latch to be applied to your hostname, you need to make sure that your DNS has been setup one of these ways:

* CNAME pointing at the Cloud URL mysite.s1.umbraco.io
* A Record pointing at the Cloud IP: 23.100.15.180

Learn more about our recommendations for DNS records in the [Manage Hostnames](index.md) article.

## HTTPS by default

All new Live sites created on Cloud since version 7.12 will automagically have a permanent redirect (301) from HTTP to HTTPS. This is achieved by a web.config transform called: `Latch.Web.live.xdt.config` - accessible in your git repository. If you'd like to remove the redirect rule (which we and [others](https://www.blog.google/products/chrome/milestone-chrome-security-marking-http-not-secure/) strongly discourage) you'll need to remove the file `Latch.Web.live.xdt.config` from projects repository and push the change to Cloud.

## Latch and CDN

You will not get an Umbraco Latch certificate if you are using a CDN service (e.g. CloudFlare) on your Umbraco Cloud project.

In that case you can manually add a TLS certificate to your project instead. Read more about how to do that in the [Upload certificates manually](Security-certificates) article.

## Note

Umbraco Latch can issue 5 certificates for a single domain per week. If this limit is exceeded, you will have to wait a week in order to regenerate the certificate for the domain. 

## Read more

* [Redirect from HTTP to HTTPS](Rewrites-on-Cloud#running-your-site-on-https-only)
* [Blog post: Introducing Umbraco Latch](https://umbraco.com/blog/introducing-umbraco-latch/)
* [Umbraco Latch on Umbraco.com](https://umbraco.com/products/umbraco-latch/)
