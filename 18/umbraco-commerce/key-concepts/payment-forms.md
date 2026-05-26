---
description: Preparing to enter a Payment Providers payment gateway in Umbraco Commerce.
---

# Payment Forms

In Umbraco Commerce, a Payment Form is a form that is displayed immediately prior to redirecting to the Payment Gateway for payment processing. This is usually displayed on some kind of review page, allowing a final review of the Order before commencing payment.

The role of the Payment Form is to perform two tasks:

* **Prepare the Order for the Payment Gateway** - This includes initializing the Orders transaction info and assigning the Order with an Order Number. It's also at this time that the Order is assigned to a Member if there is currently a logged-in session. This task may also involve passing information to the Payment Gateway to create a session, which the customer will complete in the next step. This is dependent on the Payment Provider implementation.
* **Redirect to the Payment Gateway** - The configured Payment Provider will return a Form that contains all the relevant information the Payment Gateway needs. This includes the Forms `action` attribute is set to post to a page on the Payment Gateways server, starting the payment capture process.

{% hint style="info" %}
An Order's Order Number is assigned at the point of the Payment Form being rendered. This is to ensure that an Order has an Order Number prior to redirecting to the Payment Gateway. When the customer is redirected to the Confirmation page, there is always an Order Number to display

The reason this is necessary is that many Payment Gateways finalize Orders asynchronously via webhooks. This means that it is possible that the customer will be redirected to the Confirmation page prior to actual finalization. This is why we set it early to ensure it is always available.

It can happen that a customer cancels a payment mid-way through the capture process and returns to the Order to make modifications. In these cases, a new Order Number will be assigned at the point of re-displaying the Payment Form.
{% endhint %}

## Example Payment Form

An example of displaying a Payment Form would look something like this:

```html
@using(await Html.BeginPaymentFormAsync(currentOrder)) {
    <button type="submit">Continue to Payment</button>
}

```

The Payment Form is rendered using a `using` statement to wrap any additional form elements you wish to add, such as a submit button.

{% hint style="info" %}
It's important to know that the Payment Form by default doesn't contain any button inputs to submit the Form. These must be supplied by the implementer. This is to ensure that the form will work with the design of the Site in question, giving developers more freedom.
{% endhint %}
