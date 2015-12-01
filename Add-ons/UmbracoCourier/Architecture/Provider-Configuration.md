#Provider configuration

_Courier comes with a number of built-in providers to package and extract data, some of these have different confiuration settings, which can be found below_


###Files
Configuration can expose certain folders and files in the item picker in the courier section use `file` and `folder` elements
in the configuration to add specific paths, wildcards are not accepted:

    <fileItemProvider>
        <folder>~/media/assets/somefolder</folder>
        <file>~/media/assets/somefile.png</file>
    </fileItemProvider>

###Folders
Same as above, but only with folders

    <folderItemProvider>
      <folder>~/media/assets/somefolder</folder>
    </folderItemProvider>

###Mediatypes

Single option to turn of whether allowed/child media types should be added as a dependency or not

    <mediaTypeItemProvider>
        <includeChildMediaTypes>true</includeChildMediaTypes>
    </mediaTypeItemProvider>
  
###DocumentTypes

- Option to include all allowed templates as a dependency
- option to include all allowed types as a dependency 
- option filter out certain datatypes.

<!-- -->


    <documentTypeItemProvider>
      <!-- Include all avaiable templates as dependencies, if false, only the current standard template is included -->
      <includeAllTemplates>false</includeAllTemplates>
      <includeChildDocumentTypes>true</includeChildDocumentTypes>
      
      <!-- By default we won't add the built-in datatypes as dependencies, if needed, they can be removed from the list below -->
      <!-- Only datatypes which are installed as standard, and does not have any settings are ignored -->
      <!-- to add, find the datatype in the umbracoNode table and copy its uniqueId value to a node below-->
      <ignoredDataTypes>
        <add key="contentPicker">A6857C73-D6E9-480C-B6E6-F15F6AD11125</add>
        <add key="textstring">0CC0EBA1-9960-42C9-BF9B-60E150B429AE</add>
        <add key="textboxmultiple">C6BAC0DD-4AB9-45B1-8E30-E4B619EE5DA3</add>
        <add key="label">F0BC4BFB-B499-40D6-BA86-058885A5178C</add>
        <add key="folderbrowser">FD9F1447-6C61-4A7C-9595-5AA39147D318</add>
        <add key="memberpicker">2B24165F-9782-4AA3-B459-1DE4A4D21F60</add>
        <add key="simpleeditor">1251C96C-185C-4E9B-93F4-B48205573CBD</add>
        <add key="truefalse">92897BC6-A5F3-4FFE-AE27-F2E7E33DDA49</add>
        <add key="contentpicker">A6857C73-D6E9-480C-B6E6-F15F6AD11125</add>
        <add key="datepicker">5046194E-4237-453C-A547-15DB3A07C4E1</add>
        <add key="datepickerWithTime">E4D66C0F-B935-4200-81F0-025F7256B89A</add>
        <add key="numeric">2E6D3631-066E-44B8-AEC4-96F09099B2B5</add>
      </ignoredDataTypes>
    </documentTypeItemProvider>
    
    
###Media

- Option to include parent nodes as a forced dependency 
- option to automaticly include all children (in case a folder is transfered).

<!-- -->

    <mediaItemProvider>
      <includeChildren>false</includeChildren>
      <includeParents>false</includeParents>
    </mediaItemProvider>

###Documents

- Option to include parents as dependencies.

<!-- -->

    <documentItemProvider>
      <includeParents>true</includeParents>
    </documentItemProvider>
    
###Templates

- Option to collect macros found in templates as a dependecy, 
- toggle if courier should look for files linked in the template(js,css,image files)
- Collect locallink: references and add the documents as dependencies
- Parse macro's and add any nodeIds passed to the macro as a dependency

<!-- -->

    <templateItemProvider>
      <macrosAreDependencies>true</macrosAreDependencies>
      <processTemplateResources>true</processTemplateResources>
      <localLinksAreDependencies>true</localLinksAreDependencies>
      <macroParametersAreDependencies>true</macroParametersAreDependencies>
    </templateItemProvider>

###Ignore
You can ignore providers during app start by passing in their name:
<!-- -->

    <ignore>
        <add>TemplateItemProvder</add>
    </ignore>
