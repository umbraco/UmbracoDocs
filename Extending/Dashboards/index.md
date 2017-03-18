#Dashboard

As with the other .config files in the /config directory the Dashboard.config file lets you customize a portion of the Umbraco experience.  In this case the Dashboard.config file controls what shows up in the Dashboard section of the UI when a section of the site loads.  The Dashboard is the area on the right side of the UI where most of the data entry and functional interaction takes place.

By default, Umbraco shows a blank Dashboard when a new section loads and only shows a form when you take action within the section (i.e. when you click on a node in the Content section, the Dashboard shows the form to update that node's data). But what if you wanted to present your UI users with some options even before they click on a node?  Well that is what the Dashboard.config allows you to do.

## Layout ##

Like the other .config files Dashboard.config is a simple XML file with a fairly straight-forward layout as seen below.

	<?xml version="1.0" encoding="utf-8" ?> 
	<dashBoard> <!-- root of the dashboard xml tree -->
	   <section>  <!-- defines a dashboard layout for a group of sections -->
	        <areas> <!-- Declares which sections (i.e. content,media,users,[your own]-->
                <area>[area name]</area> <!-- A section to apply this to -->
                ...
	        </areas>
	
	        <tab caption="[caption]"> <!-- Creates a tab in the Dashboard with the assigned Caption -->
                <control>[path]</control> <!-- What control(v6) / angularJs View (v7) to load in that tab -->
	        </tab>
	        ...
	   </section>
	   ...
	</dashBoard>

## Section (different from a Umbraco UI Section) ##

Delimits dashboard information to apply to one or more sections.  The Dashboard.config may include multiple sections.

## Areas ##

Defines to which sections of the Umbraco UI to apply the subset of dashboard information.
area - Always lowercase!

The name* of the Umbraco UI Section where you want your user control to be displayed (e.g. content, media, developer, settings, members or a custom section name). You can add your controls to more than one section by adding multiple <area> nodes.

The area with the name 'default' is the first dashboard shown when a user login, no matter which sections the user have access to!

**A little gotcha**, make sure you include the name of your app in lowercase! 

## Tab ##

Defines a page tab that you would like your user control to be added to. The attribute 'caption' defines the text displayed on the tab.  There can be multiple tabs for each Dashboard "page"
control/view

## Control ##

In Umbraco 6, this setting defines the path to the user control you would like to be displayed on a tab. 
In Umbraco 7 this is the path to an angularJS view.

## Access / Permissions##

The <access /> element makes it possible to set permissions on sections, tabs and controls and you can either grant or deny certain usertypes access.

It works by adding an `<access/>` node under either a `<section />`, `<tab/>` or `<control />` node. 

As children of <access /> you can either add `<grant />` which grants permissions to those types of users (AND automatically deny access to those who are not there!)

`<grantBySection />` which grants permissions to those users who got access to specific sections. This can be useful for more granular permissions

`<deny />` which denies permissions to those types of users (AND automatically grants everyone else)

No matter the settings the root user (id:0) can see everything, so don't panic if you set deny permissions for administrators and they are still are able to see everything ;-)

Example on permissions:

	<tab caption="Last Edits">
	    <access>
            <grant>writer</grant>
            <grant>editor</grant>
            <grantBySection>content</grantBySection>
	    </access>
	    <control>/usercontrols/dashboard/latestEdits.ascx</control>
	</tab>

## Customizing ##

In order to customize the dashboard in Umbraco, one needs to do a couple of things.
Create one or more UserControls

The Dashboard loads one or more UserControls and displays them on a series of tabs.  So in order to customize the control, one needs to first create the UserControls that are to be displayed on the page.  If these are for your own personal use you can just place the UserControls in a location on your site that can be accessed by Umbraco.  It is recommended that you place them in the /usercontrol directory, preferably in your own subfolder.  If you are creating a package for others to use, you should include the usercontrols in the package for install with the rest of the package contents.
Update the Dashboard.config

Once you have created the UserControls that you want to have loaded when a section loads, you must then update the Dashboard.config to tell Umbraco to load your UserControls when a user enters a new section.  Again if you are doing this for yourself all you need to do is edit the Dashboard.config on your site to add the controls.  However, if you are adding a section to go with a package, you will want to include a Package Action to update the Dashboard.config during install.  Click here for more information on Package Actions.
Sample

Below is an example of a valid Dashboard.config:

	<?xml version="1.0" encoding="utf-8" ?> 
	<dashBoard>
	    <section>
		    <areas>
		    	<area>content</area>
		    </areas>		
		    <tab caption="Last Edits">
	            <access>
	            	<deny>editor</deny>
	            </access>
		        <control>/usercontrols/dashboard/latestEdits.ascx</control>
		    </tab>
		    <tab caption="Latest Items">
		    	<control>/usercontrols/dashboard/newestItems.ascx</control>
		    </tab>
		    <tab caption="Create blog post">
		    	<control>/usercontrols/umbracoBlog/dashboardBlogPostCreate.ascx</control>
		    </tab>
		</section>
	</dashBoard>

What this does is every time a user clicks on the Content section of the Umbraco UI (the sections are in the lower left of the screen) it loads a page with three tabs called "Last Edits", "Latest Items" and "Create blog post".  For each tab a UserControl is loaded to provide the functionality that the developer created for those tabs.  The UI finds the UserControls via the paths provided.
