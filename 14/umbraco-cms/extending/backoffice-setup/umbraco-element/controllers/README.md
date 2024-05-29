# Controllers

A Controller enables a class to hook into the life cycle of a Web Component

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Controllers have the ability to declare the following methods:

* `hostConnected()` — Called when the Host Element is Connected to the DOM.
* `hostDisconnected()` — Called when the Host Element is Disconnected from the DOM.
* `destroy()` — Called when the controller is taken out of commission.

Additionally, the Umbraco Controllers implement a `getHostElement()` method, which enables any Controller to receive the Element that hosts the Controllers.

### Host Element

A Controller will have to be assigned to a Host Element. An assignment can be indirect as Controllers can host other Controllers.

The Host Element is a Controller Host Web Component. The Umbraco Element turns any Web Component into a Controller Host. For more information check the [Umbraco Element](../) article.

### Controller Alias

Any controller can be identified by a Controller Alias, using either a **String** or **Symbol**.\
If you utilize a Controller with a Controller Alias, then it will be destroyed when another Controller with same Alias gets Added to same Host.\
\
In this way, you can keep your controllers tidy, without a lot of managing.\
\
The example below shows how to initialize a Controller with a Controller Alias.

<pre class="language-typescript"><code class="lang-typescript">
function mySetActiveDocument(id: string) {
<strong>	new UmbObserverController(
</strong>		this.#host,
		this.myGetObservableForDocumentOfId(id),
		(document) => {
			// Callback receiving the specific document.
			Console.log("Active document data ", document)
		},
<strong>		'_observeStateById',
</strong>	);
}
</code></pre>

The creation of this Controller will replace its previous instance. Leaving only the latest observation to be present, as the previous instance will be removed and destroyed.

You can find another example in the [Write your own Controller](write-your-own-controller.md) article.
