#Sections

A section is defined in the `~/Config/applications.config` file. By default this file contains this information:

    <?xml version="1.0"?>
    <applications>
      <add alias="content" name="Content" icon="traycontent" sortOrder="0" />
      <add alias="media" name="Media" icon="traymedia" sortOrder="1" />
      <add alias="settings" name="Settings" icon="traysettings" sortOrder="2" />
      <add alias="developer" name="Developer" icon="traydeveloper" sortOrder="3" />
      <add alias="users" name="Users" icon="trayuser" sortOrder="4" />
      <add alias="member" name="Members" icon="traymember" sortOrder="5" />
      <add alias="translation" name="Translation" icon="traytranslation" sortOrder="6" />
    </applications>

##Section Service API v7

The section API in v7+ is found in the interface `Umbraco.Core.Services.ISectionService` which is exposed on the ApplicationContext singleton. This API is used to control/query the storage for tree registrations in the ~/Config/applications.config file.

[See the section service API reference here](../../Reference/Management-v6/Services/SectionService.md) 

##Section (Application) API v6

The section API in v6/v4 is found in the class `umbraco.BusinessLogic.Application`. This API is used to control/query the storage for section registrations in the ~/Config/applications.config file.

 