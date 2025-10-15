# Grid Layout Best Practices

_The grid layout editor offers non-technical editors a more visual editing environment to layout content pages and enter content of many different kinds._

The editor offers many configuration options, and as a website implementor, you could be tempted to use the grid for nearly every kind of content entry - this is however not encouraged.

To help developers determine when to use the grid layout, we've outlined the 2 major use-cases below.

## 1. As a RTE Replacement

The grid should primarily be used to replace content entry in a rich text editor (RTE). Where editors before would struggle with aligning images, lists and text or using tables inside the editor to layout content in columns.

The grid solves this scenario, giving editors predefined layouts and editors to enter content. They do not have to worry about how the content is rendered, since everything is stored in a very semantic format passing on that responsibility to the developer implementing the website.

## 2. Managing widgets

Another common scenario the grid layout editor supports are managing and inserting widgets on a page. Using the grid, editors can pick pre-made components, either text, images, embedded elements or macros and insert them in a sidebar on the page.

This could replace various setups involving content pickers, repeatable content editors and other kinds of collections of content nodes and macros.

### Limitations

With the above usage scenarios in mind, consider the grids limitations. First of all, all content entered into the grid is stored as a single property value on the content node, as a big JSON object. This means that as soon as the values are stored in the database, there is no managed API to drill into the grid content and target specific cell content. A grid layout is not a recommended storage of reusable content - it wasn't designed for this scenario. If you wish to reuse content in multiple pages, it is still recommended that you store these pieces of content as separate content nodes, so they can be stored, cached and queried as usual.

### Customisation

Keep all customisation in the `/App_Plugins/` folder. This makes it easier to share across multiple projects and ensures that nothing is lost in an update process.

### Keep it basic

The grid cannot solve every problem, neither was it meant to. It absolutely shines when configured correctly and designed to solve well-defined editor tasks, like entering content in a pre-defined layout and preconfigured options. If you put a standard grid editor on every page, expecting editors to do magic, you will be disappointed - and so will your editor.

So keep the use cases basic, spend time to configure and tune the grid in detail, this will truly make your editors love you.
