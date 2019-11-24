---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Changing Document Types

Umbraco 7 provides the ability to change the document type of a node. For instance, you can change a standard content page to a special content page that is styled differently.

Right clicking on the page name and selecting **Change Document Type** on the context menu will open up a new fly out pane. On this pane you will see options to select, the new type and the new template. It is highly important to note that the new document type may not have the same properties as the existing one. Therefore you may **lose data** if you do not ensure the properties are not mapped correctly. For instance, on one document type the title may be called ‘title’ and on another it may be called ‘mainTitle’. It is important Umbraco knows which existing fields relate to which new ones in order to safely transfer your content to the new document type. Once you have completed the mapping of the properties you can go ahead and click ***Save*** to make the changes.

![changDocType.jpg](images/changDocType.jpg)
