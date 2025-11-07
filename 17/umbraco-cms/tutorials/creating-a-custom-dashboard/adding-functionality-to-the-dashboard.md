---
description: Use resources and get data for your dashboard.
---

# Adding functionality to the Dashboard

## Overview

This is the third part of our guide to building a custom dashboard. This part continues work on the dashboard we built in part two: [Add localization to the dashboard](adding-localization-to-the-dashboard.md). But it goes further to show how to add functionality and data to our dashboard.

The steps we will go through in this part are:

1. [Contexts](adding-functionality-to-the-dashboard.md#contexts)
2. [Getting data from the server](adding-functionality-to-the-dashboard.md#getting-data-from-the-server)
3. [Rendering the data from the server](adding-functionality-to-the-dashboard.md#render-the-data)

## Contexts

Umbraco has a large selection of contexts that you can use in your custom Property Editors and Dashboards. For this example, we will welcome the editor by name. To achieve this we can make use of the Umbraco Contexts.

To get information on the current user that's currently logged in, we first need to get the context and its token. We use the Current User Context to receive the user that is currently logged in.

1. Import the `UMB_CURRENT_USER_CONTEXT` and the `type UmbCurrentUserModel` for the logged-in user. We also need to update the import from lit decorators to get `state` in the `welcome-dashboard.element.ts` file:

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { type UmbCurrentUserModel, UMB_CURRENT_USER_CONTEXT } from "@umbraco-cms/backoffice/current-user";
```
{% endcode %}

2. Now that we have access to the Current User Context, we can consume it in the constructor to obtain the current user. We do this using the `consumeContext` method, which is available on our element because we extended using `UmbElementMixin`.\
   \
   As the first thing in the `export class MyWelcomeDashboardElement` add the following to the element implementation :

{% code title="welcome-dashboard.element.ts" %}
```typescript
...

@state()
private _currentUser?: UmbCurrentUserModel;

constructor() {
    super();
    this.consumeContext(UMB_CURRENT_USER_CONTEXT, (instance) => {
        this._observeCurrentUser(instance);
    });
}

private async _observeCurrentUser(instance: typeof UMB_CURRENT_USER_CONTEXT.TYPE) {
    this.observe(instance.currentUser, (currentUser) => {
        this._currentUser = currentUser;
    });
}

...
```
{% endcode %}

{% hint style="info" %}
The entire `welcome-dashboard.element.ts` file is available for reference at the end of the step to confirm your placement for code snippets.
{% endhint %}

3. Now that we have the current user, we can access a few different things. Let's get the `name` of the current user, so that we can welcome the user:

{% code title="welcome-dashboard.element.ts" %}
```typescript
render() {
  return html`
    <h1>
      <umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
       ${this._currentUser?.name ?? "Unknown"}!
    </h1>
    <div>
      <p>
       <umb-localize key="welcomeDashboard_bodytext">
         This is the Backoffice. From here, you can modify the content,
         media, and settings of your website.
       </umb-localize>
      </p>
      <p>
        <umb-localize key="welcomeDashboard_copyright">
          © Sample Company 20XX
        </umb-localize>
      </p>
    </div>
  `;
}
```
{% endcode %}

Your dashboard should now look something like this:

<figure><img src="../../.gitbook/assets/Create_dashboard_functionality (1).png" alt=""><figcaption><p>Welcoming the user named "Admin"</p></figcaption></figure>

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { type UmbCurrentUserModel, UMB_CURRENT_USER_CONTEXT } from "@umbraco-cms/backoffice/current-user";
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
    @state()
    private _currentUser?: UmbCurrentUserModel;

    constructor() {
        super();
        this.consumeContext(UMB_CURRENT_USER_CONTEXT, (instance) => {
            this._observeCurrentUser(instance);
        });
    }

    private async _observeCurrentUser(instance: typeof UMB_CURRENT_USER_CONTEXT.TYPE) {
        this.observe(instance.currentUser, (currentUser) => {
            this._currentUser = currentUser;
        });
    }

    render() {
        return html`
    	    <h1>
      	        <umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
       		${this._currentUser?.name ?? "Unknown"}!
     	    </h1>
    	    <div>
      		<p>
       		    <umb-localize key="welcomeDashboard_bodytext">
         		This is the Backoffice. From here, you can modify the content,
         		media, and settings of your website.
       		    </umb-localize>
      		</p>
      		<p>
        	    <umb-localize key="welcomeDashboard_copyright">
          		© Sample Company 20XX
        	    </umb-localize>
      		</p>
    	    </div>
  	`;
    }

    static styles = [
        css`
            :host {
	        display: block;
	        padding: 24px;
	    }
        `,
    ];
}

export default MyWelcomeDashboardElement;

declare global {
    interface HTMLElementTagNameMap {
        'my-welcome-dashboard': MyWelcomeDashboardElement;
    }
}
```
{% endcode %}

</details>

## Getting data from the server

Let's dive deeper into some new resources and see what we can do with them.

Before we can get data from the server we need to start up the repository that handles said data.

Let's say we want to get the data of all of the users of our project.

* To get the user data, we need to start up the user repository.
* We are also going to need a type for our user details.

1. Import `UmbUserDetailModel` and `UmbUserCollectionRepository`:

{% code title="welcome-dashboard.element.ts" %}
```typescript
import { type UmbUserDetailModel, UmbUserCollectionRepository } from '@umbraco-cms/backoffice/user';
```
{% endcode %}

2. Start up the repository and then create a new `async` method that we call from the constructor. We are also going to create a new `state` for our array that is going to contain our user details:

{% code title="welcome-dashboard.element.ts" %}
```typescript
@state()
private _userData: Array<UmbUserDetailModel> = [];

#userRepository = new UmbUserCollectionRepository(this);

constructor() {
	...

	this._getPagedUserData();
}

private async _getPagedUserData() {
	//this._userRepository
}
```
{% endcode %}

3. Notice that the user repository has a lot of methods that we can use. We are going to use `requestCollection` to get all the users.

<figure><img src="../../.gitbook/assets/Create_dashboard_functionality_gettting_data (1).png" alt=""><figcaption><p>Options from the user repository</p></figcaption></figure>

The method `requestCollection` returns a promise, so let's `await` the data and save the data in our array:

```typescript
private async _getPagedUserData() {
    const { data } = await this.#userRepository.requestCollection();
    this._userData = data?.items ?? [];
}
```

## Render the Data

Now that we have the data from the repository, we need to render the data.

1. We are going to use the `repeat` directive to loop through the array of users and render each user. We are also going to create a new method `_renderUser` that will render the user details.\
   \
   Add the `repeat` directive to the import:

{% code title="welcome-dashboard.element.ts" %}
```typescript
import { LitElement, css, html, customElement, state, repeat } from "@umbraco-cms/backoffice/external/lit";
```
{% endcode %}

2. Add the following to the `render` method and create the `_renderUser` method:

{% code title="welcome-dashboard.element.ts" %}
```typescript
render() {
    return html`
        ...
        ...

	<div id="users-wrapper">
        ${repeat(this._userData, (user) => user.unique, (user) => this._renderUser(user))}
    </div>
    `;
}

private _renderUser(user: UmbUserDetailModel) {
	return html`<div class="user">
		<div>${user.name}</div>
		<div>${user.email}</div>
		<div>${user.state}</div>
	</div>`;
}
```
{% endcode %}

3. To make it more readable, add some CSS as well:

{% code title="welcome-dashboard.element.ts" %}
```typescript
static styles = [
      css`
        :host {
          display: block;
          padding: 24px;
        }

        #users-wrapper {
          border: 1px solid lightgray;
        }
        .user {
          padding: 5px 10px;
        }
        .user:not(:first-child) {
          border-top: 1px solid lightgray;
        }
      `,
    ];
```
{% endcode %}

{% hint style="info" %}
We recommend using variables for colors and sizing. See why and how you could achieve this in the next part where we will use the [Umbraco UI Library](extending-the-dashboard-using-umbraco-ui-library.md).
{% endhint %}

We now should have our welcome dashboard filled showing a list of all users:

<figure><img src="../../.gitbook/assets/Create_dashboard_functionality_users_list (1).png" alt=""><figcaption><p>Dashboard with all users. Output may vary depends on your users.</p></figcaption></figure>

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { type UmbCurrentUserModel, UMB_CURRENT_USER_CONTEXT } from "@umbraco-cms/backoffice/current-user";
import { LitElement, css, html, customElement, state, repeat  } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
import { type UmbUserDetailModel, UmbUserCollectionRepository } from '@umbraco-cms/backoffice/user';

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
    @state()
    private _currentUser?: UmbCurrentUserModel;

    @state()
    private _userData: Array<UmbUserDetailModel> = [];

    #userRepository = new UmbUserCollectionRepository(this);

    constructor() {
        super();
        this.consumeContext(UMB_CURRENT_USER_CONTEXT, (instance) => {
            this._observeCurrentUser(instance);
        });
        this._getPagedUserData();
    }

    private async _observeCurrentUser(instance: typeof UMB_CURRENT_USER_CONTEXT.TYPE) {
        this.observe(instance.currentUser, (currentUser) => {
            this._currentUser = currentUser;
        });
    }
    private async _getPagedUserData() {
        const { data } = await this.#userRepository.requestCollection();
        this._userData = data?.items ?? [];
    }

    render() {
        return html`
    	    <h1>
      	        <umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
       		${this._currentUser?.name ?? "Unknown"}!
     	    </h1>
    	    <div>
      		<p>
       		    <umb-localize key="welcomeDashboard_bodytext">
         		This is the Backoffice. From here, you can modify the content,
         		media, and settings of your website.
       		    </umb-localize>
      		</p>
      		<p>
        	    <umb-localize key="welcomeDashboard_copyright">
          		© Sample Company 20XX
        	    </umb-localize>
      		</p>
    	    </div>
  	<div id="users-wrapper">
        ${repeat(this._userData, (user) => user.unique, (user) => this._renderUser(user))}
    </div>
    `;
    }
    private _renderUser(user: UmbUserDetailModel) {
	return html`<div class="user">
		<div>${user.name}</div>
		<div>${user.email}</div>
		<div>${user.state}</div>
	</div>`;
}

    static styles = [
	css`
		:host {
			display: block;
			padding: 24px;
		}

		#users-wrapper {
			border: 1px solid lightgray;
		}
		.user {
			padding: 5px 10px;
		}
		.user:not(:first-child) {
			border-top: 1px solid lightgray;
		}
	`,
];
}

export default MyWelcomeDashboardElement;

declare global {
    interface HTMLElementTagNameMap {
        'my-welcome-dashboard': MyWelcomeDashboardElement;
    }
}
```
{% endcode %}

</details>

## Going Further

With all of the steps completed, you should have a functional dashboard that welcomes the user and shows a list of all users. Hopefully, this tutorial has given you some ideas on what is possible to do when creating a dashboard.

You can also go further and [extend the dashboard](extending-the-dashboard-using-umbraco-ui-library.md) with UI elements from the Umbraco UI Library.
