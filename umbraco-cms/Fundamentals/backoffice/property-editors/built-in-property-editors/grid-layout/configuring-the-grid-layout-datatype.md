---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# Configuring the Grid Layout data type
A grid layout contains multiple configuration options to allow developers to tailor the grid to a very specific site design.
Configuring the layout can be divided into 2 overall parts:

## Layouts
A layout is the general grid "container", it contains one or more sections which content editors can use to insert preconfigured **rows**. There are 2 main usage scenarios of layouts:

1. A single column layout which to the content editor will act like a full page canvas to insert elements on
2. A multiple column layout with a main content body, and one or more sidebar columns to insert lists or other sidebar widgets on.

![Grid layout scenarios](images/Grid-layout-scenarios.jpg)

You can however configure as many layouts and layout sections as you wish, each section in the layout must be given a width in columns, so editors gets an accurate preview of their layout.

![Grid layouts](images/layouts.png)

## Row configurations
A row in the grid editor contains one or more cells, which divide the row into areas where editors can enter content. So a row is merely a container of areas to insert content into. When you add a new row, you are asked to give it a name, then define cells inside the row by clicking the "+" icon. Each cell has a default width set to 4, but by clicking the inserted cell you can control its width.

It is possible to setup configurable attributes(class, rel, href) and inline styling on rows.

![Grid layouts](images/rows.png)

You can add as many cells as you like. If they overflow the total width of the row, they will be arranged after each other horizontally as you'd expect in a grid system.

![Grid layouts](images/Grid-config.png)

Each cell can by default contain any type of editor such as textstring editors, imagespicker, embedded media or Umbraco macros. To override this behavior, uncheck the **allow all editors** option and you can specify which editors will be available for the row.
