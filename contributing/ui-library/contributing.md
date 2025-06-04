# How to contribute

## Contributing to Umbraco UI

Please review this document to help to streamline the process and save everyone's precious time.

This repo uses nodejs, so you should install `nodejs` as the package manager. See [installation guide](https://nodejs.org/en/).

## Guidelines for contributions that we welcome

Not all changes are wanted, so on occasion we might close a PR without merging it. We will give you feedback why we can't accept your changes and we'll be nice about it, thanking you for spending your valuable time.

Remember, it is always worth working on an issue from the `Up-for-grabs` list or even asking for some feedback before you send us a PR. This way, your PR will not be closed as unwanted.

Feature requests or ideas should be submitted [as a discussion first](https://github.com/umbraco/Umbraco.UI/discussions/new?category=ideas) and may then later be converted into an issue.

#### Ownership and copyright

It is your responsibility to make sure that you're allowed to share the code you're providing us. For example, you should have permission from your employer or customer to share code.

Similarly, if your contribution is copied or adapted from somewhere else, make sure that the license allows you to reuse that for a contribution to Umbraco.UI and Umbraco-CMS.

If you're not sure, leave a note on your contribution and we will be happy to guide you.

When your contribution has been accepted, it will be [MIT licensed](https://github.com/umbraco/Umbraco.UI/blob/4392ef990688b9717e7851eace128fecfeb2a85f/LICENSE) from that time onwards.

### What can I start with?

Unsure where to begin contributing to the Umbraco UI library? You can start by looking through [these `Up-for-grabs` issues](https://github.com/umbraco/Umbraco.UI/issues?q=is%3Aissue+is%3Aopen+label%3Aup-for-grabs)

### Pull Requests (PRs)

We welcome all contributions. There are many ways you can help us. This is few of those ways:

Before you submit a new PR, make sure you run `npm run test`. PR must pass all the tests before it can get merged.

#### Reviewing PRs

**As a PR submitter**, you should reference the issue if there is one, include a short description of what you contributed and, if it is a code change, instructions for how to manually test out the change.

Please follow the pull request template you get provided when creating a pull request.

> NOTE: Although the latest released version of Umbraco UI corresponds to the `main` branch, then development happens in the `dev` branch. If you submit a PR, branch off `dev` and target your PR to `dev`.

### Development Guide

The UI Library components are [web components](https://developer.mozilla.org/en-US/docs/Web/Web_Components) built with [Lit](https://lit.dev/) and Typescript. Lit is a light-weight base class that makes development of web components easier and handles all the necessary things, attaching shadow root, reactivity, attribute reflection etc. We strongly encourage you to take a look at Lit documentation before starting development.

Using Typescript is mandatory when contributing to this repository, although it is not necessary to use it when consuming the components.

#### How to get started

1. Make sure you have the recommended version of node.js and npm installed
   1. Currently we use node.js v16 and npm v8
2. Run `npm install`
3. Run `npm run storybook` to start the storybook server, which we also use for development

#### New component

You can create a new component and that way contribute to the UI library. But before you do that, go to the [packages](https://github.com/umbraco/Umbraco.UI/tree/main/packages) folder and check if it's not already there. You can also look at the [Components list](broken-reference) for an inspiration, where you can check what component is in what stage.

**Package anatomy**

Each component is a separate npm package and has a fixed file structure that looks as follows:

* packages
  * new-component-name
    * lib
      * index.ts
      * new-component-name.element.ts
      * new-component-name.test.ts
      * new-component-name.story.ts
    * package.json
    * README.md
    * rollup.config.js
    * tsconfig.json

To scaffold these files run:

```sh
npm run new-package
npm i
```

`tsconfig.json` file is generated automatically when the `postinstall` script runs.

#### Properties and attributes

[Reactive properties](https://lit.dev/docs/components/properties/) are what creates the component's public api API. They all have corresponding attribute, through which the property can be initialized when the custom element gets instantiated and connected to the DOM. By default the property is not reflected to the attribute, meaning if property value changes the attribute in the markup will keep its initial value, but it will stay observed - changing its value wil change the property. [Attributes can also be reflected](https://lit.dev/docs/components/properties/#reflected-attributes), and used for styling purposes for example.

Each property you create should be documented with a jsdoc snippet. You can see an example of a property below.

```javascript
  /**
   * Disables the button, changes the looks of it and prevents if from emitting the click event
   * @type {boolean}
   * @attr
   * @default false
   */
  @property({ type: Boolean, reflect: true })
  disabled = false;
```

#### Best practices for contributing to this library

* Properties should only use attr-reflection for styling - don’t map component-state to classes - use attr-reflection!
* New dependencies can only be added by HQ-team and only after scrutinizing debate (to keep size down)
* Components versions can only be bumped by HQ-team
* Components can’t assume Umbraco context
* Elements shouldn’t depend on TagNames - their own or children - instead use :host or this and use classes/id’s for selection
* Elements always use a shadow-root (shadowDOM - for encapsulation)
* Styles should have as simple rules as possible
* UI-events should be unique types that extend from our UUIEvent (see `uui-base` package) (for typing reasons)
* When applicable, elements should follow [aria accessibility patterns](https://www.w3.org/TR/wai-aria-practices-1.1/#aria_ex)

#### Before a new element can me merged

* Element name must be prefixed with “UUI-”.
* Element must have tests and pass them.
* Element must pass basic Accessibility tests.
* Element must have a storybook setup.
* Source-code must follow the ES-lint rules.

### Have A Question?

A feature suggestion? Or maybe you think we could do something in other way? Start by filing an issue.
