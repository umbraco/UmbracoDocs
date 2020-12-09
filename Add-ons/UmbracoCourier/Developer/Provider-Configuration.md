---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Provider configuration

_Courier comes with a number of built-in providers to package and extract data, some of these have different configuration settings, which can be found below_


## Files
Configuration can expose certain folders and files in the item picker in the Courier section. Use `file` and `folder` elements in the configuration to add specific paths - wildcards are not accepted:

```xml
<fileItemProvider>
    <folder>~/media/assets/somefolder</folder>
    <file>~/media/assets/somefile.png</file>
</fileItemProvider>
```

## Folders
Same as above, but only with folders.

```xml
<folderItemProvider>
    <include>
        <folder>~/media/assets/somefolder</folder>
    </include>
</folderItemProvider>
```

## Mediatypes

Single option to choose whether allowed/child media types should be added as a dependency or not.

```xml
<mediaTypeItemProvider>
    <includeChildMediaTypes>true</includeChildMediaTypes>
</mediaTypeItemProvider>
```

## DocumentTypes

- Option to include all allowed templates as a dependency
- Option to include all allowed types as a dependency
- Option to filter out certain data types

```xml
<documentTypeItemProvider>
    <!-- Include all available templates as dependencies, if false, only the current standard template is included -->
    <includeAllTemplates>false</includeAllTemplates>
    <includeChildDocumentTypes>true</includeChildDocumentTypes>

    <!-- By default we won't add the built-in data types as dependencies, if needed, they can be removed from the list below -->
    <!-- Only data types which are installed as standard, and does not have any settings are ignored -->
    <!-- to add, find the data type in the umbracoNode table and copy its uniqueId value to a node below-->
    <ignoredDataTypes>
    <add key="contentPicker">A6857C73-D6E9-480C-B6E6-F15F6AD11125</add>
    <add key="textstring">0CC0EBA1-9960-42C9-BF9B-60E150B429AE</add>
    <add key="textboxmultiple">C6BAC0DD-4AB9-45B1-8E30-E4B619EE5DA3</add>
    <add key="label">F0BC4BFB-B499-40D6-BA86-058885A5178C</add>
    <add key="folderbrowser">FD9F1447-6C61-4A7C-9595-5AA39147D318</add>
    <add key="memberpicker">2B24165F-9782-4AA3-B459-1DE4A4D21F60</add>
    <add key="simpleeditor">1251C96C-185C-4E9B-93F4-B48205573CBD</add>
    <add key="truefalse">92897BC6-A5F3-4FFE-AE27-F2E7E33DDA49</add>
    <add key="datepicker">5046194E-4237-453C-A547-15DB3A07C4E1</add>
    <add key="datepickerWithTime">E4D66C0F-B935-4200-81F0-025F7256B89A</add>
    <add key="numeric">2E6D3631-066E-44B8-AEC4-96F09099B2B5</add>
    </ignoredDataTypes>
</documentTypeItemProvider>
```

## Media

- Option to include parent nodes as a forced dependency
- Option to automatically include all children (in case a folder is transferred)

```xml
<mediaItemProvider>
    <includeChildren>false</includeChildren>
    <includeParents>true</includeParents>
</mediaItemProvider>
```

## Documents

- Option to include parents as dependencies

```xml
<documentItemProvider>
    <includeParents>true</includeParents>
</documentItemProvider>
```

## Templates

- Option to collect macros found in templates as a dependency
- Toggle whether Courier should look for files linked in the template (JS/CSS/image files)
- Collect locallink references and add the documents as dependencies
- Parse macros and add any NodeIDs passed to the macro as a dependency

```xml
<templateItemProvider>
    <macrosAreDependencies>true</macrosAreDependencies>
    <processTemplateResources>true</processTemplateResources>
    <localLinksAreDependencies>false</localLinksAreDependencies>
    <macroParametersAreDependencies>false</macroParametersAreDependencies>
</templateItemProvider>
```

## Ignore
You can ignore providers during app start by passing in their name:

```xml
<!-- Add the fully classified Class name to ignore a provider from loading... -->
<ignore>
    <!--<add>my.namespace.*</add>-->
</ignore>
```
