# XPathNodeIterator as return type

    umbracoBase methods also take parameters

It is also possible to pass a parameter on the "Base-enabled" method allowing you to extract different data depending on which number/string etc. that was passed to the method.

In the example below, we have a "Base-enabled" method called getMemberInfo and that method has one parameter 'memberid' of type integer. The method returns an XPathNodeIterator. 

What the example does (remember to import System.Xml and umbraco.cms.businesslogic.member), is that it pulls member properties by an id from Umbraco and presents it as xml.

    public static System.Xml.XPath.XPathNodeIterator getMemberInfo(int memberid)    
    {
        Member m = new Member(memberid);
        XmlDocument xmldoc = new XmlDocument();
        if (m != null)
        {
            XmlElement xeData = xmldoc.CreateElement("data");                                
            foreach (umbraco.cms.businesslogic.property.Property property in m.getProperties)                
            {
                XmlElement xeProperty =  
                   xmldoc.CreateElement(m.getProperty(property.PropertyType).PropertyType.Alias.ToLower());
                xeProperty.InnerText = property.Value.ToString();
                xeData.AppendChild(xeProperty);    
            }
            xmldoc.AppendChild(xeData);
        }
        return xmldoc.CreateNavigator().Select("//data");
    }

if you pass a member id (e.g.1081) to the "Base-url" like this:
http://yourdomain/Base/MemberInfo/getMemberInfo/1081.aspx

You should then be seeing output somewhat similar to this, if your member has some properties attached to it:

    <data> 
      <property1>sometext</property1> 
      <property2>sometext</property2>
      <property3>sometext</property3> 
    </data>

 