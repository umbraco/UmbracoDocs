# Migrate to new Certification Authority Authorization (CAA) for custom hostnames

The following changes in CAA used to issue certificates for all Umbraco Cloud sites' for new and existing custom hostnames.

{% hint style="info" %}
**Not sure if your Cloud project is using a CAA record or not?**

You can use this [CAA Test](https://caatest.co.uk/) to check whether a CAA record is configured on your hostname(s).
{% endhint %}

## Certificates for new custom hostnames

Starting September 26, 2022, certificates are issued by **Google Trust Services** instead of **DigiCert**. The validity period of certificates has been reduced from one year to 90 days.

## Certificates for existing custom hostnames

From October 31, 2022, certificate renewals will no longer use 'DigiCert' as the issuing CA. The renewed certificate will instead be issued by 'Google Trust Services',  and certificate validity will be decreased from 1 year to 90 days.

No action is required unless you set a Certificate Authority Authorization (CAA) record on your domain.

From October 31, 2022, Certificate renewals will no longer use 'DigiCert' as the issuing CA. This means that you need to update your CAA record to allow 'Google Trust Services' issuing certificates for your domain.

The CAA record should be changed from:

```sql
example.com. IN CAA 0 issue "digicert.com"
```

to

```sql
example.com. IN CAA 0 issue "pki.goog"
```
