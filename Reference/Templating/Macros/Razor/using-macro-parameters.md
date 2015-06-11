#Using macro parameters
_Covers how to use Macro parameters with Razor_

##Add a content picker parameter to a macro
Create a new macro and expand the "parameters" tab. In the parameter editor, enter the following information:
- Show: true
- Alias: nodeId
- Name: Node Id
- type: Content Picker

When you insert the macro in a page, you will now be prompted to select a page from the content tree, after inserting the macro, it will look like this in the template:

	<umbraco:macro runat="server" alias="macroAlias" nodeId="1234" />

Open the Razor file associated with the macro. the `nodeId` parameter is now available in your razor script throught the `Parameter` value, which is a `dynamic` collection of parameters passed to the macro, you can pass as many parameters as you want. 

	@*Get the nodeId parameter value *@
	var id = Parameter.nodeid;
	
 	@*Get the page with the id *@
	var page = Library.NodeById(id);

	

