There are quite some configuration options within the uMarketingSuite. Most of these settings are stored in the configuration file of the uMarketingSuite. For uMarketingSuite 1.x, this configuration file can be found in /config/uMarketingSuite/umarketingsuite.config. For uMarketingSuite 2.x we have adopted the new standard for .NET Core applications, in which we make use of the appsettings.json (and environment variable support). See [Configuration options 2.x](/installing-umarketingsuite/configuration-options-2-x/) if you are using uMarketingSuite version 2.

If you open this file with your favourite texteditor you've all kinds of options that you can set. If you afterwards save the file you should touch the web.config (which restarts your website!) in order to make sure these new settings are used.

The configuration file will look like this:

    <Configuration>
      <Settings>
        <DatabaseConnectionStringName>umbracoDbDSN</DatabaseConnectionStringName>
        <Enabled>true</Enabled>
      </Settings>
      <Analytics>
        <VisitorCookie>
          <ExpirationInDays>365</ExpirationInDays>
          <CookieName>uMarketingSuiteAnalyticsVisitorId</CookieName>
          <IncludeSubdomains>false</IncludeSubdomains>
        </VisitorCookie>
        <DataCollection>
          <AnonymizeIPAddress>true</AnonymizeIPAddress>
          <ServersideTrackingEnabled>true</ServersideTrackingEnabled>
          <FlushRateInRecords>100</FlushRateInRecords>
          <FlushIntervalInSeconds>30</FlushIntervalInSeconds>
          <InternalSiteSearch>
            <AutomaticSearchTracking>true</AutomaticSearchTracking>
            <SearchTermParameters>
              <SearchTermParameter>q</SearchTermParameter>
            </SearchTermParameters>
            <SearchBoxParameters />
            <CategoryParameters />
          </InternalSiteSearch>
        </DataCollection>
        <DataStorage>
          <DeleteRawDataAfterDays>5</DeleteRawDataAfterDays>
        </DataStorage>
        <DataProcessing>
          <IntervalInRecords>100</IntervalInRecords>
          <IntervalInSeconds>30</IntervalInSeconds>
          <SessionLengthInMinutes>30</SessionLengthInMinutes>
          <AnonymizeDataAfterDays>730</AnonymizeDataAfterDays>
          <DeleteDataAfterDays>1460</DeleteDataAfterDays>
          <IsProcessingServer>true</IsProcessingServer>
        </DataProcessing>
        <DataCleanup>
          <StartAfterSeconds>300</StartAfterSeconds>
          <IntervalInSeconds>1800</IntervalInSeconds>
          <NumberOfRows>1000</NumberOfRows>
        </DataCleanup>
      </Analytics>
      <ABTesting>
        <MinimumPercentageForAdviceWithPredictedRuntime>25</MinimumPercentageForAdviceWithPredictedRuntime>
        <MinumumPercentageMacroGoalWarning>10</MinumumPercentageMacroGoalWarning>
        <ShareDataLevel>Minimum</ShareDataLevel>
      </ABTesting>
      <Profiles>
        <Potential>
          <ActiveThresholdInDays>30</ActiveThresholdInDays>
          <EngagedThresholdInSeconds>300</EngagedThresholdInSeconds>
          <EngagedThresholdNumberOfSessions>3</EngagedThresholdNumberOfSessions>
        </Potential>
        <Identification>
          <Name>{{name}}</Name>
          <Abbreviation>{{name[0]}}</Abbreviation>
          <ImagePropertyAlias>avatar</ImagePropertyAlias>
        </Identification>
      </Profiles>
      <Reporting>
        <DataGenerationEnabled>true</DataGenerationEnabled>
        <DataGenerationTime>04:00:00</DataGenerationTime>
      </Reporting>
    </Configuration>

All these settings are also visualized in the uMarketingSuite. This overview can be found in the section 'Marketing' -&gt; Settings -&gt; Configuration

![](?width=767&amp;height=574&amp;mode=max)

You cannot change any of the settings over here which is by design. To use the new settings the website must be restarted (by touching the web.config) and that is not something that we wanted to make possible via the Umbraco backoffice.

## All settings

### Section 'Settings'

| **Key** | **Label** | **Type / possible options** | **Default value** | **Helptext** | **Additional information** |
| --- | --- | --- | --- | --- | --- |
| DatabaseConnectionStringName | Database connectionstring | Text | umbracoDbDSN | In this database the data of the uMarketingSuite will be stored. By default this is the same database as Umbraco is stored, but this could be set to another database instance |  |
| Enabled | Enabled | True / False | True | If you want to disable the uMarketingSuite you can set this setting to False. Possible options: true and false. | The killswitch of the uMarketingSuite. By setting this property to 'False' the uMarketingSuite will not do anything with regards to storing and processing. |

### Section 'Analytics'

| **Key** | **Label** | **Type / possible options** | **Default value** | **Helptext** | **Additional information** |
| --- | --- | --- | --- | --- | --- |
| ExpirationInDays | Expiration (in days) | Integer  <br>&gt; 0 | 365 | 365 | This specifies the default expiration days of the cookie of the visitor. It is a sliding expiration. Every visit the cookies is reinitialized with this expiration. |
| CookieName | CookieName | Text | uMarketingSuiteAnalyticsVisitorID | The name of the cookie that is set to track a visitor. |  |
| IncludeSubdomains | Include subdomains | True / False | False | This setting defines whether subdomains can use the cookie as well. By default only the exact domain can use the cookie. |  |
| AnonymizeIPAddress | Anonymize IP Address | True / False | True | Indicates whether the IP Address of the visitor is anonymized. When it is anonymized the last octet of an IPv4 IP address or last 80 bits of a IPv6 address is set to zeros. | The last part of the IP address is set to zero. For example; 213.128.172.0. Storign a full IP address (by setting this option to 'False') is not GDPR-compliant! You cannot store that without the consent of the visitor. |
| ServerSideTrackingEnabled | Is serverside tracking enabled? | True / False | True | When serverside tracking is enabled all requests of a visitor are enabled on the server. If disabled, you should include the clientside analytics script to enable tracking |  |
| AutomaticSearchTracking | Is automatic search tracking enabled? | True / False | True | Internal site searches are automatically tracked based on the specified querystring parameters. When set to false, you will need to include javascript or C# calls to track searches |  |
| Searchtermparameter | The searchterm  querystring parameter | Text | q | This querystring parameter indicates the part in the url that holds the searchterm |  |
| SearchboxParameter | The searchbox querystring parameter | Text | &lt;empty&gt; | When there are multiple searchboxes on one page this parameter can be used to indicate which searchbox was used |  |
| CategoryParameter | The searchterm  category parameter | Text | &lt;empty&gt; | If there is an option to search within a specific category, this querystring parameter indicates the category. |  |
| FlushRateInRecords | Flushrate (in records) | Integer  <br>&gt; 0 | 25 | When this number of records is reached in memory it will be sent from memory to the database. |  |
| FlushIntervalinSeconds | Flush interval (in seconds) | Integer   <br>&gt; 0 | 30 | When this number of seconds is reached, the data in memory will be sent to the database. |  |
| DeleteRawDataAfterDays | Number of days that raw data is stored | Integer  <br>&gt; 0 | 7 | The number of days that raw data is stored in the database. Raw data is relatively big and is not needed anymore once it is processed. Only if you want to reprocess data at a later moment it can be useful to set to a higher number. |  |
| IntervalInRecords | Dataprocessing interval (in records) | Integer  <br>&gt; 0 | 10 | Indicates the number of records that will be processed per batch |  |
| IntervalInSeconds | Dataprocessing interval (in seconds) | Integer  <br>&gt; 0 | 30 | The setting specifies the interval that is used to process records. By default every 30 seconds the rawdata table is checked wheter there are any records to process |  |
| SessionLengthInMinutes | Session length (in minutes) | Integer  <br>&gt; 0 | 30 | Specifies which seperate page requests of one visitor are linked together to one session |  |
| AnonymizeDataAfterDays | Anonymize data after (in days) | Integer  <br>&gt; 0 | 730 | Specifies the maximum number of days that individual page requests can be linked to a specific visitor. After these days the data is still available (for aggregate reporting for example) but cannot be linked to the individual visitor anymore. |  |
| DeleteDataAfterDays | Delete data after (in days) | Integer  <br>&gt; 0 | 1460 | After this number of days the data will be deleted from the database |  |
| IsProcessingServer | Is a processing server? | True / False | True | Indicates whether this server is the processing server. For performance optimization the processing of the data could be outsourced to another server. Processing is done on the raw data. Possible options: true and false. | *Note: If you are using [Umbraco in a load balanced configuration](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/load-balancing#how-umbraco-load-balancing-works), then ensure the front end servers have the configuration setting for **IsProcessingServer** set to false and that the back end (Umbraco backoffice) server should only have this setting enabled.* |

### Section 'A/B Testing'

| Key | Label | Type / possible options | Default value | Help text | Additional information |
| --- | --- | --- | --- | --- | --- |
| MinimumPercentageForAdviceWithPredictedRuntime | Minimum percentage of visitors to give advice when a runtime was predicted | Integer  <br>&gt; 0 | 25 | This percentage of visitors should be reached before the uMarketingSuite gives any advice about a running AB Test. |  |
| MinimumHoursForAdviceWithoutPredictedRuntime | Minimum hours before an advice is given when no runtime was predicted | Integer  <br>&gt; 0 | 48 | After this number of hours the uMarketingSuite tries to give an advice about a running AB Test when no runtime was predicted when creating the test. This happens when no analytics data was available when creating a new test. For example when you are testing a new website |  |
| MinimumPercentageMacroGoalWarning | Minimum percentage before a macro goal warning is given | Integer   <br>&gt; 0 | 10 | Indicates the threshold of a macro goal warning. If the macro goal conversion is decreased/increased with this percentage a warning is given that the AB Test is harming the macro goal. |  |
| ShareDataLevel | Share data level? | None / Minimum / Medium | Minimum | Specifies if any data of the AB Tests is anonymously shared with the uMarketingSuite to optimize the functionality.<br>
<br> <br>
None: No data is shared  <br>Minimum: The number of tests and the number of variants is shared  <br>Medium: The number of tests, the number of variants, and screenshots of the variants are shared to inspirate other people in the community. | This option is not in use at this moment! |

### Section 'Profiles'

| Key | Label | Type / possible options | Default value | Help text | Additional information |
| --- | --- | --- | --- | --- | --- |
| Potential/ActiveThresholdInDays |  | Integer  <br>&gt; 0 | 30 | This threshold specifies in which period the profile is considered active. |  |
| Potential/EngagedThresholdInSeconds |  | Integer  <br>&gt; 0 | 300 | This threshold specifies when a profile is consided engaged. If the profile is higher than this number of seconds engaged, the profile potential (on a detailpage of the profile) will show that the profile is engaged. |  |
| Potential/EngagedThresholdNumberOfSessions |  | Integer   <br>&gt; 0 | 3 | This threshold specifies the number of last sessions of a profile that are taken into account. |  |
| Identification/Name |  | Text | {{name}} | Template for the name of a member in the profile section. This is an AngularJS template expression that can use custom member properties. |  |
| Identification/Abbreviation |  | Text | {{name[0]}} | Template for the abbreviation of a member in the profile section. This is an AngularJS template expression that can use custom member properties. |  |
| Identification/ImagePropertyAlias |  | Text | avatar | The property alias of the member property containing an avatar image of the member. |  |

### Section 'Reporting'

| **Key** | **Label** | **Type / possible options** | **Default value** | **Helptext** | **Additional information** |
| --- | --- | --- | --- | --- | --- |
| DataGenerationEnabled | Data Generation Enabled | True / False | True | If true, reporting data will be generated daily at a configurable time. |  |
| DataGenerationTime | Data Generation Time | Time (24 Hour) | 04:00:00 | The time each day reporting data will be generated (24 hour format). This uses the local time of the webserver. |  |