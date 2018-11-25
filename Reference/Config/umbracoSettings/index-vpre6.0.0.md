---
versionTo: 6.0.0
---

# Scripting

This is a legacy section which is used for the legacy Razor Macros (superseded by Partial View Macros in v4.10+),
generally you won't need to modify this section. If you need custom razor macro converters you should use implementations
of IRazorDataTypeModel instead of setting them in config.

    <scripting>
        <razor>
            <!-- razor DynamicNode typecasting detects XML and returns DynamicXml - Root elements that won't convert to DynamicXml -->
            <notDynamicXmlDocumentElements>
                <element>p</element>
                <element>div</element>
                <element>ul</element>
                <element>span</element>
            </notDynamicXmlDocumentElements>
            <dataTypeModelStaticMappings>
                <!--
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping documentTypeAlias="textPage" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" documentTypeAlias="textPage" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" documentTypeAlias="textPage">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping dataTypeGuid="00000000-0000-0000-0000-000000000000" nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            <mapping nodeTypeAlias="propertyAlias">Fully.Qualified.Type.Name.For.ModelBinder,Assembly.Name.Excluding.Dot.Dll</mapping>
            -->
            </dataTypeModelStaticMappings>
        </razor>
    </scripting>