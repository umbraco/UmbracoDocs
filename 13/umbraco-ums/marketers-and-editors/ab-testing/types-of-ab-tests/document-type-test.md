# Document Type Test

This this test you can test all pages of a specific Document Type. Select the Document Type(s) you want to test and uMS will make sure that the correct CSS and/or JavaScript is inserted to the pages.

The test type "**Document Type**" can be started in the [Marketing section](/the-umarketingsuite-broad-overview/the-umarketingsuite-section/ "The uMarketingSuite section") and in the [Content App](/the-umarketingsuite-broad-overview/content-apps/ "Content apps"). The type is selected in step 2 of the setup.

![]()

The test allows you to select one or more Document Types within Umbraco. On all pages using the selected Document Type(s) the A/B Test will render the additional CSS and JavaScript you will enter. It is important to make sure that the CSS and JavaScript will not create any side effects on these pages. This is a manual task.

Once you have selected the pages you want to test, you can specify one or more variants. For each variant it is possible to click the Edit-button. This will bring up a popup that allows you to write JavaScript or CSS:

![](/media/o3epf4ta/javascript.png)

In this example some JavaScript to change the background-color of the webpage is added.

You can save and preview whether your code works by clicking **Save & preview**.

After you havecreate all variants you can go and start your A/B testing as written in the [Setting up the A/B test](/a-b-testing/setting-up-the-a-b-test/ "Setting up the A/B test") article.