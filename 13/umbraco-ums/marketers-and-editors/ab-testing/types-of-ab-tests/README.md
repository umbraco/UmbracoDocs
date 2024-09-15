There a several different types of A/B tests. The uMarketingSuite currently implements three different types of tests:

- A [single page test](/a-b-testing/types-of-a-b-tests/single-page-a-b-test/) to test a specific page within Umbraco
- A way to test [multiple pages](/a-b-testing/types-of-a-b-tests/multiple-pages/) at the same time
- Test an entire [document type](/a-b-testing/types-of-a-b-tests/per-document-type/) and all of the pages of the documenttype

The A/B tests are all setup within Umbraco and using the context of Umbraco. We can reuse properties that are already created. Also the uMarketingSuite is aware of the structure of your website and concept like document types.

At a later moment we will also support:

- Split url testing. This gives you the option to select two or multiple pages and serve one of these urls per visitor. A good example implementation is when you want to test whether a single page checkout works better than a multistep checkout.
- Multivariate testing. In multivariate testing you will have multiple elements on your webpage that you want to test at the same time. You may want to test the hero image on your page and the title on your page. For each of these two properties you setup two or more variants and the uMarketingSuite will test these properties in every possible combination. Title A with Image X, Title A with Image Y, Title B with Image X, Title B with Image Y, etcetera. Depending on the number of properties that you want to test and the number of variants you create per property this can result in a really long running experiment and this is only a feasible option for high-traffic websites.

When setting up the A/B test, in step 2 you can select the type of test that you want to setup.

![]()

Please be aware that a single page test can only be started in the A/B test [contentapp](/the-umarketingsuite-broad-overview/content-apps/) and not from the [uMarketingSuite section](unpublished-item-51de601d-1366-488a-8ad8-0b7f52c02be5). To perform a single page test you need Umbraco 8.7 or higher.