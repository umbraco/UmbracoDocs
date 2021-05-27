---
versionFrom: 8.0.0
---

# Reset admin password

This guide assumes you can't use the 'Forgotten password?' link in the login screen to receive a password reset email, or that the Forgotten password link isn't present on the login screen. 

This also assumes access to the website database if you need to confirm the admin user's email address and also that you have access to change configuration settings in the `web.config` file. Usually this would be done running on a local PC.

We are not going to send an email, but instead generate the email and use the link from the email to reset the password.

This technique will also work for Umbraco versions 7.5.15 and above

## Step one: Confirm the default admin user email address

*Skip this step if you already know any admin user's email address*

There is one default admin user in any Umbraco installation. This is the first user of the system.

Open the database and go to the `umbracoUser` database table.
Search for the user where the column `id` equals `0`.
Note the email address from the `userEmail` column.

## Step two: Configure the SMTP settings

If the login screen shows a 'Forgotten password?' link you can send a password reset email, but you can avoid sending an email and capture it locally. You can do this one of two ways:

- Method A: Set a local directory where the email will be saved.
- Method B: Run a proxy program like 'Papercut SMTP' https://github.com/ChangemakerStudios/Papercut-SMTP/releases or 'smtp4dev' https://github.com/rnwood/smtp4dev/releases which will capture the email.


### Method A: Using a pickup directory

Open the web.config file at the root of your site.
locate the section `<mailsettings>` and configure the `deliveryMethod` and specify an existing location for the email to be saved.
    
```xml
<smtp deliveryMethod="SpecifiedPickupDirectory">
    <specifiedPickupDirectory pickupDirectoryLocation="c:\temp\maildrop\"/>
</smtp>
```

Don't forget to remove the xml comment lines around the smtp section if they are present.

You can then submit the Forgotten password form and use the link in the email in your designated pickup directory to reset your password.

![03 maildrop folder](https://user-images.githubusercontent.com/13945979/119894715-d9e80c00-bf34-11eb-8a2d-c7b29724d420.png)

### Method B: Using a proxy to capture the email

Open the web.config file at the root of your site.
Locate the section `<mailsettings>` and configure the `host` and `from` properties.

You may need to uncomment the <smtp> section by removing the start and end comment lines immediately before and after this section:
    
```xml
 <!--
<smtp from="noreply@example.com" deliveryMethod="Network">
    <network host="localhost" port="25" enableSsl="false" userName="" password="" />
</smtp>
-->   
```

You must also change the `from` address or the link will not be displayed.
   
```xml
<smtp from="reply@example.com" deliveryMethod="Network">
    <network host="localhost" port="25" enableSsl="false" userName="" password="" />
</smtp>
```

You can then start you proxy program, submit the Forgotten password form, and use the link in the email to reset your password.

![01 smtp4dev](https://user-images.githubusercontent.com/13945979/119894876-1287e580-bf35-11eb-9579-a8f8c6b2dc1d.png)

![02 password reset email](https://user-images.githubusercontent.com/13945979/119894895-19165d00-bf35-11eb-905c-5ae9901502ab.png)
