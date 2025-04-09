---
description: Configuring and using encrypted properties in Umbraco UI Builder to securely store sensitive data.
---

# Encrypted Properties

Umbraco UI Builder allows encrypting properties to store sensitive information securely. When a property is marked as encrypted, its value is automatically encrypted before storage and decrypted upon retrieval.

{% hint style="info" %}
Umbraco UI Builder uses the `IDataProtectionProvider` instance registered in the DI container for encryption and decryption. To modify the encryption algorithm, replace the `IDataProtectionProvider` instance in the DI container.
{% endhint %}

## Defining Encrypted Properties

### Using the `AddEncryptedProperty()` Method

Encrypts the specified property. The property must be of type `String`. The value is encrypted before storage and decrypted when retrieved.

#### Method Syntax

```csharp
AddEncryptedProperty(Lambda encryptedPropertyExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.AddEncryptedProperty(p => p.Secret);
````
