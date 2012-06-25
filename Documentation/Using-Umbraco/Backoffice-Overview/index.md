##BackOffice
These items are common terms and concepts that are used throughout the Umbraco backoffice.

###Document Type
Document types are the data definitions of your content in Umbraco.

### Content
Content is the pages and content that make up your Umbraco website.

### Media Type
Media types are very similar to document types in Umbraco except they are specifically for media items in the media section.

### Media
Media items are used to store assets like images and video within the Media section and can be referenced from your content.

### Member Type
Similar to a Document type and a media type. You are able to define custom properties to store on a member such as twitter username or website URL for example.

### Member
A member is someone who has access to signup, register and login into your public website and is not to be confused with User.

### User
A user is someone who has access to the Umbraco backoffice and is not to be confused with Member.

### Macros
A macro is a reusable piece of functionality that you want to re-use throughout your site can be configurable with parameters and inserted into Rich Text Editors.

### Templates / Layouts
A template is where your HTML for your pages are stored to build your website. A layout is a common template that contains common markup such as the `<head>` section.

### Template Sections
Template sections allow child templates that inherit the master layout template to insert html code up into the main layout template. For example a child template inserting code into the `<head>` tag

### Applications
An application in Umbraco is where you do specific tasks related to that application. For example content, settings, developer. But it is possible to develop your own custom applications to work with your own data.

### [Property Editors](Property-Editors/index.md)
A property editor is a way to insert content into Umbraco. An example of a property editor is the Rich Text Editor. It may be confused with Data Types. Its possible to have many Rich Text Editor Data Types with different settings that all use the Rich Text Editor property editor.

### Macro Parameter Editor
A parameter editor defines the usage of a property editor for use as a parameter for Macros.

### Editor
An editor is what you use to edit different items within the backoffice. There are editors specific to editing stylesheets, there are editors for editing Macros and so fourth.

### Tree
A tree is an hierarchical list of items related (and usually restricted) to a specific concept, which could be something like a content tree or a media tree.

### Dashboards
A dashboard is the main view you are presented with when entering a section within the backoffice, and can be used to show valuable information to the users of the system.
