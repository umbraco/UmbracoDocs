# Extraction error: Config transforms failing

Sometimes you might notice that even though your deployments are coming through without errors, no changes are being applied to the Cloud environments. This might be due to Config Transforms failing during the extraction process.

This issue may occur if you have added custom [Config Transforms](../../../build-and-customize-your-solution/ready-to-set-up-your-project/project-settings/config-transforms.md) to your project.

Since Config Transforms are applied on every data extraction, the behavior will continue until the Config Transform files are either corrected or removed.

## How do I know I have this issue?

This problem is a bit tricky to spot, as the only indicator is that changes you made on the source environment are not being applied - even though the deployment was complete (although when pushing from local you might get a warning message).

The environment overview on your project will most likely not mention anything, which means you will have to delve into KUDU.

## How to check for and resolve the issue

1. Access [KUDU](../../power-tools/) on the environment where you expected to see your changes reflected
2. Navigate to site > **deployments** folder in KUDU
3. Find the latest deployment folder, either by date or by ID of the deployment (you can find the latest active deployment ID by opening the **active** file in the folder)
4. If the deployment folder with the latest ID contains only two items (`log.log` and `status.xml`), that means something went wrong as we would normally see two more files - `commits.uc` and `manifest`
5. Open the `log.log` file and look for anything mentioning `XmlTransform`.

An example of a faulty config transform not being applied could look something like this:

```log
	2021-03-05T13:33:12.5380343Z,Handling custom config transforms for live,,0
	2021-03-05T13:33:12.5536435Z,Transforming Web.config using Https.Web.live.xdt.config,,0
	2021-03-05T13:33:12.7411430Z,Transforming Web.config using Web.live.xdt.config,,0
	2021-03-05T13:33:12.8193263Z,Exception while transforming: System.Xml.XmlException: 'xdt' is an undeclared prefix. Line 4&comma; position 18.,,1
	2021-03-05T13:33:12.8349115Z,   at System.Xml.XmlTextReaderImpl.Throw(Exception e),,1
	2021-03-05T13:33:12.8349115Z,An error has occurred applying config transforms,,0
	2021-03-05T13:33:12.8505195Z,   at System.Xml.XmlTextReaderImpl.LookupNamespace(NodeData node),,1
	2021-03-05T13:33:12.8662176Z,   at System.Xml.XmlTextReaderImpl.AttributeNamespaceLookup(),,1
	2021-03-05T13:33:12.8818128Z,   at System.Xml.XmlTextReaderImpl.ParseAttributes(),,1
	2021-03-05T13:33:12.8818128Z,   at System.Xml.XmlTextReaderImpl.ParseElement(),,1
	2021-03-05T13:33:12.8974033Z,   at System.Xml.XmlTextReaderImpl.ParseElementContent(),,1
	2021-03-05T13:33:12.9130628Z,   at System.Xml.XmlLoader.LoadNode(Boolean skipOverWhitespace),,1
	2021-03-05T13:33:12.9130628Z,   at System.Xml.XmlLoader.LoadDocSequence(XmlDocument parentDoc),,1
	2021-03-05T13:33:12.9286554Z,   at System.Xml.XmlDocument.Load(XmlReader reader),,1
	2021-03-05T13:33:12.9286554Z,   at Microsoft.Web.XmlTransform.XmlFileInfoDocument.Load(XmlReader reader),,1
	2021-03-05T13:33:12.9443101Z,   at System.Xml.XmlDocument.LoadXml(String xml),,1
	2021-03-05T13:33:12.9599000Z,   at Microsoft.Web.XmlTransform.XmlTransformation..ctor(String transform&comma; Boolean isTransformAFile&comma; IXmlTransformationLogger logger),,1
	2021-03-05T13:33:12.9599000Z,   at OutcoldSolutions.ConfigTransformationTool.TransformationTask.Execute(String destinationFilePath&comma; Boolean forceParametersTask).,,1
	2021-03-05T13:33:12.9911902Z, Exception while transforming: System.Xml.XmlException: 'xdt' is an undeclared prefix. Line 4&comma; position 18.
	at System.Xml.XmlTextReaderImpl.Throw(Exception e)
	at System.Xml.XmlTextReaderImpl.LookupNamespace(NodeData node)
	at System.Xml.XmlTextReaderImpl.AttributeNamespaceLookup()  
	at System.Xml.XmlTextReaderImpl.ParseAttributes()   
	at System.Xml.XmlTextReaderImpl.ParseElement()
	at System.Xml.XmlTextReaderImpl.ParseElementContent()   
	at System.Xml.XmlLoader.LoadNode(Boolean skipOverWhitespace)   
	at System.Xml.XmlLoader.LoadDocSequence(XmlDocument parentDoc)   
	at System.Xml.XmlDocument.Load(XmlReader reader)  
	at Microsoft.Web.XmlTransform.XmlFileInfoDocument.Load(XmlReader reader)  
	at System.Xml.XmlDocument.LoadXml(String xml)  
	at Microsoft.Web.XmlTransform.XmlTransformation..ctor(String transform&comma; Boolean isTransformAFile&comma; IXmlTransformationLogger logger)
	at OutcoldSolutions.ConfigTransformationTool.TransformationTask.Execute(String destinationFilePath&comma; Boolean forceParametersTask).
```

1. Verify the Config Transform file mentioned in the error message and ensure the XML is valid.
2. Update the Config Transform file as necessary on your local solution and deploy the change to the Cloud environments.
3. Run a [Schema Deployment From Data File](../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deploy-dashboard.md#deploy-operations) to extract the schema that you previously deployed.

{% hint style="info" %}
To find errors in the config transform, you can use an xml validation tool like https://www.xmlvalidation.com/
{% endhint %}
