# HTTPS

We highly encourage the use of HTTPS on Umbraco websites especially in production environments. By using HTTPS you greatly improve the security of your website.

There are several benefits of HTTPS:

* Trust - when your site is delivered over HTTPS your users will see that your site is secured, they are able to view the certificate assigned to your site and know that your site is legitimate
* Removing an attack vector called ["Man in the middle"](https://www.owasp.org/index.php/Man-in-the-middle_attack) (or network Sniffing)
* Guards against [Phishing](https://en.wikipedia.org/wiki/Phishing), an attacker will have a hard time obtaining an authentic SSL certificate
* Google likes HTTPS, it may help your site's rankings

Another benefits of HTTPS is that you are able to use the [http2](https://en.wikipedia.org/wiki/HTTP/2) protocol if your web server and browser support it.

## Set UseSSL configuration option

Umbraco allows you to force HTTPS for all backoffice communications very easily but using the following appSettings configuration:

    <add key="umbracoUseSSL" value="true" />

This options does several things when it is turned on:

* Ensures that the backoffice authentication cookie is set to [secure only](https://www.owasp.org/index.php/SecureFlag) (so it can only be transmitted over https)
* All non-https requests to any backoffice controller is redirected to https
* All self delivered Umbraco requests (i.e. scheduled publishing, keep alive, etc...) are performed over https
* All Umbraco notification emails with links generated have https links
* All authorization attempts for backoffice handlers and services will be denied if the request is not over https

## Redirect traffic on IIS

Once you enable HTTPS for your site you should redirect all requests to your site to HTTPS, this can be done with an IIS rewrite rule. The IIS rewrite module needs to be installed for this to work, most hosting providers will have that enabled by default.

In your `web.config` find or add the `<system.webServer><rewrite><rules>` section and put the following rule in there. This rule will redirect all requests for the site http://mysite.com URL to the secure https://mysite.com URL and respond with a permanent redirect status.

    <rule name="HTTP to HTTPS redirect" stopProcessing="true">
        <match url="(.*)" />
        <conditions>
            <add input="{HTTPS}" pattern="off" ignoreCase="true" />
            <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
        </conditions>
        <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
    </rule>

Note that the rule includes an ignore for `localhost`. If you run your local environment on a different URL than `localhost` you can add additional ignore rules. Additionally, if you have a staging environment that doesn't run on HTTPS, you can add that to the ignore rules too.

## SSL versus TLS

*In HTTPS, the communication protocol is encrypted using Transport Layer Security (TLS), or, formerly, its predecessor, Secure Sockets Layer (SSL)* - [wikipedia](https://en.wikipedia.org/wiki/HTTPS)

While the deprecated SSL (2.0 and 3.0) are not supported anymore by modern browsers, some of the Umbraco configuration still uses SSL. But rest assured, that is only the name. The Umbraco team takes security serious since ages, but no-one ever thought of changing name of the setting.
