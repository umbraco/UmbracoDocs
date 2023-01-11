# What Are Grid Layouts?

To understand how the grid layout editor works, we must first understand the structure of the grid layouts.

Grid layouts consists of two main areas that need to be configured, _grid layout area_ and _grid rows_.

## Grid Layout

The _layout area_ is where the overall page layout is defined. _Layout areas_ are divided in to _layout sections_ e.g. a sidebar section and content section. The size of the _layout sections_ is defined in columns. For a full-width content area use max number of columns (12 for Bootstrap 3). Each _layout section_ contains one or more _rows_.

<figure><img src="../../built-in-property-editors/grid-layout/Images/Grid-layout-rows.jpg" alt=""><figcaption></figcaption></figure>

### Grid Rows

Grid _rows_ is where the actual content goes. Each row is divided into _cells_ that contain the property editors. The size of the cells is defined in columns. Unlike the _layouts sections_ it is possible to add more _cells_ than the max number of columns - they will stack as they should in a grid system.

<figure><img src="../../built-in-property-editors/grid-layout/Images/Grid-layout-NO-SIDEBAR-rows.jpg" alt=""><figcaption></figcaption></figure>
