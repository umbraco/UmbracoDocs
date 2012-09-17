#Multi-Node Tree Picker

`Returns: XML or CSV`

The multi-node tree picker data type allows your content editor to choose multiple nodes in the content or media trees to be saved with the current document type. This is useful for all sorts of situations such as relating a page to numerous other pages, creating a list of images/files from the media section, etc...

##Settings

There are a lot of settings for the Multi-Node tree picker, there are also some settings which determine which further settings are displayed.

###Select tree type

This setting determines if the data type will allow users to pick from either content or media. Changing this setting determines further settings in the property editor as detailed below.

![Media Picker Data Type Definition](images/MNTP-Settings-SelectTree.jpg?raw=true)

###Node selection type 
*This setting is only available when "Select tree type" setting is set to "Content".*

This setting determines if the tree picker nodes are selected by a particular parent node or by using a XPath expression.

![Media Picker Data Type Definition](images/MNTP-Settings-NodeSelectionType.jpg?raw=true) 

###XPath Type

*This setting is only available when "Select tree type" setting is set to "Content" and "Node selection type" is set to "XPath Expression".*

![Media Picker Data Type Definition](images/MNTP-Settings-XPathType.jpg?raw=true) 

###XPath expression
*This setting is only available when "Select tree type" setting is set to "Content" and "Node selection type" is set to "XPath Expression".*

![Media Picker Data Type Definition](images/MNTP-Settings-XPathExpression.jpg?raw=true) 

###Start node ID

*This setting is only available when "Select tree type" setting is set to "Content" and "Node selection type" is set to "Node Picker" or "Select tree type" is set to "Media".*

![Media Picker Data Type Definition](images/MNTP-Settings-StartNodeID.jpg?raw=true) 

###Show thumbnails for media items?

*This setting is only available when "Select tree type" setting is set to "Media".*

![Media Picker Data Type Definition](images/MNTP-Settings-Thumbs.jpg?raw=true) 

###XPath filter type

![Media Picker Data Type Definition](images/MNTP-Settings-XPathFilterType.jpg?raw=true) 

###XPath filter

![Media Picker Data Type Definition](images/MNTP-Settings-XPathFilter.jpg?raw=true) 

###Maximum node selections

![Media Picker Data Type Definition](images/MNTP-Settings-MaxNodes.jpg?raw=true) 

###Minimum node selections

![Media Picker Data Type Definition](images/MNTP-Settings-MinNodes.jpg?raw=true) 

###Show tooltip for selected item

![Media Picker Data Type Definition](images/MNTP-Settings-Tooltip.jpg?raw=true) 

###Data as CSV or XML?

![Media Picker Data Type Definition](images/MNTP-Settings-Tooltip.jpg?raw=true) 

###Pixel height of the tree control box

![Media Picker Data Type Definition](images/MNTP-Settings-Height.jpg?raw=true)

##Data Type Definition Example

![Media Picker Data Type Definition](images/MNTP-DataType.jpg?raw=true)

##Content Example 

##XSLT Example

##Razor (DynamicNode) Example

