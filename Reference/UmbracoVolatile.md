---
meta.Title: "Umbraco Volatile Error"
meta.Description: "Explanation of Umbraco Volatile Error, why it occurs, and what to do about it."
---

# Umbraco Volatile Error

:::note
This article is intended for the .NET Core release of Umbraco CMS.

If you are using Umbraco 7 or 8, this article is not for you.
:::

Umbraco Volatile Errors occurs when you are trying to use a method which *should* be internal, but is left public since it's useful when testing. 

Methods marked with UmbracoVolatile may break in the future, however if you want to use the method for testing, you can use an assembly level attribute called `UmbracoSuppressVolatile`. When the attribute is applied to an assembly any occurrences of Umbraco Volatile Error will be suppressed to a warning. 


`UmbracoSuppressVolatile` is located in the `Umbraco.Core.CodeAnnotations`, however, any attribute named UmbracoSuppressVolatile 
will do the trick, if you don't have access to that specific namespace. 

## Example of suppressing Umbraco Volatile Error

```c#
    public class DemoClass
    {
	    [UmbracoVolatile]
        public void VolatileMethod()
        {
           // Volatile things here...
        }
    }
```

Assume you're trying to use the VolatileMethod which is marked as Volatile. This will throw an Umbraco Volatile Error, 
however you're only using it in a test and want to suppress the error to a warning.

To suppress the error to a warning, add the assembly level attribute by adding `[assembly: UmbracoSuppressVolatile]` above the namespace in any file within your assembly.

```c#
[assembly: UmbracoSuppressVolatile]
namespace VolatileDemo
{
    public class DemoClass2
    {
        public void Test()
        {
            var testClass = new DemoClass();
            testClass.VolatileMethod();
        }
    }
}
```

## Defining your own UmbracoSuppressVolatileAttribute

If you for some reason don't have access to the `Umbraco.Core.CodeAnnotations` namespace you can define your own attribute and it should do the trick as well. Create a class called `UmbracoSuppressVolatileAttribute` containing the following code: 

```c#
[AttributeUsage(AttributeTargets.Assembly)]
public class UmbracoSuppressVolatileAttribute : Attribute
{
}
```

Use it as described in the previous section and your project will build again.
