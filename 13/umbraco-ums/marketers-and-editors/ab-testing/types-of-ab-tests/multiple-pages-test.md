# Multiple Pages Test

The multiple pages test allows you to test multiple pages at the same time. Within Umbraco you can simply select the webpages you want to test and all these pages you can specify which type of CSS or JavaScript will be added to the specific variant. Where [the single page test](/a-b-testing/types-of-a-b-tests/single-page-a-b-test/) enables you to start testing without writing any line of code, the multiple pages test requires you to write (or copy-in) some CSS and JavaScript-code.

The test type "**Multiple pages**" can be started in the [Marketing section](unpublished-item-51de601d-1366-488a-8ad8-0b7f52c02be5) and in the [content app](/the-umarketingsuite-broad-overview/content-apps/). The type is selected in step 2 of the setup.

![]()

It allows you to select one or more pages within Umbraco. On all these page the A/B Test will render the additional CSS and JavaScript you will enter. It is important to make sure that the CSS and JavaScript will not create any side effects on these pages. This is a manual job that we cannot automate for you.

Once you've selected the pages you want to test, you can specify one or more variants. For each variant it is possible to click the Edit-button. This will bring up a popup that allows you to write JavaScript or CSS:

![]()

In this example we add some JavaScript to change the background-color of the webpage. (*Of course you could have done that with css as well with the syntax 'body{background-color:red;}'*).

You can save & preview whether your code works by clicking "**Save & preview**".

After you've create all variants you can go and start your A/B testing as written in [Setting up the A/B test](/a-b-testing/setting-up-the-a-b-test/).