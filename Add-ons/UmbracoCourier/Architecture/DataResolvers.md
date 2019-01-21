# Dataresolvers	
A dataresolver is a way to add meaning to objects courier doesn't understand. For instance, if you have a document with a custem data type, and the data type stores a NodeID reference to another page (like a content picker), Courier doesn't know the number refers to another node, but by adding a dataresolver, you can tell courier that items with the data type, contains a node ID, and add the needed dependencies and resources to have a successful deployment.

### AscxFiles
* **Full name:** `Umbraco.Courier.DataResolvers.ascxFiles`
* **Triggers on:** Macros which have a .ascx file as its macro file
* Collects resources for ascx files on macros, this can both be .dll or .cs files

### ContentPicker
* **Full name:** `Umbraco.Courier.DataResolvers.ContentPicker`
* **Triggers on:** Propertydata, which have a contentpicker as data type (configured in courier.config)
* If value is set, and is an int, courier will convert the value to the Node GUID, add the node as a dependency. On extraction the GUID will be converted back to the right ID.

##### Configuration

```xml
<contentPickers>
    <!-- add new datatype elements for data types that stores page ids (ex: "1242" or "1726,2362,2323") -->
    <add key="contentPicker">158aa029-24ed-4948-939e-c3da209e5fba</add>
    <add key="ultimatePicker">cdbf0b5d-5cb2-445f-bc12-fcaaec07cf2c</add>
            
    <add key="Ucomponents-XpathCheckboxlist">d2d46927-f4f8-4b1b-add7-661cc09a0539</add>
    <add key="Ucomponents-XpathDropdownlist">57a62843-c488-4c29-8125-52f51873613e</add>
    <add key="Ucomponents-AutoComplete">31aa0d5c-f8e1-4cdc-a66e-c7f8c09498ef</add>
</contentPickers>
```

### CSSResources
* **Full name:** `Umbraco.Courier.DataResolvers.CssResources`
* **Triggers on:**Stylesheets
* Includes images included in the stylesheet as resources.

### DampResolver
* **Full name:** `Umbraco.Courier.DataResolvers.DampResolver`
* **Triggers on:** Propertydata, which have a DAMP pick as data type
* If value is set, and is an int, courier will convert the value to the media GUID, add the media item as a dependency. On extraction the GUID will be converted back to the right ID.

### EmbeddedContent
* **Full name:** `Umbraco.Courier.DataResolvers.EmbeddedContent`
* **Triggers on:** Propertydata, which have a EmbeddedContent type as data type 
* Replaces node IDs in the embedded content with corresponding GUIDs and converts them back again on extraction

### Images
* **Full name:** `Umbraco.Courier.DataResolvers.Images`
* **Triggers on:** Propertydata, which contains a RTE 
* Finds linked images in the RTE html and sorts out IDs paths, and resources.


### KeyValuePrevalueEditor
* **Full name:** `Umbraco.Courier.DataResolvers.KeyValuePrevalueEditor`
* **Triggers on:** Propertydata, which contains a keyvalue editor like dropdownlist, radiobutton list, checkboxlist 
* Resolves prevalues from IDs to actual value, and back again on extraction.

##### Configuration

```xml
<keyValuePrevalueEditors>
    <!-- Prevalue editors that store values as a key value pair in the built-in umbracp prevalue storage, identified by their full class-name -->
    <add key="KeyValuePrevalueEditor">umbraco.editorControls.KeyValuePrevalueEditor</add>
</keyValuePrevalueEditors>
```

### LocalLinks
* **Full name:** `Umbraco.Courier.DataResolvers.LocalLinks`
* **Triggers on:** Propertydata, which contains a the string {locallink: 
* Resolves the ID to a GUID, and adds the linked document as a dependency

##### Configuration

```xml
<localLinks>
    <!-- Propertytypes that CAN contain locallinks (like the ones inserted with TinyMCE) -->
    <add key="TinyMCE3">5e9b75ae-face-41c8-b47e-5f4b0fd82f83</add>
    <add key="TextboxMultiple">67db8357-ef57-493e-91ac-936d305e0f2a</add>
    <add key="Textstring">ec15c1e5-9d90-422a-aa52-4f7622c63bea</add>
    <add key="Simple Editor">60b7dabf-99cd-41eb-b8e9-4d2e669bbde9</add>
</localLinks>
```

### MacroParameters
* **Full name:** `Umbraco.Courier.DataResolvers.MacroParameters`
* **Triggers on:** Propertydata and Templates, which contains `<umbraco:macro/>` elements
* Looks at each property and checks if it contains a node ID reference. If it does, the reference is changed to a GUID, and the node is added as a dependency.

##### Configuration
Configuring which data types can contain macro elements to resolve

```xml
<macros>
    <!-- Propertytypes that CAN contain macro mark-up (like the ones inserted with TinyMCE) -->
    <add key="TinyMCE3">5e9b75ae-face-41c8-b47e-5f4b0fd82f83</add>
    <add key="TextboxMultiple">67db8357-ef57-493e-91ac-936d305e0f2a</add>
    <add key="Textstring">ec15c1e5-9d90-422a-aa52-4f7622c63bea</add>
    <add key="Simple Editor">60b7dabf-99cd-41eb-b8e9-4d2e669bbde9</add>
</macros>
```

Configuring which macro property types contains references to other nodes

```xml
<macroPropertyTypeResolvers>
    <contentPickers>
        <!-- Macro Property Types, that store Content IDs, to link to media or content -->
        <add key="Media Current">mediaCurrent</add>
        <add key="Content Subs">contentSubs</add>
        <add key="Content Random">contentRandom</add>
        <add key="Content picker">contentPicker</add>
        <add key="Content tree">contentTree</add>
        <add key="Content All">contentAll</add>
    </contentPickers>
</macroPropertyTypeResolvers>
```

### MediaPicker
* **Full name:** `Umbraco.Courier.DataResolvers.MediaPicker`
* **Triggers on:** Propertydata, which have a mediapicker as data type (configured in courier.config)
* If value is set, and is an int, courier will convert the value to the media GUID, add the node as a dependency. On extraction the GUID will be converted back to the right ID.

##### Configuration:

```xml
<mediaPickers>
    <!-- add new datatype elements for data types that stores media ids (ex: "1242" or "1726,2362,2323") -->
    <add key="mediaPicker">EAD69342-F06D-4253-83AC-28000225583B</add>
    <add key="damp2">ef94c406-9e83-4058-a780-0375624ba7ca</add>
</mediaPickers>
```

### RelatedLinks
* **Full name:** `Umbraco.Courier.DataResolvers.RelatedLinks`
* **Triggers on:** Propertydata, which have a RelatedLinks type as data type
* If values are set, courier will convert the values to the corresponding GUIDs, add the nodes as dependencies. On extraction the GUIDs will be converted back to the right IDs.


### RTEstylesheets
* **Full name:** `Umbraco.Courier.DataResolvers.RTEstylesheets`
* **Triggers on:** The Rich text editor DataType
* If the RTE have any stylesheets associated, these will be added as dependencies to the data type

### Tags
* **Full name:** `Umbraco.Courier.DataResolvers.Tags`
* **Triggers on:**  Propertydata, which have a Tags type as data type
* Selected tags are included as separate dependencies and extracted along with the document.

### TemplateResources
* **Full name:** `Umbraco.Courier.DataResolvers.TemplateResources`
* **Triggers on:**  Templates
* Detects linked images, JavaScript files and stylesheets. These are added as resources and dependencies on packaging. It also detects locallinks in the template and adds the linked Node as a dependency.

### UltimatePicker
* **Full name:** `Umbraco.Courier.DataResolvers.UltimatePicker`
* **Triggers on:**  Propertydata, which have a UltimatePicker type as data type
* Selected node IDs are converted to GUIDs and the linked nodes are added as dependencies


### Upload
* **Full name:** `Umbraco.Courier.DataResolvers.Upload`
* **Triggers on:**  Propertydata, which have a Upload type as data type
* If upload field contains a file, the file is added as a resource on the document.

##### Configuration

```xml
<files>
    <!-- add new datatype elements for data types that stores files as a path ex: /meda/223/file.png -->
    <add key="Upload">5032a6e6-69e3-491d-bb28-cd31cd11086c</add>
    <add key="Ucomponents-Filepicker">318a9c2e-3966-4979-8c1d-575c5d5f669b</add>
</files>
```

### UsercontrolWrapper
* **Full name:** `Umbraco.Courier.DataResolvers.UsercontrolWrapper`
* **Triggers on:**  The UsercontrolWrapper Data types
*If the data type has a .ascx file selected as render, the file is added as a resource to ensure it is transferred with the data type.
