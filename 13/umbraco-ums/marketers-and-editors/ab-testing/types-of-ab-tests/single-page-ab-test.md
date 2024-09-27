# Single-page A/B test

The Single Page A/B test allows an editor to start an A/B test without a single line of code.

When you select the "single page" test type you have the option to create two or more variants.

![]()

The first variant is always the original content and the published page. Variant B is the first variant that can be created and with the button '**Add a variant**' more alternatives can be added. More variants means that a test has to run for a longer time to become reliable.

## Splitview editing

The variant can be given a name and if you click on **Edit** you will open up the splitview editor:

![]()

On the left side the original content is shown (Original) and on the right side the variant is shown. In this side-by-side editing mode you can edit the content for your variant.

### Setting up the Document Type for splitview editing

Some properties are inactive (*visually indicated because they are greyed out*). Which properties you can edit is specified in [the setup of the properties of your Document Type](https://our.umbraco.com/documentation/Getting-Started/Data/Defining-content/).

It is possible to specify per property when segmentation is allowed with the **Allow segmentation** value.

![]()

In the overview of the Document Type, you will see if properties can be segmented as they will have the **Vary by segments** label:

![]()

### Add CSS or JavaScript

In some cases you do not have the ability to adjust a specific property because it was not configured when Umbraco was set up. In those cases you can use the CSS/JavaScript-field to add a snippet of code to make these adjustments. The best way is to do it via property editing in the splitview editmode. At that moment you do not have to write a single line of CSS or JavaScript code.

To do this click **CSS/JavaScript** in the A/B Testing editor bar:

![]()

This will give the editor a popup where CSS and JavaScript can be entered:

![]()

These lines of code will automatically be inserted at the bottom of the page.

To make sure all works as expected you can use the **Save & preview** button. This can also be done via the "Save & preview" option in the editor bar.

Once the variant is setup go back and finish the A/B Test via the **Back to A/B test** button in the editor bar.

![]()

Finish the steps in the [Settings up the A/B test](../setting-up-the-ab-test.md) article to verify and start your A/B Test.

## Content rendering

Because of the unique implementation of uMS, the content will automatically be updated for this variant. This is done by a concept called an _VariationContextAccessor_ in Umbraco. You do not need to understand this concept, as it is automatically implemented in uMS.

The algorithm will determine which variant of the text, image or whatever property, needs to be rendered. As long as you render your content in the 'normal' way [via ModelsBuilder or via the value-function](https://our.umbraco.com/documentation/Getting-Started/Design/Rendering-Content/) uMS takes care of the rest. You do not have to write any line of code.
