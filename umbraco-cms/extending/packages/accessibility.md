# Creating An Accessible Umbraco Packages

Creating accessible packages is, a natural extension to accessibility in an [umbraco context](https://www.skrift.io/issues/accessibility-in-an-umbraco-context/).

The Umbraco UI components have been built to be accessible and have accessibility tests built within them. Building the user interface (UI) using these components means is a great start to ensuring the package is accessible.
In addition, any fixes in the components will be pushed through to the packages being created (as long as you rebuild them with the updates).

## Testing
Accessibility testing is more than automated testing and is a specialist skillset. The purpose of this document is to outline some things that can be done to help build accessible packages, it is not a complete list of accessibility tests that can be performed.

- Build the components using the [Umbraco UI components](https://uui.umbraco.com/) these have accessibility tests built within them.
- Once built use the keyboard to tab through the elements on the page checking:
  - Focus state, does the element tabbed to have a focus state.
  - Does the tab order make sense
- Check the UI with a screen reader. [NVDA have a free screen reader](https://www.nvaccess.org/download/) and some guidelines on screen reader testing are available from [webaim](https://webaim.org/articles/screenreader_testing/)
- Install use an accessibility testing tool as a plugin into your browser to run automated tests, tools like [axe DevTools](https://chrome.google.com/webstore/detail/axe-devtools-web-accessib/lhdoppojpmngadmnindnejefpokejbdd) are built to reduce the number of false positives in a test.
- If the UI does not follow the Umbraco Style, then check the contrast with a tool like [WCAG Contrast Checker](https://chrome.google.com/webstore/detail/wcag-color-contrast-check/plnahcmalebffmaghcpcmpaciebdhgdf) will help ensure contrast.
