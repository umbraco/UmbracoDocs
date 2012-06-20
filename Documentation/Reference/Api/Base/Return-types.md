# Return types for the /Base system

As shown in the simple /base samples, a class library type for use with /base needs to contain some methods that are both public and static. /base will return an error if you attempt to call a method that does not meet these requirements.

If the /base system encounters an error or exception during the execution of your code it will return an error message embedded in an error tag like this:

`<error>Method has to be public and static</error>`

Your methods can have almost any return type. Base will convert your type to a string and return the result of the conversion. The string representation of your return type is produced by calling ToString() on the return type, which in many cases amounts to the name of the type.

The only exception to this rule is your method returns a System.Xml.XPath.XPathNodeIterator, in which case /base will return the OuterXml of the Xml content of the XPathNodeIterator.

If your method returns a XPathNodeIterator /Base will return the xml resulting from a call to XPathNodeIterator.Current.OuterXml, which enables you to return the exact xml content you wish if you put your xml in a XPathNodeIterator before returning it from you method. Since Umbraco 4.6 you can also return an [XmlDocument](http://msdn.microsoft.com/en-us/library/system.xml.xmldocument.aspx) and [XDocument](http://msdn.microsoft.com/en-us/library/system.xml.linq.xdocument.aspx).

Your class library will typically have the following structure:

    namespace MyNameSpace { 
      public class MyClass {
        public static string MyStringMethod() {
          // Code here that returns a string
        }
        public static XPathNodeIterator MyXmlMethod() {
          // Code that returns a XPathNodeIterator here
        }
      }
    }

If your method returns a string, or any other type that has a ToString() method, /base will return the resulting string in a set of value tags like this:

`<value>String result</value>`

 