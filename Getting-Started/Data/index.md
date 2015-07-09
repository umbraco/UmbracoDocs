#Data
*Before content is created, it needs to be defined as a Document Type*

###[Document Type](Document-Types/index.md)
Document Types define the types of pages/nodes that backoffice users can create in the content tree. Each Document Type contains different properties or fields.
Each field has a specific data type e.g. text, number, ... 

###[Data Type](Data-Types/index.md)
Each Document Type property has a Data Type which defines the type of input of that property. Data types reference a Property Editor and are configured in the Umbraco backoffice in the developer section.  A Data Type can be something very simple (textstring, number, true/false,...) or more complex (multi node tree picker, image cropper, ...)

###[Content Entry](Content-Entry/index.md)
Content entry is done by inputting data into a Property Editor. Property editors are referenced by a Data Type which in turn is referenced from a Document Type's property. An example of a Property Editor is the rich text editor. Its possible to have many rich text editor Data Types with different configurations that all use the Rich Text Editor Property Editor.
