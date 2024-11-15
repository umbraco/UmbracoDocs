---
description: >-
  To boost the marketing activitites on your website, you can add a uMS top bar
  to you website. Find a template for the top bar in this article.
---

# Generic Topbar Template

Use this template to add a top bar to your website. The template can be set up and used without help from a developer.

It is recommended to personalize the popup to make it even more relevant for your specific audience.

{% hint style="info" %}
Install the [client-side script](../../developers/analytics/client-side-events-and-additional-javascript-files/additional-measurements-with-the-analytics-scripts.md) on your website to benefit from the full functionality of the template.
{% endhint %}

## JavaScript

The top bar will not affect the styling of your existing page or website. Some JavaScript is needed to insert the popup HTML in your existing content to apply the top bar. The code also includes an option for visitors to close the top bar.

Copy and paste the following JavaScript into Umbraco Engage.

<details>

<summary>JavaScript</summary>

```javascript
(function () {
    // Play with the colors and the contents of the top bar.
    const backgroundColor = "#ffba00";
    const textColor = "#333";
    const borderColor = "#ddd";
    const text = '<a href="#">Get started</a> in 10 minutes';

    // This is the text that is displayed in the top bar.
    const domElement = document.querySelector("body");
    
    // Specify the selector where the top bar is being placed.
    const options = {
        isFixed: true, // If set to 'true', the bar will have position fixed.
        inheritFont: false, // If set to 'true', the bar will have the font-family that is being used on your website.
    }
    
    // This is the function where domElement.
    insertAdjacentHTML(
        "afterbegin",
        `<div class="u-topbar__container ${options.isFixed ? 's-fixed': ''} ${options.inheritFont ? 's-font-inherit' : ''}" style="--color-text:${textColor};--color-background:${backgroundColor};--color-border:${borderColor};"><span class="u-topbar__text">${text}</span><button type="button" class="u-topbar__close-button" onclick="this.closest('.u-topbar__container').remove()"><svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 512 512"><path d="M437.5 386.6 306.9 256l130.6-130.6c14.1-14.1 14.1-36.8 0-50.9-14.1-14.1-36.8-14.1-50.9 0L256 205.1 125.4 74.5c-14.1-14.1-36.8-14.1-50.9 0-14.1 14.1-14.1 36.8 0 50.9L205.1 256 74.5 386.6c-14.1 14.1-14.1 36.8 0 50.9 14.1 14.1 36.8 14.1 50.9 0L256 306.9l130.6 130.6c14.1 14.1 36.8 14.1 50.9 0 14-14.1 14-36.9 0-50.9z"/></svg></button></div>`);
});
```

</details>

### Changing colors

You can change the following colors on the top bar:

* BackgroundColor
* TextColor
* BorderColor

### Fixed topbar

By default, the top bar is fixed and always visible when the user scrolls. That means it will be an overlay on the page, and potentially hide content underneath it.

If you do not like that, you can set the `isFixed` option to `false`. It will act like a regular element that does not scroll with the user's scroll position but does not overlap with the content. You can play with the top bar element and you can change that element at `domElement`.

{% hint style="info" %}
Be mindful that every website is unique and built slightly differently. We cannot guarantee that the top bar will work in all use cases.
{% endhint %}

### Font family

If you like to use your website's font, you can set the `inheritFont` option to `true`.

## CSS

With the top bar set up, you can change the look to fit your website. Copy and paste this CSS into uMS and your top bar is ready.

<details>

<summary>CSS</summary>

```css
.u-topbar__container {
    --font-size: 14px;
    --button-size: 40px;
    --button-icon-size: 16px;
    --color-background: yellow;
    --color-text: #000;
    --color-border: #000;
    background: var(--color-background);
    color: var(--color-text);
    border-bottom: 1px solid var(--color-border);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    padding: 10px;
    box-sizing: border-box;
    font-family: system-ui, sans-serif;
    font-weight: bold;
    min-height: 40px;
    z-index: 9999;
    width: 100%;
    font-size: var(--font-size);
}

.u-topbar__container.s-font-inherit {
    font-family: inherit;
}
    
.u-topbar__container.s-fixed {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: auto;
}

.u-topbar__text a {
    color: inherit !important;
}

.u-topbar__close-button {
    appearance: none;
    border: 0;
    outline: 0;
    background: transparent;
    position: absolute;
    top: 0;
    bottom: 0;
    right: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    width: var(--button-size);
    height: var(--button-size);
    left: auto;
    margin: auto;
    flex: 0 0 auto;
}

.u-topbar__close-button > svg {
    width: var(--button-icon-size);
    height: var(--button-icon-size);
    flex: 0 0 auto;
}

@media (max-width: 48em) {

    .u-topbar__container {
        --font-size: 12px;
        --button-size: 30px;
        --button-icon-size: 12px;
        padding-left: var(--button-size);
        padding-right: var(--button-size);
        min-height: var(--button-size);
    }

    .u-topbar__close-button {
        right: 0;
    }
}
```

</details>

If you want to change the colors, you can do that in the JavaScript file.

Feel free to play around with other properties. You can always use the code from this article to reset the styling.
