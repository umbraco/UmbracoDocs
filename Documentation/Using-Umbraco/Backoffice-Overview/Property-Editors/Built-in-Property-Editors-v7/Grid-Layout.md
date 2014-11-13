#Grid Layout

`Returns: JSON`

Gives editors a grid layout editor which allows them to insert different types of content in a predefined layout

![Grid layouts](images/Grid-Layout/editor.png)



##What are grid layouts?
To understand how the grid layout editor works, we must first understand the structure of the grid.

The grid consists of two main areas that need to be configured, *grid layouts* and *grid rows*.

####Grid Layout	
The *layout area* is where the overall page layout is defined. 
*Layout areas* are divided in to *layout sections* e.g. a sidebar section and content section	. The size of the *layout sections* is defined in columns. For a full-width content area use max number of columns (12 for Bootstrap 3). Each *layout section* contains one or more *rows*
![Grid rows](images/Grid-Layout/Grid-layout-rows.jpg)

####Grid Rows
Grid *rows* is where the actual content goes. Each row is divided into *cells* that contain the property editors. The size of the cells is defined in columns. Unlike the *layouts sections* you can add more *cells* than the max number of columns - they will stack as they should in a grid system. The rows can be configured with inline styling and CSS classes to allow specifically tailored content.
![Grid structure](images/Grid-Layout/Grid-layout-NO-SIDEBAR-rows.jpg)

##Settings
A grid layout contains multiple configuration options to allow developers to tailor the grid to a very specific site design.
The configuration can be divided into 4 overall parts:

###Layouts
A layout is the general grid "container", it contains one or more sections which content editors can use to insert pre-configured **rows**. There are 2 main usage scenarios of layouts:

1. a single column layout which to the content editor will act like a full page canvas to insert elements on
2. a multiple column layout with a main content body, and one or more sidebar columns to insert lists or other sidebar widgets on.

![Grid layout scenarios](images/Grid-Layout/Grid-layout-scenarios.jpg)

You can however configure as many layouts and layout sections as you wish, each section in the layout must be given a width in columns, so editors gets an accurate preview of their layout.


![Grid layouts](images/Grid-Layout/layouts.png)


###Row configurations
A row in the grid editor contains one or more cells, which divide the row into areas where editors can enter content. So a row is merely a container of areas to insert content into. When you add a new row, you are asked to give it a name, then define cells inside the row by clicking the "+" icon. Each cell has a default width set to 4, but by clicking the inserted cell you can control its width.

![Grid layouts](images/Grid-Layout/rows.png)

You add as many cells as you like. If they overflow the total width of the row, they will simply be arranged after each other horizontally as you'd expect a grid system to behave.

![Grid layouts](images/Grid-Layout/cells.png)

Each cell can by default contain any type of content such as simple text-strings, images, embedded media or umbraco macros. To override this behavior, uncheck the **allow all editors** option and you can select specific editors for the row.


###Settings and styling
A grid layout can also expose custom settings - such as styling options or data-attributes - on each cell or row. This allows editors to use a friendly UI to add configuration values to grid elements. When custom settings and styles are applied, they will by default be included in the grid html as either inline styles or html attributes.

![Grid layouts](images/Grid-Layout/settings.png)

These settings and styles must be configured by developers when setting up the grid.

###Configuring a custom setting or style
To add a setting, click the edit settings link. This will expand a dialog showing you the raw configuration data. This data is in the JSON format and will only save if its valid JSON.

The settings data could look like this, with an object for each setting:

    [
      {
        "label": "Class",
        "description": "Set a css class",
        "key": "class",
        "view": "textstring",
        "modifier": "col-sm-{0}",
        "applyTo": "row|cell"
      }
    ]

The different values are:

- **label** : Field name displayed in the content editor UI
- **description** : Descriptive text displayed in the content editor UI to guide the user
- **key** : The key the entered setting value will be stored under.
- **view** : The editor used to enter a setting value with
- **modifier** : A string formater to modify the output of the editor to append extra values.
- **applyTo (optional)** : States whether the setting can be used on a cell or a row. If either not present or empty, the setting will be shown both on Rows and Cells. 

**Label** and **description** are straight-forward. **key** defines the alias the configuration is stored under and by default the alias of the attribute will also be the attribute on the rendered html element. In the example above any value entered in this settings editor will be rendered in the grid html as:

    <div **class**="VALUE-ENTERED"></div>

By changing the key of the setting you can modify the `<div>` element's attributes like `class`, `title`, `id` or custom `data-*` attributes.


**view** the view defines the editor used to enter a value. By default Umbraco comes with a collection of prevalue editors:

- textstring
- textarea
- mediapicker
- imagepicker
- boolean
- treepicker
- treesource
- number
- multivalues

Alternatively you can also pass in a path to a custom view like "/app_plugins/packages/view.html"


**modifier** is a basic way to prepend, append or wrap the value from the editor in a simple string. This is especially useful when working with custom styles which often requires additional values to function. For instance if you want to set a background image you can get an image path from the image picker view. But in order for it to work with css it has to be wrapped in `url()`. In that case you set the **modifier** to `url('{0}')` which means that `{0}` is replaced with the editor value.


###Sample settings
There are many ways to combine these, here are some samples:

**Set a background image style**

    {
        "label": "Background color",
        "description": "Choose an image",
        "key": "background-image",
        "view": "imagepicker",
        "modifier": "url('{0}')"
    }


**Set a title setting**

    {
        "label": "Title",
        "description": "Set a title on this element",
        "key": "title",
        "view": "textstring"
    }


**add a data-custom setting**

    {
        "label": "Custom data",
        "description": "Set a title on this element",
        "key": "title",
        "view": "textstring"
    }



###Grid Editors
A grid editor is the component responsible for getting data into the grid - that could be a simple text field or a media picker. They're built in the same way as a property editor thus consists of 3 parts:

- .html view file
- .js controller
- .cshtml serverside renderer

The view is what the editor see, the controller handles how it acts and the cshtml determines how the entered data is rendered.

#Render grid in template
To display the grid on a site use:

    @CurrentPage.GetGridHtml("propertyAlias")


WIP ....
