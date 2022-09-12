# Migrate to new Certificate Authority for custom hostnames

The following changes in Certificate Authority (CA) used to issue certificates for all Umbraco Cloud sites' for new and existing custom hostnames.

## Certificates for new custom hostnames

On September 26th, 2022 certificates will be issued using  'Google Trust Services' instead of 'DigiCert', and Certificate validity will be decreased from 1 year to 90 days.

## Certificates for existing custom hostnames

From October 31st Certificate renewals will no longer use 'DigiCert' as the issuing CA. The renewed certificate will instead be issued by 'Google Trust Services',  and Certificate validity will be decreased from 1 year to 90 days.

No action is required unless you set a Certificate Authority Authorization (CAA) record on your domain.

From October 31st 2022 Certificate renewals will no longer use 'DigiCert' as the issuing CA. This means that you need to update your CAA record to allow 'Google Trust Services' issuing certificates for your domain.

The CAA record should be changed from:

```sql
example.com. IN CAA 0 issue "digicert.com"
```

to

```sql
example.com. IN CAA 0 issue "pki.goog"
```
