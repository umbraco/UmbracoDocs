# Single-page A/B test

The single page A/B test is one of the coolest features within the uMarketingSuite and really shows the power of the uMarketingSuite & Umbraco combination. It allows an editor to start an A/B test without a single line of code!

*Note*: To start an single page A/B Test make sure you have installed Umbraco 8.7, because the single page test can only be start on an Umbraco 8.7 or higher installation.

When you select the "single page" test type you have the option to create two or more variants.

![]()

The first variant is always the original content and essentially the published page. Variant B is the first variant that can be created and with the button '**Add a variant**' more alternatives can be added. Please be aware that more variants normally means that a test has to run for a longer time to become reliable.

## Splitview editing

The variant can be given a name and if you click on Edit you will open up the splitview editor:

![]()

On the left side the original content is shown (Original) and on the right side the variant is shown. In this side by side editing mode you can edit the content for your variant.

### Setting up the document type for splitview editing

As you may notice some properties are inactive (*visually indicated because they are greyed out*). Which properties you can edit is specified in [the setup of the properties of your document type](https://our.umbraco.com/documentation/Getting-Started/Data/Defining-content/).

It is possible to specify per property when segmentation is allowed with the value "**Allow segmentation**"

![]()

In the overview of the document type you will see if properties can be segmented because they have the label "**Vary by segments**":

![]()

### Add CSS or JavaScript

In some cases you do not have the ability to adjust a specific property because it is not configured in Umbraco when Umbraco was setup. In those cases you can use the CSS/JavaScript-field to add in a snippet of code to make these adjustments. The best way is to do it via property editing in the splitview editmode, because at that moment you do not have to write a single line of CSS or JavaScript code.

To do this you can click "**CSS/JavaScript**" in the A/B Testing editor bar:

![]()

This will give the editor a popup where CSS and JavaScript can be entered:

![]()

These lines of code will automatically be inserted on the bottom of the page.

To make sure all works as expected you can use the "**Save & preview**"-button to verify this variant is working correctly. This can also be done via the "Save & preview" option in the editor bar.

Once the variant is setup you can go back and finish the A/B Test via the button "**Back to A/B test**" in the editor bar.

![]()

From that moment you can finish the steps in "Settings up the A/B test" to verify & start your A/B Test.

## Content rendering

Because of the unique implementation of the uMarketingSuite the content will automatically be updated for this variant. This is done by a concept called an VariationContextAccessor in Umbraco. But luckily you do not need to understand this concept, because we've implemented this for you in the uMarketingSuite.

The cool thing is that our algorithm will determine which variant of the text, image or whatever property needs to be rendered. As long as you render your content in the 'normal' way [via ModelsBuilder or via the value-function](https://our.umbraco.com/documentation/Getting-Started/Design/Rendering-Content/) we will take care of the rest. You do not have to write any line of code!