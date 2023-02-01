---
keywords: base v6 version6
versionFrom: 6.0.0
needsV8Update: "true"
meta.RedirectLink: "/umbraco-cms/reference/routing/umbraco-api-controllers"
---

:::warning
If you're using Umbraco 7 you should consider using Umbraco Web API instead of /Base since it's deprecated and only kept for backwards compatibility. Please see the documentation on Umbraco Web API here: https://our.umbraco.com/documentation/Reference/Routing/WebApi/
:::

# BaseRestExtension.config

BaseRestExtension.config contains the data necessary for the /Base system when exposing the methods in your class library.

```xml
<?xml version="1.0" encoding="utf-8"?>
<BaseRestExtensions>
    <extension alias="aliasName" type="the.fully.qualified.name, assemblyName">
        <method name="Hello" returnXml="false" allowAll="true"></method>
    </extension>
</BaseRestExtensions>
```

It contains one extension tag for each class you want the /Base system to expose, and the method tags for each method you want the /Base system to expose.

The extension tag contains the following attributes:

- `type`: The fully qualified name of the class containing the methods you want to expose via /Base
- `alias`: The name that /Base will use when mapping urls to your class. If you put "MyAlias" here, the url will start with: yourdomainname/Base/MyAlias.

The method tag contains the following attributes:

- `name`: The name of the method in your class, this has to correspond exactly with the name in the code. It is not possible to make aliases for the methods.
- `allowAll`: If this attribute is set to "true", there will be no restrictions on who will be able to call this method.
- `allowGroup`: This attribute can contain a comma separated string of user group names that will be allowed to call this method.
- `allowType`: This attribute can contain a comma separated string of user type names that will be allowed to call this method.
- `allowMember`: This attribute can contain the id of a single user allowed to call this method.
- `returnXml`: if set to false, Umbraco will not wrap the result of the method in a <value> element.

The user calling the method, will be allowed if they has access through at least one of the possible attribute values. If allowAll is set to true, the other attributes has no effect, everyone will be allowed.

### Example

_BaseRestExtensions.config_

```xml
<?xml version="1.0" encoding="utf-8"?>
<BaseRestExtensions>
  <extension alias="test" type="BaseTest.TestClass,basetest">
    <method name="Hello" returnXml="false" allowAll="true"></method>
  </extension>
</BaseRestExtensions>
```

_BaseTest.cs_

```csharp
namespace BaseTest {
    public class TestClass {
        public static string Hello() {
            return "Hello World";
        }
    }
}
```

Visit the /base url. For example: http://example.com/base/test/Hello/.

    Hello World

**Also check out the examples included with Umbraco:**
- [BaseRestExtensions.config](https://github.com/umbraco/Umbraco-CMS/blob/v7/dev/src/Umbraco.Web.UI/config/BaseRestExtensions.config)
- [MemberRest.cs](https://github.com/umbraco/Umbraco-CMS/blob/v7/dev/src/Umbraco.Web/BaseRest/MemberRest.cs)
