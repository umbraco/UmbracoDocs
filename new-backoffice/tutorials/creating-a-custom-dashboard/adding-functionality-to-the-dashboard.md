---
description: >-
  In this subpage we will cover how to use resources and get data for your
  dashboard.
---

# Adding functionality to the Dashboard

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Overview

This is the third part of our guide to building a custom dashboard. This part continues work on the dashboard we built in part two: [Add localization to the dashboard](adding-localization-to-the-dashboard.md). But it goes further to show how to add functionality and data to our dashboard.

The steps we will go through in this part are:

1. [Contexts](adding-functionality-to-the-dashboard.md#1.-contexts)
2. [Getting data from the server](adding-functionality-to-the-dashboard.md#2.-getting-data-from-the-server)

## Step 1: Contexts

Umbraco has a large selection of contexts that you can use in your custom Property Editors and Dashboards. For this example, we will welcome the editor by name. To achieve this we can make use of the Umbraco Contexts.

To get information on the current user that's currently logged in, we first need to get the context and its token. We use the Auth context to receive the user that is currently logged in.

Import the Auth token and the type for the logged-in user. We also need to update the import from lit decorators to get `state`.

Update and add the following imports to `welcome-dashboard.element.ts` :

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { UMB_AUTH, UmbLoggedInUser } from '@umbraco-cms/backoffice/auth';
```
{% endcode %}

Now that we have the Auth token, we can consume it in the constructor to obtain the current user. We do this using the `consumeContext` method, which is available on our element because we extended using `UmbElementMixin`. As the first thing in the `export class MyWelcomeDashboardElement` add the following to the element implementation :

{% code title="welcome-dashboard.element.ts" %}
```typescript
...

@state()
private _currentUser?: UmbLoggedInUser;

private _auth?: typeof UMB_AUTH.TYPE;

constructor() {
    super();
    this.consumeContext(UMB_AUTH, (instance) => {
        this._auth = instance;
        this._observeCurrentUser();
    });
}

private async _observeCurrentUser() {
    if (!this._auth) return;
    this.observe(this._auth.currentUser, (currentUser) => {
        this._currentUser = currentUser;
    });
}

...
```
{% endcode %}

{% hint style="info" %}
The entire `welcome-dashboard.element.ts` file is available for reference at the end of the step to confirm your placement for code snippets.
{% endhint %}

Now that we have the current user, we can access a few different things. Let's get the `name` of the current user, so that we can welcome the user:

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

<figure><img src="../../.gitbook/assets/welcome-umb-user.png" alt=""><figcaption><p>Welcoming the user "Umbraco User"</p></figcaption></figure>

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { UMB_AUTH, UmbLoggedInUser } from '@umbraco-cms/backoffice/auth';
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
    @state()
    private _currentUser?: UmbLoggedInUser;

    private _auth?: typeof UMB_AUTH.TYPE;

    constructor() {
        super();
        this.consumeContext(UMB_AUTH, (instance) => {
            this._auth = instance;
            this._observeCurrentUser();
        });
    }

    private async _observeCurrentUser() {
        if (!this._auth) return;
        this.observe(this._auth.currentUser, (currentUser) => {
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

## Step 2: Getting data from the server

{% hint style="danger" %}
<mark style="color:red;">`UmbUserDetail`</mark> and <mark style="color:red;">`UmbUserRepository`</mark> is not available yet.
{% endhint %}

Let's dive deeper into some new resources and see what we can do with them.

Before we can get data from the server we need to start up the repository that handles said data. Let's say we want to get the data of all of the users of our project. To get the user data, we need to start up the user repository. We are also going to need a type for our user details.

Let's import `UmbUserDetail` and `UmbUserRepository`:

{% code title="welcome-dashboard.element.ts" %}
```typescript
import { UmbUserDetail, UmbUserRepository } from '@umbraco-cms/backoffice/users';
```
{% endcode %}

Next, we start up the repository and then create a new async method that we call from the constructor. We are also going to create a new state for our array that is going to contain our user details.

{% code title="welcome-dashboard.element.ts" %}
```typescript
@state()
private _userData?: Array<UmbUserDetail>;

private _userRepository = new UmbUserRepository(this);

constructor() {
	...

	this._getDataFromRepository();
}

private async _getDataFromRepository() {
	//this._userRepository
}
```
{% endcode %}

Notice that the user repository has a lot of methods that we can use. We are going to use `requestCollection`to get all the users.

<figure><img src="../../.gitbook/assets/requestcollection.png" alt=""><figcaption><p>Options from the user repository</p></figcaption></figure>

The method `requestCollection` returns a promise, so let's `await` the data and save the data in our array.

```typescript
private async _getDataFromRepository() {
    const { data } = await this._userRepository.requestCollection();
    this._userData = data?.items;
}
```

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { UMB_AUTH, UmbLoggedInUser } from '@umbraco-cms/backoffice/auth';
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbUserDetail, UmbUserRepository } from '@umbraco-cms/backoffice/users';
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
	@state()
	private _currentUser?: UmbLoggedInUser;

	@state()
	private _userData?: Array<UmbUserDetail>;

	private _auth?: typeof UMB_AUTH.TYPE;

	private _userRepository = new UmbUserRepository(this);

	constructor() {
		super();
		this.consumeContext(UMB_AUTH, (instance) => {
			this._auth = instance;
			this._observeCurrentUser();
		});
		this._getDataFromRepository();
	}

	//Get the current user
	private async _observeCurrentUser() {
		if (!this._auth) return;
		this.observe(this._auth.currentUser, (currentUser) => {
			this._currentUser = currentUser;
		});
	}

	//Get all users
	private async _getDataFromRepository() {
		const { data } = await this._userRepository.requestCollection();
		this._userData = data?.items;
	}

	render() {
		return html`
			<h1>
				<umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
				${this._currentUser?.name ?? 'Unknown'}!
			</h1>
			<div>
				<p>
					<umb-localize key="welcomeDashboard_bodytext">
						This is the Backoffice. From here, you can modify the content, media, and settings of your website.
					</umb-localize>
				</p>
				<p>
					<umb-localize key="welcomeDashboard_copyright"> © Sample Company 20XX </umb-localize>
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

Now that we have the data from the repository, let's render the data:

{% code title="welcome-dashboard.element.ts" %}
```typescript
render() {
    return html`
        ...
        ...

	<div id="users-wrapper">${this._userData?.map((user) => this._renderUser(user))}</div>
    `;
}

private _renderUser(user: UmbUserDetail) {
	return html`<div class="user">
		<div>${user.name}</div>
		<div>${user.email}</div>
		<div>${user.state}</div>
	</div>`;
}
```
{% endcode %}

To make it a bit easier to read, let's add a little bit of CSS as well:

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
We recommend using variables for colors and sizing. See why and how you could achieve this in the next part where we will use the Umbraco UI Library.
{% endhint %}

We now should have something that looks like this:

<figure><img src="../../.gitbook/assets/all-users-first-look2.png" alt=""><figcaption><p>Dashboard with all users. Output may vary depends on your users.</p></figcaption></figure>

<details>

<summary>See the entire file: welcome-dashboard.element.ts</summary>

{% code title="welcome-dashboard.element.ts" lineNumbers="true" %}
```typescript
import { UMB_AUTH, UmbLoggedInUser } from "@umbraco-cms/backoffice/auth";
import { LitElement, css, html, customElement, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbUserDetail, UmbUserRepository } from "@umbraco-cms/backoffice/users";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
	@state()
	private _currentUser?: UmbLoggedInUser;

	@state()
	private _userData?: Array<UmbUserDetail>;

	private _auth?: typeof UMB_AUTH.TYPE;

	private _userRepository = new UmbUserRepository(this);

	constructor() {
		super();
		this.consumeContext(UMB_AUTH, (instance) => {
			this._auth = instance;
			this._observeCurrentUser();
		});
		this._getDataFromRepository();
	}

	//Get the current user
	private async _observeCurrentUser() {
		if (!this._auth) return;
		this.observe(this._auth.currentUser, (currentUser) => {
			this._currentUser = currentUser;
		});
	}

	//Get all users
	private async _getDataFromRepository() {
		const { data } = await this._userRepository.requestCollection();
		this._userData = data?.items;
	}

	render() {
		return html`
			<h1>
				<umb-localize key="welcomeDashboard_heading">Welcome</umb-localize>
				${this._currentUser?.name ?? 'Unknown'}!
			</h1>
			<div>
				<p>
					<umb-localize key="welcomeDashboard_bodytext">
						This is the Backoffice. From here, you can modify the content, media, and settings of your website.
					</umb-localize>
				</p>
				<p>
					<umb-localize key="welcomeDashboard_copyright"> © Sample Company 20XX </umb-localize>
				</p>
			</div>
			<div id="users-wrapper">${this._userData?.map((user) => this._renderUser(user))}</div>
		`;
	}

	private _renderUser(user: UmbUserDetail) {
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
