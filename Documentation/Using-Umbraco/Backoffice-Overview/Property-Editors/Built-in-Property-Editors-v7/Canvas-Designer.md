#Canvas designer

##What is this?

The Canvas Designer is a new feature of Umbraco that allows real time styles editing.
This is a set of style editors that can be applied directly to the web pages of your site without any css coding. 

##Getting Started

###Enable the canvas designer

To active the canvas designer, first place @Umbraco.EnableCanvasDesigner() into the head tag of your main template just after your stylesheet links.

![Canvas Designer](images/Canvas-Designer/1.png)

###Access and use the canvas designer

You can now access the Canvas Designer through the preview mode of any page of your Website.

![Canvas Designer](images/Canvas-Designer/2.png)

A new Canvas Designer option appears just below the device buttons into the right side panel control.

![Canvas Designer](images/Canvas-Designer/3.png)

First, you access the Canvas Designer palette panel control. It consists on a set of pre-configured styles that can be apply directly to the website.

![Canvas Designer](images/Canvas-Designer/4.png)

The third option allow us to edit into detail the style of the website.

![Canvas Designer](images/Canvas-Designer/5.png)

The first panel show the list of element witch can be edited. 
We can select them through the list or selecting the highlight element at the right sight into the frontend panel.

![Canvas Designer](images/Canvas-Designer/6.png)

Once an element selected, we can edit its styles through the different styles editors.

![Canvas Designer](images/Canvas-Designer/7.png)

###Save page style

You can save your costumed styles at any time just clicking on save style, this action compile and minify all these styles into a css file ready to use.
The statement @Umbraco.EnableCanvasDesigner() mentioned before take care to add a link to this file into the live mode.

![Canvas Designer](images/Canvas-Designer/8.png)

![Canvas Designer](images/Canvas-Designer/9.png)

###Create page styles

By default, when you access the canvas designer, the style are apply to the entire web site from its root node and descendants children.
You can also create new custom style from another node of your website just clicking on "Create page styles"
These style will be apply from this node to all its descendants children.

![Canvas Designer](images/Canvas-Designer/10.png)

###Reset Style

You can reset costumed style clicking on "Reset Style", this action delete the respected css file.

![Canvas Designer](images/Canvas-Designer/11.png)

##Configurations

###Canvas Designer Configurations

By default, the canvas designer comes with a simple configuration which allows the style edition of the Umbraco Starter Kit. But you can easily create you own configuration for the style edition of you own Website.

The configuration of the Canvas designer is a Json file that can be specify into the first parameter of the EnableCanvasDesigner statement.

![Canvas Designer](images/Canvas-Designer/12.png)

The configuration defines basically the set of style editors that can be use for the web site

	var canvasdesignerConfig = {
    configs: [{
        name: "Body",
        schema: "body",
        selector: "body",
        editors: [
            {
                type: "background",
                category: "Color",
                name: "Background",
            },
			.
			.
			.
		]}
	}
	
Each config have 4 parameters:

- name: (mandatory) friendly name of the element editable (Body / Header / Main Column ...).
- schema: (mandatory) default selector(s) on that style will be apply (body / h1 / p, a, span/ .main ...).
- selector: selector used for the highlight of the element (body / h1 / .header...), if empty *schema* is used instead.
- editors: list of editors that can be used for the element.

#### Editors

By default 9 different editors can be used:

- background
- border
- color
- googlefontpicker
- margin
- padding
- radius
- shadow
- slider

The base parameters of these editor are:

	{
		type: "...",     // mandatory, alias of the editor (background, border...)
		category: "...", // mandatory, string that describe the category of the editor (color, position...)
		name: "..."      // mandatory, friendly name of the editor (Background, Background color ...)
		schema: "..."	 // optional, overwrite the schema parameter of the conig
	}
	
Each editor can also additional parameters.

##### background

This editor doesn't have additional parameter
 
##### border

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}

##### color

	{
		...
		css: "..."	// mandatory, css tag use to apply the color (color, border-color, background-color ...) 
	}

##### googlefontpicker

This editor doesn't have additional parameter

##### margin

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}
	
##### padding

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}

##### radius

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}
	
##### shadow

This editor doesn't have additional parameter

##### slide

	{
		...
		css: "..."	// mandatory, css tag use to apply the size (color, border-color, background-color ...) 
		min: 18,	// mandatory, min slide in pixel 
		max: 100	// mandatory, max slide in pixel 
	}

### Palette Configurations















