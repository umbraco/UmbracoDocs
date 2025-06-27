---
description: Practical examples and hands-on experience are good ways to learn.
---

# Examples and Playground

The Umbraco CMS codebase comes with a set of customization examples and a way to run them using a local front-end server. This setup enables you to change the code and review the effects instantly by refreshing your browser.

[Browse the available examples in the Umbraco CMS Repository](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Web.UI.Client/examples).

## Get Started

1. Clone the source code from [https://github.com/umbraco/Umbraco-CMS/](https://github.com/umbraco/Umbraco-CMS/).
2. Make sure you have **npm** installed.
3. Open a terminal and navigate to `src/Umbraco.Web.UI.Client` .
4. Run the command: `npm install` .

### Run an Example

Start a local server and run one of the examples: `npm run example` .

### Create a playground

You can add a new example and use it as your playground. If it covers a specific topic that would be of interest to others, you can contribute it as a pull request.

To create a new example, follow these steps:

1. Create a new folder with a name of your choice in the `examples/` folder.
2. Add an `index.ts` file that exports an array of manifests as the default export (See the other examples if in doubt).
3. Run your example using the command listed above in [Run an example](examples-and-playground.md#run-an-example).

