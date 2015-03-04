#Data
*Before content created it needs to be defined as a Document Type*

###[Document Type](Document-Types/index.md)
Document types define the types of pages/nodes that backoffice users can create in the content tree. Each document type contains different properties or fields.
Each field has a specific data type e.g. text, number, ... 

###[Data Type](Data-Types/index.md)
Each document type property has a data type which defines the type of input of that property. Data types reference a Property Editor and are configured in the Umbraco backoffice in the developer section.  A datatype can be something very simple (textstring, number, true/false,...) or more complex (multi node tree picker, image cropper, ...)

###[Content Entry](Content-Entry/index.md)
A property editor is a way to insert content into Umbraco. An example of a property editor is the Rich Text Editor. It may be confused with Data Types. Its possible to have many Rich Text Editor Data Types with different settings that all use the Rich Text Editor property editor.