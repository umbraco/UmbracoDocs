# Entry Point

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

The `entryPoint` extension type can be used to run some JavaScript code at startup.\
The entry point declares a single JavaScript file that will be loaded and run when the Backoffice starts. In other words this can be used as an entry point for a package.&#x20;

The `entryPoint` extension is also the way to go if you want to load in external libraries such as jQuery, Angular, React, etc. You can use the `entryPoint` to load in the external libraries to be shared by all your extensions. Additionally, **global CSS files** can also be used in the `entryPoint` extension.
