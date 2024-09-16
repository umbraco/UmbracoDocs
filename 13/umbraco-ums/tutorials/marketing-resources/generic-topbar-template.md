# Generic Topbar Template

After the success of the generic popup template, here we have the easy-to-use topbar template.  
Again: no help is needed from a developer, everyone can set this one up. Apply some personalization to make the popup even more relevant for your audience.

Please make sure that you've installed [the clientside script](/analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/) of the uMarketingSuite on your website to make sure you can use the full functionality!  
  
*The resources needed for this topbar are shared below the screenshot. ![]()*

## JavaScript

This topbar won't affect the styling of your existing page or website. To be able to apply the topbar we need some JavaScript to insert the topbar HTML in your existing content. In addition, we would like visitors to have the possibility to close the topbar. This coding is also added.

Now simply copy and paste the JavaScript below into uMarketingSuite.

### **Changing colors / options:**

You can change the colors of the topbar. You can change the **backgroundColor, textColor** and **borderColor.** 

#### **Fixed topbar?**

By default the topbar is fixed and always visible, also when the user scrolls. That means that it will be an overlay to the page, and potentionally hiding content underneath it. 

If you don't like that, you can set the **isFixed** option to 'false'. It will act like a regular element that doesn't scroll with the user's scroll position but it does not overlap content. You can play with the element where the topbar is being inserted in. You can change that element at **domElement.**

Keep in mind that every website is unique and build in a slightly different way. We can't guarentee that the topbar will work in all use cases. If it doesn't work in your website feel free to reach out to [contact@umarketingsuite.com](mailto:contact@umarketingsuite.com?subject=Marketing%20Resources%20suggestion "Reach out to uMarketingSuite with your suggestion").

#### **Font family:**

If you like to use your website's font, you can set the **inheritFont** option to 'true'.

    (function () { // Play with the colors and the contents of the topbar.const backgroundColor = "#ffba00";const textColor = "#333";const borderColor = "#ddd";const text = '<a href="#">Get started</a> in 10 minutes'; // This is the text that is displayed in the topbar.const domElement = document.querySelector("body"); // Specify the selector where the topbar is being placed. const options = {isFixed: true, // If set to 'true', the bar will have position fixed.inheritFont: false, // If set to 'true', the bar will have the font-family that is being used on your website.}// This is the function where domElement.insertAdjacentHTML("afterbegin",`<div class="u-topbar__container ${options.isFixed ? 's-fixed': ''} ${options.inheritFont ? 's-font-inherit' : ''}" style="--color-text:${textColor};--color-background:${backgroundColor};--color-border:${borderColor};"><span class="u-topbar__text">${text}</span><button type="button" class="u-topbar__close-button" onclick="this.closest('.u-topbar__container').remove()"><svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 512 512"><path d="M437.5 386.6 306.9 256l130.6-130.6c14.1-14.1 14.1-36.8 0-50.9-14.1-14.1-36.8-14.1-50.9 0L256 205.1 125.4 74.5c-14.1-14.1-36.8-14.1-50.9 0-14.1 14.1-14.1 36.8 0 50.9L205.1 256 74.5 386.6c-14.1 14.1-14.1 36.8 0 50.9 14.1 14.1 36.8 14.1 50.9 0L256 306.9l130.6 130.6c14.1 14.1 36.8 14.1 50.9 0 14-14.1 14-36.9 0-50.9z"/></svg></button></div>`);})();

## CSS

Now that we have our topbar in place we would like to make it look a bit fancier. Copy and paste this CSS into uMarketingSuite and your topbar is ready to go.

If you would like to change the colors, you can do that in the JavaScript file.

Don't be scared to play around with other properties. If things go wrong, this copy is here to reset your styling ;-)

    .u-topbar__container {--font-size: 14px;--button-size: 40px;--button-icon-size: 16px;--color-background: yellow;--color-text: #000;--color-border: #000;background: var(--color-background);color: var(--color-text);border-bottom: 1px solid var(--color-border);display: flex;align-items: center;justify-content: center;position: relative;padding: 10px;box-sizing: border-box;font-family: system-ui, sans-serif;font-weight: bold;min-height: 40px;z-index: 9999;width: 100%;font-size: var(--font-size);}.u-topbar__container.s-font-inherit {font-family: inherit;}.u-topbar__container.s-fixed {position: fixed;top: 0;left: 0;right: 0;bottom: auto;}.u-topbar__text a {color: inherit !important;}.u-topbar__close-button {appearance: none;border: 0;outline: 0;background: transparent;position: absolute;top: 0;bottom: 0;right: 10px;display: flex;align-items: center;justify-content: center;width: var(--button-size);height: var(--button-size);left: auto;margin: auto;flex: 0 0 auto;}.u-topbar__close-button > svg {width: var(--button-icon-size);height: var(--button-icon-size);flex: 0 0 auto;}@media (max-width: 48em) {.u-topbar__container {--font-size: 12px;--button-size: 30px;--button-icon-size: 12px;padding-left: var(--button-size);padding-right: var(--button-size);min-height: var(--button-size);}.u-topbar__close-button {right: 0;}}

## Questions or ideas?

Do you have improvements or requests for other templates that you would like to use? Feel free to reach out to [contact@umarketingsuite.com](mailto:contact@umarketingsuite.com?subject=Marketing%20Resources%20suggestion "Reach out to uMarketingSuite with your suggestion"). We would love to hear from you!