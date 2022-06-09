---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# What are grid layouts?
To understand how the grid layout editor works, we must first understand the structure of the grid layouts.

Grid layouts consists of two main areas that need to be configured, *grid layout area* and *grid rows*.

### Grid Layout
The *layout area* is where the overall page layout is defined.
*Layout areas* are divided in to *layout sections* e.g. a sidebar section and content section. The size of the *layout sections* is defined in columns. For a full-width content area use max number of columns (12 for Bootstrap 3). Each *layout section* contains one or more *rows*.

![Grid rows](images/Grid-layout-rows.jpg)

### Grid Rows
Grid *rows* is where the actual content goes. Each row is divided into *cells* that contain the property editors. The size of the cells is defined in columns. Unlike the *layouts sections* it is possible to add more *cells* than the max number of columns - they will stack as they should in a grid system.

![Grid structure](images/Grid-layout-NO-SIDEBAR-rows.jpg)
