---
description: Configuring encrypted properties in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Encrypted Properties

If needed to collect sensitive information in a collection but don't want to persist in a plain text format to the data storage mechanism. Umbraco UI Builder can help with this by allowing you to define properties as encrypted. After which any time the value is persisted or retrieved from persistence, Umbraco UI Builder will automatically encrypt and decrypt the value.

{% hint style="info" %}
Umbraco UI Builder uses the `IDataProtectionProvider` instance registered in the DI container to perform its encryption/decryption. If you need to change the encryption algorithm, you should replace the `IDataProtectionProvider` instance in the DI container.
{% endhint %}

## Defining encrypted properties

### **AddEncryptedProperty(Lambda encryptedPropertyExpression) : CollectionConfigBuilder&lt;TEntityType&gt;**

Adds the given property to the encrypted properties collection. Property must be of type `String`. When set, the property will be encrypted/decrypted on write/read respectively.

````csharp
// Example
collectionConfig.AddEncryptedProperty(p => p.Secret);
````
