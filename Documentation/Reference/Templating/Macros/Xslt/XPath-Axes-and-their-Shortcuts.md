#XPath Axes and their Shortcuts

We have now learned the basics of selecting content in reference to the current page, and know the very basics of how it is used.  Now we can cover a few additional commands, and explain how they work.

XPath works on the premise of Axes, which is how the data relates to the current node.  There are several Axes listed below with graphic depictions of the results.

The following picture from Crane Softwrights demonstrates the axes graphically.

![Axes](Images/7x1B0.gif)

###Note: The following are v4.5+ XPaths
The following XPath examples are using the "new" XML Schema introduced in Umbraco v. 4.5 - In Umbraco versions before 4.5, the XML node for a document was simply named <node>, so if you need to select nodes in and older installation, replace *[@isDoc] in the following with "node" and everything should just work.

###Self Axis
While it is rarely used, the self axis actually returns the node in reference.

	$currentPage/self::*[@isDoc]

###Child Axis
We mentioned the child axis earlier, and actually used its shortcut right off.  The child axis select the nodes immediately below the node in reference.  While the verbose method is rarely used, it is here for reference.

	$currentPage/child::*[@isDoc]  
  
	$currentPage/*[@isDoc]
		
###Parent Axis
The parent axis allows us to see the node immediately above the node in reference.

	$currentPage/parent::*[@isDoc]
	$currentPage/..
	
###Descendant Axis
Next we have descendant.  The descendant axis retrieves all nodes below the node in reference no matter the depth.

	$currentPage/descendant::*[@isDoc]
	$currentPage//*[@isDoc]
	
###Descendant-or-self Axis
The descendant-or-self axis returns all nodes below the current node, but also returns the node in reference to the command.

	$currentPage/descendant-or-self::*[@isDoc]
	
###Ancestor Axis
The ancestor axis selects all nodes that are ancestors, or the parent, and the parent's parent, and so on, to the node in reference.

	$currentPage/ancestor::*[@isDoc]
	
###Ancestor-or-self Axis
The ancestor-or-self axis selects all nodes that are ancestors, or the parent, and the parent's parent, and so on, including the node in reference.

	$currentPage/ancestor-or-self::*[@isDoc]
	
###Preceding Axis
The preceding axis selects all nodes no matter the depth, that are located on parent-level and who are also located before (preceding) its parent of the node in reference.

	$currentPage/preceding::*[@isDoc]
	
###Preceding-sibling Axis
The preceding axis selects all nodes that are located on the same level who are also located before (preceding) the node in reference.

	$currentPage/preceding-sibling::*[@isDoc]
	
###Following Axis
The preceding axis selects all nodes no matter the depth, that are located on parent-level and who are also located after (following) its parent of the node in reference.

	$currentPage/following::*[@isDoc]
	
###Following-sibling Axis
The preceding axis selects all nodes that are located on the same level who are located after (following) the node in reference.

	$currentPage/following-sibling::*[@isDoc]
 

**Note: Originally copied book from Casey Neehouse, from the books section of umbraco.org**