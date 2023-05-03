---
title: Payment Forms
description: Preparing to enter a Payment Providers payment gateway in Vendr, the eCommerce solution for Umbraco
---

In Vendr, a Payment Form is the form that is displayed immediately prior to redirecting to the Payment Gateway for payment processing. This is usually displayed on some kind of review page, allowing a final review of the Order before commencing payment.

The role of the Payment Form is to perform two tasks:

* **Prepare the Order for the Payment Gateway** - This includes initializing the Orders transaction info, and assigning the Order with an Order Number. It's also at this time that the Order is assigned to a Member if there is currently a logged in session. This task may also involve passing information to the Payment Gateway to create a session, which the customer will complete in the next step, but this is dependant on the Payment Provider implementation.

* **Redirect to the Payment Gateway** - The configured Payment Provider will return a Form that contains all the relevant information the Payment Gateway needs, along with the Forms `action` attribute being set to post to a page on the Payment Gateways server, starting the payment capture process.

<message-box type="warn" heading="Important">

An Order's Order Number is assigned at the point of the Payment Form being rendered. This is to ensure that an Order has an Order Number prior to redirecting to the Payment Gateway, so that when the customer is redirected to the Confirmation page, there is always an Order Number to display

The reason this is necessary is that many Payment Gateways finalize Orders asynchronously via webhooks, so it is possible that the customer will be redirected to the Confirmation page prior to actual finalization, so we set it early to ensure it is always available.

If a customer cancels a payment mid way through the capture process and returns to the Order to make modifications, a new Order Number will be assigned at the point of re-displaying the Payment Form.

</message-box>

## Example Payment Form

An example of displaying a Payment Form would look something like this:

````html
@using(await Html.BeginPaymentFormAsync(currentOrder)) {
    <button type="submit">Continue to Payment</button>
}

````

Similar in concept to Umbraco's own `Html.BeginUmbracoForm()` method, the Payment Form is rendered using a `using` statement to wrap any additional form elements you wish to add, such as a submit button. 

<message-box type="warn" heading="Important">

It's important to know that the Payment Form by default doesn't contain any button inputs to submit the Form. These must be supplied by the implementer. It is designed this way to ensure that the form will work with the design of the Site in question, so developers can provide any kind of button they wish.

</message-box>
