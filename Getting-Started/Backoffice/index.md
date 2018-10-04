# Backoffice overview
These items are common terms and concepts that are used throughout the Umbraco backoffice.

### [Login screen](Login/)
When you go to the backoffice for the first time, you're presented with the login screen.
![Login screen](images/umbraco7-6_login.jpg "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")


### [Section](Sections/)
A section in Umbraco is where you do specific tasks related to that section. For example content, settings, developer. You can navigate between the different sections of the backoffice by clicking the corresponding icon in the section menu.

![Sections](images/umbraco7-6_sections.jpg "The Section menu is the vertical menu located on the left side of the backoffice.")
*The __Section menu__ is the vertical menu located on the left side of the backoffice.*

### Tree
A tree is an hierarchical list of items related (and usually restricted) to a specific concept, which could be something like a content tree or a media tree. You can expand trees by clicking the down arrow <img src="images/expand-node.png" style="margin:0;width:15px" title="Expand a node in a tree" /> to the left of the node.
[Read more..](../../Extending/Section-Trees/index.md)

![Tree](images/umbraco7-6_tree.jpg "The content tree")
*The content tree*

### Node
A node is an item in a tree. The images and folders in the Media section are shown as nodes in the Media tree, page and content in the Content tree and so forth.

### Dashboards
A dashboard is the main view you are presented with when entering a section within the backoffice, and can be used to show valuable information to the users of the system.
![Dashboard](images/umbraco7-6_dashboard.jpg "Default dashboard in the content section")
*Default dashboard in the content section*
[Read more..](../../Extending/Dashboards/index.md)

### Editor
An editor is what you use to edit different items within the backoffice. There are editors specific to editing stylesheets, there are editors for editing Macros and so forth.

### Content
Content are the pages and content in the Content section. Each item in the tree is called a Node.  Each node in the content tree exists out of different fields. Every content item (or Node) is defined by a Document Type.
[Read more..](../Data/Defining-Content/)

### Document Type
Document types define the types of pages/nodes that backoffice users can create in the content tree. Each document type contains different properties or fields.
Each field has a specific data type e.g. text, number, ...

### Properties
Every document type has properties. These are the fields that the content editor is allowed to edit for the node.

### Data Type
Each document type property has a data type which defines the type of input of that property. Data types reference a Property Editor and are configured in the Umbraco backoffice in the developer section.  A data type can be something very simple (textstring, number, true/false,...) or more complex (multi node tree picker, image cropper, ...)
[Read more..](../Data/Data-Types/)

### [Property Editors](Property-Editors/)
A property editor is a way to insert content into Umbraco. An example of a property editor is the Rich Text Editor. It may be confused with Data Types. It's possible to have many Rich Text Editor Data Types with different settings that all use the Rich Text Editor property editor.

### Media
Media items are used to store assets like images and video within the Media section and can be referenced from your content.
[Read more..](../Data/Creating-Media/)


### Media Type
Media types are very similar to document types in Umbraco except they are specifically for media items in the media section.

### Member
A member is someone who has access to signup, register and login into your **public website** and is not to be confused with User.
[Read more..](../Data/Members/)
### Member Type
Similar to a Document type and a Media type. You are able to define custom properties to store on a member such as twitter username or website URL for example.

### Templates
A template is where you define the HTML markup of your website. A layout is a common template that contains common markup such as the `<head>` section.
[Read more](../Design/Templates/)

### Package
A package is the Umbraco term for a module or plug-in used to extend Umbraco. Packages can be found in the [projects section of Our Umbraco](https://our.umbraco.com/projects/ "Projects on Our Umbraco").

### Macros
A macro is a reusable piece of functionality that you can reuse throughout your site. Macros can be configured with parameters and be inserted into a Rich Text Editor. You can define what macros are available for your editors to insert in to the rich text editor. When an editor inserts a macro into the rich text editor it will prompt them to fill out any of the defined parameters for the macro.
[Read more..](../../Reference/Templating/Macros/)

### Macro Parameter Editor
A parameter editor defines the usage of a property editor for use as a parameter for Macros.
[Read more..](../../Extending/Macro-Parameter-Editors/)

### User
A user is someone who has access to the **Umbraco backoffice** and is not to be confused with Member. When Umbraco has been installed a user will automatically be generated with the login (email) and password entered during installing. Users can be created, edited and managed in the User section.

### Member vs User
| Member | User |
|:-------|:-----|
| To view protected content on the frontend (such as public facing website), **Member** needs to be logged for granting access. | **Users** can access the admin backend, they can also be restricted to view specific content. |
| Members only get to view the content prescribed by the admin user, they are denied to access other sections of the system. | **Users** can create, view and update content, templates, stylesheets and other back office settings. |
| **Editors** need **Members** permissions to edit content and able to view members frontend content. |  **Editors** need **Users** permissions to edit content | 
