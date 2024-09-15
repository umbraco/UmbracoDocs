Thanks to the unique implementation of the uMarketingSuite within Umbraco it is possible to test all pages of a specific document type. Simply select the document type(s) you want to test and the uMarketingSuite will make sure that the correct css and/or javascript will be inserted to this page.

The test type "**Document type**" can be started in the [Marketing section](/the-umarketingsuite-broad-overview/the-umarketingsuite-section/ "The uMarketingSuite section") and in the [content app](/the-umarketingsuite-broad-overview/content-apps/ "Content apps"). The type is selected in step 2 of the setup.

![]()

It allows you to select one or more pages within Umbraco. On all these page the A/B Test will render the additional CSS and JavaScript you will enter. It is important to make sure that the CSS and JavaScript will not create any side effects on these pages. This is a manual job that we cannot automate for you.

Once you've selected the pages you want to test, you can specify one or more variants. For each variant it is possible to click the Edit-button. This will bring up a popup that allows you to write JavaScript or CSS:

![](/media/o3epf4ta/javascript.png)

In this example we add some JavaScript to change the background-color of the webpage. (*Of course you could have done that with CSS as well with the syntax 'body{background-color:red;}'*).

You can save & preview whether your code works by clicking "Save & preview".

After you've create all variants you can go and start your A/B testing as written in [Setting up the A/B test](/a-b-testing/setting-up-the-a-b-test/ "Setting up the A/B test").