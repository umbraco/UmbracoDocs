---
description: >-
  To boost the marketing activitites on your website, you can add an exit intent
  popup to you website. Find a template for the popup in this article.
---

# Generic Exit Intent Popup Template

Use this template to start boosting your marketing activities. The template can be set up and used without help from a developer.

It is recommended to personalize the popup to make it even more relevant for your specific audience.

{% hint style="info" %}
Install the [client-side script](../../developers/analytics/client-side-events-and-additional-javascript-files/additional-measurements-with-the-analytics-scripts.md) on your website to benefit from the full functionality of the template.
{% endhint %}

## JavaScript & CSS

Copy and paste the CSS and JavaScript into Umbraco Engage and your overlay is ready.

<details>

<summary>CSS</summary>

```css
:root {
  --c-lightbox-primary-surface: #3444b2;
  --c-lightbox-primary-contrast: #fff;
  --c-lightbox-secondary-surface: #3444b2;
  --c-lightbox-secondary-contrast: #fff;
  --c-lightbox-modal-background: rgba(0, 0, 0, 0.8);
}
.u-lightbox__container {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  margin: 0;
  justify-content: center;
  align-items: center;
  z-index: 999;
  display: none;
}
.u-lightbox__container.visible {
  display: flex;
}
.u-lightbox__scroll-container {
  position: relative;
  overflow: auto;
  -webkit-overflow-scrolling: touch;
  z-index: 10;
  width: 100%;
  height: 100%;
}
.u-lightbox__background {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: var(--c-lightbox-modal-background);
  opacity: 0;
  animation: fadeAnim 0.1s ease-in-out forwards;
}
.u-lightbox-alert-message {
  position: relative;
  background: #fff;
  border-radius: 20px;
  padding: 25px;
  max-width: min(100%, 480px);
  box-sizing: border-box;
  font-family: system-ui, sans-serif;
  opacity: 0;
  animation: showAnim 0.8s cubic-bezier(0.68, 0.19, 0.14, 1.15) forwards;
  transition: all 1s;
  font-size: 16px;
  margin: 70px auto 60px;
  box-shadow: 2px 2px 30px rgb(0 0 0 / 20%);
}

.u-lightbox-alert-content strong {
  font-size: 1.2em;
  max-width: 90%;
  display: inline-block;
}

.u-lightbox-alert-content p {
  margin: 10px 0 0 0;
}

.u-lightbox-alert-button-container {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
  flex-wrap: wrap;
  margin-bottom: -5px;
}

.u-lightbox-alert-button-container > * {
  margin-bottom: 5px;
}

.u-lightbox-alert-button-container > *:not(:last-child) {
  margin-right: 5px;
}

.u-lightbox-alert-button {
  appearance: none;
  border: 0;
  background: var(--c-lightbox-primary-surface);
  color: var(--c-lightbox-primary-contrast);
  padding: 8px 16px;
  border-radius: 5px;
  font-family: inherit;
  font-size: 1em;
  font-weight: 600;
  text-decoration: none;
  transition: filter 0.2s ease;
  cursor: pointer;
}

.u-lightbox-alert-button:hover,
.u-lightbox-alert-button:focus {
  filter: brightness(1.1);
}

.u-lightbox-alert-button.secondary {
  background: var(--c-lightbox-secondary-surface);
  color: var(--c-lightbox-secondary-contrast);
}

.u-lightbox-alert-close {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 5px 10px;
  font-size: 0.8em;
  background: #eaeaea;
  color: #676767;
}

@media (max-width: 48em) {
  .u-lightbox-alert-message.absolute {
    max-width: 100%;
    width: 100%;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    --sides: 0;
  }
  .u-lightbox-alert-button:not(.u-lightbox-alert-close) {
    width: 100%;
    text-align: center;
  }
}

@keyframes showAnim {
  0% {
    opacity: 0;
    transform: scale(0.9);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}

@keyframes fadeAnim {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}
```

</details>

<details>

<summary>JavaScript</summary>

```javascript
(function () {
  // Change your settings below
  const exitIntentSettings = {
    useCookie: true,
    cookieName: 'EngageExitIntentShown',
    cookieExpireDays: 30,
    timeout: 0,
  };

  document.body.insertAdjacentHTML(
    'beforeend',
    `<div class="u-lightbox__container eng-exit-intent-popup">
      <div class="u-lightbox__scroll-container">
        <div class="u-lightbox-alert-message">
          <article class="u-lightbox-alert-content">
            <strong>Popups do convert!</strong>
            <p>
              Did you know that the average conversion rate of a popup 
              is 3.09%? So if you have 1000 visitors on a daily basis, 
              each month <b>927 visitors</b> will convert through this 
              popup.
            </p>
            <div class="u-lightbox-alert-button-container">
              <a href="https://www.umbraco.com/" 
                 class="u-lightbox-alert-button secondary">I want this!</a>
            </div>
          </article>

          <button class="u-lightbox-alert-close u-lightbox-alert-button">
            Close
          </button>
        </div>
      </div>
      <div class="u-lightbox__background"></div>
    </div>`,
  );
  const CookieService = {
    setCookie(name, value, days) {
      let expires = '';

      if (days) {
        const date = new Date();
        date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
        expires = '; expires=' + date.toUTCString();
      }

      document.cookie = name + '=' + (value || '') + expires + ';';
    },

    getCookie(name) {
      const cookies = document.cookie.split(';');

      for (const cookie of cookies) {
        if (cookie.indexOf(name + '=') > -1) {
          return cookie.split('=')[1];
        }
      }

      return null;
    },
  };
  const exit = (e) => {
    const shouldExit =
      // user clicks on mask
      [...e.target.classList].includes('u-lightbox__scroll-container') ||
      // user clicks on the close icon 
      [...e.target.classList].includes('u-lightbox-alert-close') || 
      e.keyCode === 27; // user hits escape

    if (shouldExit) {
      document.querySelector('.eng-exit-intent-popup').classList.remove('visible');
      if (umEngage) {
        umEngage('send', 'event', 'Popup', 'Close', 'Popup1');
      }
    }
  };

  const mouseEvent = (e) => {
    const shouldShowExitIntent = !e.toElement && !e.relatedTarget && e.clientY < 10;

    if (shouldShowExitIntent) {
      document.removeEventListener('mouseout', mouseEvent);
      document.querySelector('.eng-exit-intent-popup').classList.add('visible');
      if (exitIntentSettings.useCookie) {
        CookieService.setCookie(
          exitIntentSettings.cookieName,
          true,
          exitIntentSettings.cookieExpireDays,
        );
      }
    }
  };

  if (!CookieService.getCookie(exitIntentSettings.cookieName)) {
    setTimeout(() => {
      document.addEventListener('mouseout', mouseEvent);
      document.addEventListener('keydown', exit);
      document.querySelector('.eng-exit-intent-popup').addEventListener('click', exit);
    }, exitIntentSettings.timeout);
  }
})();
```

</details>

Feel free to play around with other properties. You can always use the code in this article to reset the styling.
