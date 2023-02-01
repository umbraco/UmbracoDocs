# Create accessible Umbraco packages

Creating accessible packages extends on accessibility in an [Umbraco context](https://www.skrift.io/issues/accessibility-in-an-umbraco-context/).

The Umbraco UI components have been built to be accessible and have accessibility tests built within them. Building the user interface (UI) using these components ensures that the package is as accessible as the Umbraco backoffice.

In addition, any fixes and updates to the UI components will be pushed through to the packages when you rebuild them with the updates.

## Testing

Accessibility testing is more a specialist skillset than it is automated testing. The purpose of this document is to outline what can be done to help build accessible packages. It is not a complete list of accessibility tests that can be performed.

- Build the components using the [Umbraco UI components](https://uui.umbraco.com/) as these have accessibility tests built within them.
- Use the keyboard to tab through the elements on the page checking:
  - Does the element tabbed to have a **focus state**?
  - Does the **tab order** make sense?
- Check the UI with a screen reader.
  - [NVDA have a free screen reader](https://www.nvaccess.org/download/) and some guidelines on screen reader testing are available from [webaim](https://webaim.org/articles/screenreader_testing/)
- Install an accessibility testing tool as a plugin into your browser to run automated tests:
  - Tools like [axe DevTools](https://chrome.google.com/webstore/detail/axe-devtools-web-accessib/lhdoppojpmngadmnindnejefpokejbdd) are built to reduce the number of false positives in a test.
- If the UI does not follow the Umbraco Style, then check the contrast with a tool like [WCAG Contrast Checker](https://chrome.google.com/webstore/detail/wcag-color-contrast-check/plnahcmalebffmaghcpcmpaciebdhgdf) will help ensure contrast.
