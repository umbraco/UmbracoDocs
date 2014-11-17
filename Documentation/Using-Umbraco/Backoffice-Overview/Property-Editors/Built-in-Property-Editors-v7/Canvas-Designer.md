#Canvas designer
 
##What is the Canvas Designer?

The Canvas Designer is an *Umbraco* feature that allows real time styles edition.

It allows to accurately change, resize any CSS dimension by clicking the mouse, without any line of code. Any changes are immediately displayed in real-time and achieve best perfection for templating.
The Canvas Designer have a set of style editor to change colors, sizes, borders, fonts and else so on...


##Getting Started

###Enable the Canvas Designer

To active the Canvas Designer into a website, only one statement is required into the *head* tag of your main template of the site.

	@Umbraco.EnableCanvasDesigner()

It have to be place just after the stylesheet links.
	
![Canvas Designer](images/Canvas-Designer/1_.png)

###Use of the canvas designer

The Canvas Designer is located into the *Umbraco* preview mode and can be access through any page from the Website.

![Canvas Designer](images/Canvas-Designer/2.png)


The Canvas Designer option appears just below the device preview buttons, in the right side panel control.

![Canvas Designer](images/Canvas-Designer/3.png)


The first option of the Canvas Designer is the palette panel control. It consists on a set of pre-configured styles that can be apply directly to the website.
Any change is immediately displayed in real-time on the right side panel. 

![Canvas Designer](images/Canvas-Designer/4.png)


The third option of the Canvas Designer allows the element by element style edition.

![Canvas Designer](images/Canvas-Designer/5.png)


The second left panel show the element list that can be edited. 
These elements can be selected on the list or can be selected directly on the right side panel, in the preview page..

![Canvas Designer](images/Canvas-Designer/6.png)


Once an element is selected, its styles can be modified through the different styles editors available.

![Canvas Designer](images/Canvas-Designer/7.png)

To go back to the main element list, click on the burger menu at the top right corner of the second panel.

![Canvas Designer](images/Canvas-Designer/22.png)

###Save page style

The custom styles are saved by clicking on *save styles*, this action compile and minify all these styles into a ready to use. css file.
The statement @Umbraco.EnableCanvasDesigner() mentioned before will add a stylesheet link to this file into the webpage.

![Canvas Designer](images/Canvas-Designer/8.png)

![Canvas Designer](images/Canvas-Designer/9_.png)


###Create page styles

By default, custom styles are apply to the entire web site from its root node to its descendants children.
However, new custom styles can be create from a specific node of the website clicking on *Create page styles* into its preview mode
These styles will be apply from this node to all its descendants children.

![Canvas Designer](images/Canvas-Designer/10.png)


###Reset Style

Custom style can be reset clicking on *Reset Style*, this action delete the respected css file.

![Canvas Designer](images/Canvas-Designer/11.png)


##Configurations

###Canvas Designer Configurations

By default, the Canvas Designer comes with a simple configuration for the Umbraco Starter Kit styles edition. However, custom configuration can be easy done for any kind of mark-up and web design.

The Canvas designer configuration is a JSON file. Its location can be specify into the EnableCanvasDesigner statement's first parameter.

![Canvas Designer](images/Canvas-Designer/12.png)


The configuration basically defines a set of style editors that can be apply for elements:

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
	
Config has 4 parameters:

- name: (mandatory) friendly name of the element (Body / Header / Main Column ...).
- schema: (mandatory) element's selector(s) where custom style will be apply (body / h1 / p, a, span/ .main ...).
- selector: (optional) selector used for the highlight of the element (body / h1 / .header...), if empty *schema* is used instead.
- editors: (mandatory) list of style editors available for the element.

#### Editors

The Canvas Designer comes with 9 different available editors:

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
		...
	}
	
Furthermore, some editors have others additional parameters.

##### Background editor

*Alias*: background

This editor is used for edit the color and the image background.
Images are picked up from the Umbraco Media library

This editor doesn't have additional parameters
 
![Canvas Designer](images/Canvas-Designer/13.png)
 
##### Border editor

*Alias*: border

This editor is used for edit element borders.

*Parameters*:

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}
	
![Canvas Designer](images/Canvas-Designer/14.png)

##### Color editor

*Alias*: color

This editor is used for edit color (font, border, background...).

*Parameters*:

	{
		...
		css: "..."	// mandatory, css tag use to apply the color (color, border-color, background-color ...) 
	}

![Canvas Designer](images/Canvas-Designer/15.png)
	
##### Googlefontpicker editor

*Alias*: googlefontpicker

This editor is used for edit web and googlefont family.

This editor doesn't have additional parameters

![Canvas Designer](images/Canvas-Designer/16.png)

##### Margin editor

*Alias*: margin

This editor is used for edit element margins.

*Parameters*:

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}
	
![Canvas Designer](images/Canvas-Designer/17.png)
	
##### Padding editor

*Alias*: padding

This editor is used for edit element paddings.

*Parameters*:

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}

![Canvas Designer](images/Canvas-Designer/18.png)
	
##### Radius editor

*Alias*: radius

This editor is used for edit element border radius.

*Parameters*:

	{
		...
		enable: ["top", "bottom"...] 	// optional, which edge can be editable: "all", "left", "right", "top", "bottom"
	}
	
![Canvas Designer](images/Canvas-Designer/19.png)
	
##### Shadow editor

*Alias*: shadow

This editor is used for edit element border radius.

This editor doesn't have additional parameter

![Canvas Designer](images/Canvas-Designer/20.png)

##### Slide editor

*Alias*: slide

This editor is used for edit any kind of css size (margin, font size, padding, width, height...).

*Parameters*:

	{
		...
		css: "..."	// mandatory, css tag use to apply the size (margin, font-size, width ...) 
		min: 18,	// mandatory, min size in pixel 
		max: 100	// mandatory, max size in pixel 
	}

![Canvas Designer](images/Canvas-Designer/21.png)
	
### Palette Configurations

Pre-configured palette setting can be modified into another JSON file, its path can be specified in the second parameters of the EnableCanvasDesigner statement.

![Canvas Designer](images/Canvas-Designer/23.png)












