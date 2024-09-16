# Sending data to the GTM datalayer

uMarketingSuite provides a partial view that will push variables related to A/B testing and Personalization to the Google Tag Manager data layer.

The following variables are pushed:

- inabtest - **true** if the visitor participates in an A/B test that is currently active on the page, otherwise **false**.
    - Note this will also be true if the visitor is assigned to the "A" variant which is the original page.
- abtestname - The name of the A/B test the current visitor is a participant in. If there is no active A/B test, the value will be **null**
- abtestvariant - The name of the A/B test variant the current visitor is assigned to. If there is no active A/B test, the value will be **null**
- personalized - **true** If a personalisation is applied to the page for the current visitor, otherwise **false**.
- personalizationname - The name of the active personalization. If there is no active personalization the value will be **null**.

The partial view can be rendered using the following line in your Razor template:

    @Html.Partial("~/Views/Partials/uMarketingSuite/GTMDataLayerPush.cshtml")

This partial will render the following output:

    <script>
        window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({
            inabtest: true,
            abtestname: "The name of the AB test",
            personalized: true,
            personalizationname: "The name of the personalized variant",
        });
    </script>