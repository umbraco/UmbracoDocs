#The restExtensions.config file

***NOTE**: this configuration file does not exist in v7+. This has been superseded by [BaseRestExtensions.config](../BaseRestExtensions/index.md) from v4.10+.*

As mentioned in the [simple /base example page](../../../Reference/Api/Base/HelloWorld.md) this file contains the data necessary for the /Base system when exposing the methods in your class library.

The config file follows the following structure:
	
	<RestExtensions>
	  <ext assembly="" type="" alias="">
	    <permission method="" returnXml="false/true" allowAll="true" allowGroup="" allowType="" allowMember="" />
	    .
	    .
	    <permission />
	  </ext>
	  .
	  .
	  <ext></ext>
	</RestExtensions>

It contains one **ext** tag for each class you want the /Base system to expose, and the **ext** tags contains one **permission** tag for each method you want the /Base system to expose
The ext tag

##The ext tag contains the following attributes:

- **assembly**: The name of your assembly - usually the filename of the class library output without the .dll extension. 
- **type**: The fully qualified name of the class containing the methods you want to expose via /Base
- **alias**: The name that /Base will use when mapping url's to your class. If you put "MyAlias" here, the url will start with: yourdomainname/Base/MyAlias.
The permission tag

##The permission tag contains the following attributes:

- **method**: The name of the method in your class, this has to correspond exactly with the name in the code. It is not possible to make aliases for the methods.
- **allowAll**: If this attribute is set to "true", there will be no restrictions on who will be able to call this method.
- **allowGroup**: This attribute can contain a comma separated string of user group names that will be allowed to call this method.
- **allowType**: This attribute can contain a comma separated string of user type names that will be allowed to call this method.
- **allowMember**: This attribute can contain the id of a single user allowed to call this method.
- **returnXml**: if set to false, Umbraco will not wrap the result of the method in a <value> element

The user calling the method, will be allowed if she has access through at least one of the possible attribute values. If allowAll is set to true, the other attributes has no effect, everyone will be allowed. 

The methods in your class library will only be exposed of there is a permission tag for the method.
