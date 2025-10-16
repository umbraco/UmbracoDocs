---
description: >-
  Now that we have a fully functioning dashboard we might want to make it look
  prettier. To do this we can use the Umbraco UI library.
---

# Extending the Dashboard using the Umbraco UI library

The [Umbraco UI Library](../../extending/ui-library.md) is a set of web components that we can use to build Umbraco User Interfaces.

To get started using the UI library, the easiest way is to add the Content Delivery Network (CDN) script.

Add it at the bottom of the `WelcomeDashboard.html` file.

{% code title="WelcomeDashboard.html" %}
```javascript
<script src="https://cdn.jsdelivr.net/npm/@umbraco-ui/uui@latest/dist/uui.min.js"></script>
```
{% endcode %}

Once it has been added, we can start building our UI for our editors.

Since we are showing our editors their recently edited content nodes on this dashboard, it makes sense to use the [Content Node Card](https://uui.umbraco.com/?path=/docs/uui-card-content-node--aaa-overview):

![Content Node Card](<../images/uiLibraryCard (1).png>)

1. Wrap our unordered list and its content in the `<uui-card-content-node>` so it will look like this:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="The card">
    <ul class="unstyled">
        <li ng-repeat="logEntry in vm.UserLogHistory.items">
            <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
        </li>
    </ul>
</uui-card-content-node>
```
{% endcode %}

Make sure that the card shows the name of the content nodes that the editors recently worked with.

2. Replace _"The card"_ value of the `name` property in the `<uui-card-content-node>` with `{{logEntry.Content.name}}` so it will look like this:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="{{logEntry.Content.name}}"> 
```
{% endcode %}

3. Move the `ng-repeat` parameter from the tag below into the `uui-card-content-node` as well:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="{{logEntry.Content.name}}" ng-repeat="logEntry in vm.UserLogHistory.items">
```
{% endcode %}

At this point, the code looks like this:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="{{logEntry.Content.name}}" ng-repeat="logEntry in vm.UserLogHistory.items">
    <ul class="unstyled">
        <li>
            <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp | date:'medium'}})</span>
        </li>
    </ul>
</uui-card-content-node>
```
{% endcode %}

We want the editors to go directly to the content node,

4. Move the `<a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a>` line down under the `<uui-card-content-node>`.
5. Add some text to the `<a>` tag like _"click here"_ or _"See Node"._

This is how the code should look like this:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="{{logEntry.Content.name}}" ng-repeat="logEntry in vm.UserLogHistory.items">
    <a href="/Umbraco/#/{{logEntry.editUrl}}"><span ng-if="logEntry.comment"> {{logEntry.comment}}</span><span style="font-weight: 700">See Node</span></a>
    <ul class="unstyled">
        <li>
            <i class="{{logEntry.Content.icon}}"></i><span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
        </li>
    </ul>
</uui-card-content-node>
```
{% endcode %}

6. Go ahead and update the `<ul>` tag with the style from the UI library Card with the following:

{% code title="WelcomeDashboard.html" %}
```css
style="list-style: none; padding-inline-start: 0px; margin: 0;
```
{% endcode %}

7. Remove the `<i class="{{logEntry.Content.icon}}"></i>` from our list as we won't be using the icon as the card has one by default.

Once that is done, our code looks like this:

{% code title="WelcomeDashboard.html" %}
```html
<uui-card-content-node name="{{logEntry.Content.name}}" ng-repeat="logEntry in vm.UserLogHistory.items">
    <a href="/Umbraco/#/{{logEntry.editUrl}}"><span ng-if="logEntry.comment"> {{logEntry.comment}}</span><span style="font-weight: 700">See Node</span></a>
    <ul style="list-style: none; padding-inline-start: 0px; margin: 0;">
        <li>
            <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
        </li>
    </ul>
</uui-card-content-node>
```
{% endcode %}

8. Add the styling from the **Content Node Card** to our `<li>` tag as well so it will look like this:

{% code title="WelcomeDashboard.html" %}
```html
<li>
    <span style="font-weight:700" class="text-muted">Edited on:</span> {{logEntry.timestamp  | date:'medium'}}
</li>
```
{% endcode %}

Once the styling has been added, we are done editing the card.

And your file should look like this:

{% code title="WelcomeDashboard.html" %}
```html
<!DOCTYPE html>
<div class="welcome-dashboard" ng-controller="CustomWelcomeDashboardController as vm">
    <h1><localize key="welcomeDashboard_heading">Default heading</localize> {{vm.UserName}}</h1>
    <p><localize key="welcomeDashboard_bodytext">Default bodytext</localize></p>
    <p><localize key="welcomeDashboard_copyright">Default copyright</localize></p>

    <h2>We know what you edited last week...</h2>
        <uui-card-content-node name="{{logEntry.Content.name}}" ng-repeat="logEntry in vm.UserLogHistory.items">
            <a href="/Umbraco/#/{{logEntry.editUrl}}"><span ng-if="logEntry.comment"> {{logEntry.comment}}</span><span style="font-weight: 700">See Node</span></a>   
            <ul style="list-style: none; padding-inline-start: 0px; margin: 0;">
                <li>
                    <span style="font-weight:700" class="text-muted">Edited on:</span> {{logEntry.timestamp  | date:'medium'}}
                </li>
            </ul>
        </uui-card-content-node>
    <br />
    <br />
    <div>
        <a class="btn btn-primary btn-large" href="/umbraco/#/content/content/edit/1065?doctype=BlogPost&create=true">
            <i class="icon-edit"></i>
            Create New Blog Post
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@umbraco-ui/uui@latest/dist/uui.min.js"></script>
```
{% endcode %}

The last thing we need to do is to add a bit of styling to the UI.

9. Go to the `customwelcomedashboard.css` file and add the following:

{% code title="" %}
```css
uui-card-content-node {
    margin-bottom: 20px;
    width: 10%;
}
```
{% endcode %}

Once it has been added, we are done and it should look something like this:

<figure><img src="../images/extendedWithUiLibrary (1).png" alt=""><figcaption><p>Custom Dashboard extended with UI Library Card</p></figcaption></figure>
