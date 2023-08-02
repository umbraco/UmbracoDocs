# Adding functionality to the Dashboard

{% hint style="info" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Overview

This is step 2 in our guide to building a Custom Dashboard. This step continues work on the dashboard we built in [step 1](../creating-a-custom-dashboard.md), but goes further to show how to add functionality and data to our dashboard.

The steps we will go through in part 2 are:

1. [Resources and services](adding-functionality-to-the-dashboard.md#1.-resources-and-services)
2. [Getting data from the server](adding-functionality-to-the-dashboard.md#2.-getting-data-from-the-server)

## Step 1: Resources and services

Umbraco has a fine selection of resources and services that you can use in your custom property editors and dashboards. For this example, it would be nice to welcome the editor by name. To achieve this we can make use of the Umbraco resources.

To get the current user, we need to get the current user store. We get the store by consuming the corresponding context token.

Let's import the token, as well as the types we need.

```typescript
import {
    UmbLoggedInUser,
    UmbCurrentUserStore,
    UMB_CURRENT_USER_STORE_CONTEXT_TOKEN
} from "@umbraco-cms/backoffice/current-user";
```

Now that we have the token, we can consume it in the constructor. We already have the  `consumeContext` method available on our element since we extended using `UmbElementMixin`&#x20;

```typescript
@state()
private _currentUser?: UmbLoggedInUser;

private _currentUserStore?: UmbCurrentUserStore;

constructor() {
    super();
    this.consumeContext(UMB_CURRENT_USER_STORE_CONTEXT_TOKEN, (instance) => {
        this._currentUserStore = instance;
        this._observeCurrentUser();
    });
}

private async _observeCurrentUser() {
    if (!this._currentUserStore) return;

    this.observe(this._currentUserStore.currentUser, (currentUser) => {
        this._currentUser = currentUser;
    });
}
```

Now that we have the current user, we can access a few different things, such as `language`, `status`, and `createDate`.

Let's get the `name` of the current user, so we can welcome the user. We also want to grab the `createDate`, so that we can tell them happy anniversary:

```typescript
render() {
  return html`
    <h1>Welcome ${this._currentUser?.name ?? "Unknown"}!</h1>
    ${this.renderHappyAnniversary()}
    <div>
      <p>
        This is the Backoffice. From here, you can modify the content, 
        media, and settings of your website.
      </p>
      <p>© Sample Company 20XX</p>
    </div>
  `;
}

renderHappyAnniversary() {
  if (!this._currentUser?.createDate) return;
  const today = new Date();
  const createDate = new Date(this._currentUser?.createDate);

  if (
    today.getDate() == createDate.getDate() &&
    today.getMonth() == createDate.getMonth() &&
    today.getFullYear > createDate.getFullYear
  )
    return html`Happy Anniversary! 🥳🎉`;
  return;
}
```

Your dashboard should now look something like this:

<figure><img src="../../.gitbook/assets/happy-anniversary.png" alt=""><figcaption><p>Happy Anniversary will only appear if the user has anniversary!</p></figcaption></figure>

<details>

<summary>welcome-dashboard.element.ts</summary>

```typescript
import { UUITextStyles } from '@umbraco-ui/uui-css';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { LitElement, css, customElement, html, nothing, state } from '@umbraco-cms/backoffice/external/lit';
import {
	UMB_CURRENT_USER_STORE_CONTEXT_TOKEN,
	UmbCurrentUserStore,
	UmbLoggedInUser,
} from '@umbraco-cms/backoffice/current-user';

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
	@state()
	private _currentUser?: UmbLoggedInUser;

	private _currentUserStore?: UmbCurrentUserStore;

	constructor() {
		super();
		this.consumeContext(UMB_CURRENT_USER_STORE_CONTEXT_TOKEN, (instance) => {
			this._currentUserStore = instance;
			this._observeCurrentUser();
		});
	}

	private async _observeCurrentUser() {
		if (!this._currentUserStore) return;

		this.observe(this._currentUserStore.currentUser, (currentUser) => {
			this._currentUser = currentUser;
		});
	}

	render() {
		return html`
			<h1>Welcome ${this._currentUser?.name ?? 'Umbraco HQ'}!</h1>
			${this.renderHappyAnniversary()}
			<div>
				<p>This is the Backoffice. From here, you can modify the content, media, and settings of your website.</p>
				<p>© Sample Company 20XX</p>
			</div>
		`;
	}

	renderHappyAnniversary() {
		if (!this._currentUser?.createDate) return;
		const today = new Date();
		const createDate = new Date(this._currentUser?.createDate);

		if (
			today.getDate() == createDate.getDate() &&
			today.getMonth() == createDate.getMonth() &&
			today.getFullYear() > createDate.getFullYear()
		)
			return html`Happy Anniversary! 🥳🎉`;
		return;
	}


	static styles = [
		UUITextStyles,
		css`
			:host {
				display: block;
				padding: var(--uui-size-layout-1);
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

</details>

## Step 2: Getting data from the server

Let's dive deeper into some new resources and see what we can do with them.

Maybe our user has an important job keeping an eye on the logs for any errors that may occur on our website. To get the logs on the server we first need to start up the logsviewer repository. This repository has different methods we can use, such as `getLogs` which will return an `PagedMessageReponseModel` object. Paged objects contain a total (number), and an array of the items (in this example, an array of `MessageResponseModel`).

```typescript
import { UmbLogViewerRepository } from '@umbraco-cms/backoffice/logviewer';
import { LogMessageResponseModel } from '@umbraco-cms/backoffice/backend-api';
```

```typescript
@state()
private _logs?: LogMessageResponseModel[];

private _logRepository = new UmbLogViewerRepository(this);
```

Let's create a new async method where we get the data from the server. Let's call it `_getLogs` and call it in the constructor.&#x20;

```typescript
constructor() {
	...
	this._getLogs()
}

private async _getLogs() {
	const logs = await this._logRepository.getLogs({
		skip: 0,
		take: 10,
	});
	if (!logs.data) return;
	this._logs = logs.data.items;
	console.log(this._logs[0]);
}

```

We also added a console.log to see what's in the first item of `_logs` and this is our output:

<figure><img src="../../.gitbook/assets/consolelog.png" alt=""><figcaption></figcaption></figure>

We can see a lot of things! We are going to use only a few of them. Let's say we want to show the `level`, the `messageTemplate`, the `MachineName` (under `properties`) and the `timestamp`. We can do so by doing this:

```typescript
render() {
	return html`
		....
		
		<div>
			<h2>LogView</h2>
			${this.renderLogView()}
		</div>
	`;
}

renderLogView() {
	if (!this._logs?.length) return html`There is no fatal errors`;
	return html`${this._logs.map((log) => {
		return this.renderLogViewItem(log);
	})}`;
}

renderLogViewItem(item: LogMessageResponseModel) {
	const machineName = item.properties?.find((prop) => prop.name == 'MachineName');
	return html`<div class="item-row">
		<span>${item.timestamp ? this.renderTimestamp(item.timestamp) : nothing}</span>
		<span>${item.level}</span>
		<span>${item.messageTemplate}</span>
		<span>${machineName?.value}</span>
	</div>`;
}

renderTimestamp(t: string) {
	const timestamp = new Date(t).toDateString();
	return html`${timestamp}`;
}
```

To make it a bit easier to read, let's add a little bit of css as well:

```typescript
renderTimestamp(t: string {
	....
}

static styles = [
	UUITextStyles,
	css`
		:host {
			display: block;
			padding: var(--uui-size-layout-1);
		}
		.item-row {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
		}
	`,
];

```

We now have something that looks like this!

<figure><img src="../../.gitbook/assets/dashboard-logviewer.png" alt=""><figcaption></figcaption></figure>

Your dashboard component should now look like this:

<details>

<summary>welcome-dashboard.element.ts</summary>

```typescript
import { UUITextStyles } from '@umbraco-ui/uui-css';
import { UmbLogViewerRepository } from '@umbraco-cms/backoffice/logviewer';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { LitElement, css, customElement, html, nothing, state } from '@umbraco-cms/backoffice/external/lit';
import {
	UMB_CURRENT_USER_STORE_CONTEXT_TOKEN,
	UmbCurrentUserStore,
	UmbLoggedInUser,
} from '@umbraco-cms/backoffice/current-user';
import { LogMessageResponseModel } from '@umbraco-cms/backoffice/backend-api';

@customElement('my-welcome-dashboard')
export class MyWelcomeDashboardElement extends UmbElementMixin(LitElement) {
	@state()
	private _currentUser?: UmbLoggedInUser;

	@state()
	private _logs?: LogMessageResponseModel[];

	private _currentUserStore?: UmbCurrentUserStore;
	private _logRepository = new UmbLogViewerRepository(this);

	constructor() {
		super();
		this._getLogs();

		this.consumeContext(UMB_CURRENT_USER_STORE_CONTEXT_TOKEN, (instance) => {
			this._currentUserStore = instance;
			this._observeCurrentUser();
		});
	}

	private async _observeCurrentUser() {
		if (!this._currentUserStore) return;

		this.observe(this._currentUserStore.currentUser, (currentUser) => {
			this._currentUser = currentUser;
		});
	}

	private async _getLogs() {
		const logs = await this._logRepository.getLogs({
			skip: 0,
			take: 10,
		});
		if (!logs.data) return;
		this._logs = logs.data.items;
	}

	render() {
		return html`
			<h1>Welcome ${this._currentUser?.name ?? 'Unknown'}!</h1>
			${this.renderHappyAnniversary()}
			<div>
				<p>This is the Backoffice. From here, you can modify the content, media, and settings of your website.</p>
				<p>© Sample Company 20XX</p>
			</div>
			<div>
				<h2>Log</h2>
				${this.renderLogView()}
			</div>
		`;
	}

	renderHappyAnniversary() {
		if (!this._currentUser?.createDate) return;
		const today = new Date();
		const createDate = new Date(this._currentUser?.createDate);

		if (
			today.getDate() == createDate.getDate() &&
			today.getMonth() == createDate.getMonth() &&
			today.getFullYear() > createDate.getFullYear()
		)
			return html`Happy Anniversary! 🥳🎉`;
		return;
	}

	renderLogView() {
		if (!this._logs?.length) return html`There is no fatal errors`;
		return html`${this._logs.map((log) => {
			return this.renderLogViewItem(log);
		})}`;
	}

	renderLogViewItem(item: LogMessageResponseModel) {
		const machineName = item.properties?.find((prop) => prop.name == 'MachineName');
		return html`<div class="item-row">
			<span>${item.timestamp ? this.renderTimestamp(item.timestamp) : nothing}</span>
			<span>${item.level}</span>
			<span>${item.messageTemplate}</span>
			<span>${machineName?.value}</span>
		</div>`;
	}

	renderTimestamp(t: string) {
		const timestamp = new Date(t).toDateString();
		return html`${timestamp}`;
	}

	static styles = [
		UUITextStyles,
		css`
			:host {
				display: block;
				padding: var(--uui-size-layout-1);
			}
			.item-row {
				display: grid;
				grid-template-columns: repeat(4, 1fr);
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

</details>

## Going Further

With all of the steps completed, you should have a functional dashboard that will let the logged-in user see 10 log views. Hopefully, this tutorial has given you some ideas on what is possible to do when creating a dashboard.&#x20;

You can also go further and [extend the dashboard](extending-the-dashboard-using-umbraco-ui-library.md) with UI elements from the Umbraco UI Library.
