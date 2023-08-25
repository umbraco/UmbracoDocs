---
description: Configuring encrypted properties in Konstrukt, the backoffice UI builder for Umbraco.
---

# Encrypted Properties

There are times when you may need to collect sensitive information in a collection however don't want to persist this in a plain text format to the data storage mechanism. Konstrukt can help with this by allowing you to define properties as encrypted after which any time the value is persisted or retrieved from persistence, Konstrukt will automatically encrypt and decreypt the value.

{% hint style="info" %}
Konstrukt uses the `IDataProtectionProvider` instance registered in the DI container to perform it's encryption / decription. If you need to change the encryption alogirithm, you should replace the `IDataProtectionProvider` instance in the the DI container.
{% endhint %}

## Defining encrypted properties

#### **AddEncryptedProperty(Lambda encryptedPropertyExpression) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds the given property to the encrypted properties collection. Property must be of type `String`. When set, the property will be encrypted/decrypted on write/read respectively.

````csharp
// Example
collectionConfig.AddEncryptedProperty(p => p.Secret);
````