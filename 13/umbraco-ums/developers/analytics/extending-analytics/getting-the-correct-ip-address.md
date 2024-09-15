By default the uMarketingSuite extracts the IP address for the given request by inspecting the request's **UserHostAddress** and the **X-Forwarded-For** header. The latter is commonly used if your website is running behind a load balancer. In most common scenarios this will resolve the client's IP address correctly.

If you find that IP addresses are not resolved correctly your website might be running behind a load balancing server or another protected environment that either does not forward the original client IP address in the default **X-Forwarded-For** header or simply excludes the client IP address entirely. 

In this case you may have to provide a custom implementation of the **IHttpContextIpAddressExtractor** that handles your specific case properly.

The default extractor looks like this for Umbraco v8:

    using System.Web;using uMarketingSuite.Business.Analytics.Collection.Extractors;public string ExtractIpAddress(HttpContextBase context){    if (context?.Request?.ServerVariables["X-Forwarded-For"] is string ipAddresses)    {        var ipAddress = ipAddresses.Split(',')[0].Trim();        if (System.Net.IPAddress.TryParse(ipAddress, out _)) return ipAddress;    }    return context?.Request?.UserHostAddress;}

To override this behaviour, you will have to implement your own **IHttpContextIpAddressExtractor** and tell Umbraco to use your extractor instead of our default extractor:

    using uMarketingSuite.Business.Analytics.Collection.Extractors;using Umbraco.Core.Composing;using Umbraco.Core;
    
    [ComposeAfter(typeof(uMarketingSuite.Business.Analytics.Collection.Extractors.AnalyticsExtractorsComposer))]
    public class CustomIpExtractorUserComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.RegisterUnique<IHttpContextIpAddressExtractor, MyIpAddressExtractor>();
        }
    }

It is important to note that your UserComposer makes the adjustments to the service registration **AFTER** the uMarketingSuite has initialized. This can be enforced by using the **ComposeAfterAttribute**. Forgetting to add this attribute could cause Umbraco to run your IUserComposer before the uMarketingSuite's composer, causing your changes to be overwritten.

Also make sure you are using .**RegisterUnique**&lt;...&gt;() instead of .**Register**&lt;...&gt;(). Under normal circumstances you could use register when you have multiple implementations of a single service. However as we don't want Umbraco to hold more than one implementation for the extractor service (you want your own extractor to be resolved instead), we will be using RegisterUnique to **overwrite** the uMarketingSuite's extractor.

After implementing both classes and running your project, you should see the that your extractor gets called to resolved IP addresses. It is also possible to verify the output of your extractor by inspecting the database table **uMarketingSuiteAnalyticsIpAddress**, but keep in mind that the last portion of your IP address might get anonymized (read: **set to 0**) if you have this option enabled in your uMarketingSuite's configuration file.