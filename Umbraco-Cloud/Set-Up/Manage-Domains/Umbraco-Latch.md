# Umbraco Latch

All new projects on Umbraco Cloud are automatically protected by Umbraco Latch. This means, that the default Umbraco Cloud URL for your project as well as any new hostnames you add will be assigned a TLS certificate automatically.

![Adding a hostname](images/adding-hostname-to-cloud.gif)

In order for Umbraco Latch to be applied to your hostname, you need to make sure you have either of the following:

* DNS has been setup with a CNAME pointing at the Cloud URL (mysite.s1.umbraco.io)
* DNS has been setup with an A-Record pointing at the Cloud IP (23.100.15.180)

## Latch and CDN

You will not get an Umbraco Latch certificate if you are using a CDN service (ex. CloudFlare) on your Umbraco Cloud project.

In that case you can manually add a TLS certificate to your project instead. Read more about how to do that in the [Upload certificates manually](Security-certificates) article.

## Read more

* [Redirect from HTTP to HTTPS](Rewrites-on-Cloud#running-your-site-on-https-only)
* [Umbraco Latch on Umbraco.com](https://umbraco.com/products/umbraco-latch/)
