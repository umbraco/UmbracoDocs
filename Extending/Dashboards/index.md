# Dashboards

Each section of the Umbraco backoffice has its own set of default dashboards.

The dashboard area of Umbraco is used to display an 'editor' for the selected item in the tree. If no item is selected, for example when the section 'first loads', then the default set of section dashboards are displayed in the dashboard area, arranged over multiple tabs.

![Content Section Dashboards](images/content-dashboards.png)

In the above screenshot, you can see the default set of dashboards for the Content section. For most users these will be: 'Get Started' and 'Redirect Url Management'. In the screenshot below, the Developer section has 'Get Started', 'Examine Management', 'Models Builder' and 'Health Check'.

![Developer Section Dashboards](images/developer-dashboards.png)

The different sections, dashboards and their configuration (sort order and users rights) are all configured in the [/config/dashboards.config](../../Reference/Config/dashboard/index.md) file.

## Configuration Example

```xml
<?xml version="1.0" encoding="utf-8" ?> 
<dashBoard> <!-- Root of the dashboard XML tree -->
	<section>  <!-- Defines a dashboard layout for a group of sections -->
		<areas> <!-- Declares which sections (i.e. content,media,users,[your own]-->
			<area>[area name]</area> <!-- A section to apply this to eg 'content' -->
			...
		</areas>

		<tab caption="[caption]"> <!-- Creates a tab in the Dashboard with the assigned caption -->
			<access><!-- control which Umbraco roles can see the tab -->
				<deny>translator</deny>
				<grant>editor</grant>
			</access>
			<control>[path]</control> <!-- path AngularJS View (v7) to load into the tab -->
		</tab>
		...
	</section>
	...
</dashBoard>
```

[More on Configuring Dashboards](../../Reference/Config/dashboard/index.md)

## Custom Dashboards

Additionally, you can create your own custom dashboards, for extending Umbraco with single page AngularJS applications, or to support your site implementation - it is considered 'good practice' to create a custom Welcome Dashboard for your Umbraco implementation to support the day-to-day activities of editors using the Umbraco backoffice with 'quick links' and 'site statistics/information'.

![Example Custom Welcome Dashboard](images/welcome-example.png)

[Check out our Creating a Custom Dashboard tutorial](../../Tutorials/Creating-a-Custom-Dashboard/index.md)

## Package Dashboards

There are lots of packages listed on <a href="/projects/?category=Backoffice%20extensions">our umbraco</a> that provide custom dashboard functionality.

For example, the snappily titled <a href="/projects/backoffice-extensions/the-dashboard/">'The Dashboard'</a> provides great information for editorial teams on what has been edited recently and by whom.

!['The Dashboard' Dashboard Package](images/the-dashboard-package.png)

