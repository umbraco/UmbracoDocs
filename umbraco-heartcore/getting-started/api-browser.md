# API Browser

With the built-in API browser that ships with all Umbraco Heartcore projects, you are able to test how your data is outputted and formatted before connecting to your website or application. You can test the API endpoints and see which JSON is outputted with each call.

This article will cover how to use the API Browser in order to reap all the benefits of the feature. The API Browser can be used for both the Content Delivery API and the Content Management API.

The API Browser is located in the Settings section of the Umbraco backoffice. Expand the Headless dashboard in the Settings tree, and select "API Browser".

## The user interface

Using the API Browser you can browse through the output for the various API endpoints. This is done from a UI, where on the left side you are able to _explore_ the endpoints and on the right side you are able to _inspect_ the output.

![API Browser user interface](../.gitbook/assets/user-interface.png)

In the top-right corner you can switch between browsing in the Content Delivery or the Content Management API.

### Explorer

The first thing you'll notice on the API browser, is an already defined URL. This is to define which area of the API you will be browsing; `https://cdn.umbraco.io` for the Content Delivery API and `https://api.umbraco.io` for the Content Management API.

{% hint style="info" %}
You can also use the this field to manually add query strings to the URL and search the API endpoints that way.

The URL will be updated automatically as you browse the API using the links in the bottom of the Explorer section.
{% endhint %}

In the **Custom Request Headers** you can define which headers to use when browsing the API endpoints. The `umb-project-alias` header will have been added for you already, and in the content section the `Accept-Language` is also set by default.

The **Properties** will show you all the available properties on the object / piece of data that you are calling through the API.

Below the properties, is a section with a list of **Links**. These are links that you can use to make various GET requests from the endpoint you are already using.

The final section in the explorer is the **Embedded resources**. Here you can see the properties for each embedded resource on the endpoint you are calling, as well as links to continue browser the API based on each of those resources.

### Inspector

In the right side, you'll find the inspector section. While exploring the API, you will see that information is being posted in the **Response header** and the **Response Body** boxes.

The first box, the Response Header, will show you the status of the API endpoint you are currently browsing and tell you which headers is included in the response.

In the Response Body box the raw JSON data will be output based on the API endpoint you're calling.
