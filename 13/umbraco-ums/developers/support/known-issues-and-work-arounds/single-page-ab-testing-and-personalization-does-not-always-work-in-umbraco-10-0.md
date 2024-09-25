# Single-page A/B testing and personalization does not always work in Umbraco 10.0

Umbraco 10.0 has introduced a bug related to segment variants which do not work properly anymore when a property is configured to vary by segment only. We rely on this functionality to provide single page A/B testing and personalization by serving different visitors different content from Umbraco.

We have investigated the issue and provided Umbraco the fix which they have accepted and will ship in 10.1, see [this issue on Umbraco's GitHub](https://github.com/umbraco/Umbraco-CMS/issues/12679).

You can still use single page A/B testing and personalization in Umbraco 10.0 but in order to do that you will need to ensure you check both "Allow vary by culture" and "Allow segmentation" on the properties you want to use in A/B testing or personalization. If you uncheck "Allow vary by culture" it will not work in 10.0. In order to to do this your document type also needs to allow vary by culture, you can enable that in the document type settings &gt; Permissions.

![Property variation settings]()

**Solution:**

This is fixed in Umbraco 10.x.x

**Last updated:**

July 11th, 2022