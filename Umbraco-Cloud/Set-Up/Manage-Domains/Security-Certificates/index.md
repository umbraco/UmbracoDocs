# Upload certificates manually

Under **Manage Certificates** you'll find an option to manually upload your own certificate and assign it to one of the hostnames you've added.

Your certificates need to be **`.pfx`** format and must be set to use a password. Each certificate can then be bound to a hostname you have already added to your site. Make sure you use the hostname you will bind the certificate to as the common name (CN) when generating the certificate.

* Upload your certificate from your local machine
* Type in the password for your certificate
* Click **Upload**

## Bind certificate to hostname

* Choose your hostname from the *Hostname* dropdown
* Choose your newly uploaded certificate from the *Certificate* dropdown
* Click **Set Binding**
* You've now successfully uploaded your certificate!

![Upload and bind certificate](images/upload-bind-cert.gif)

## Read more

* [Redirect from HTTP to HTTPS](../Rewrites-on-Cloud#running-your-site-on-https-only)
