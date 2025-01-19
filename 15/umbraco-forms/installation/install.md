---
description: Installing Umbraco Forms
---

# Installing Umbraco Forms

Umbraco contains the **Forms** section, by default. You will see a similar interface, when you click on the **Forms** section in the **Umbraco Backoffice**.

![Form section in backoffice](images/Forms\_Section\_Backoffice.png)

## Video Tutorial

{% embed url="https://www.youtube.com/watch?v=3Aojbp_1MPc" %}

To install the Umbraco Forms package (**Umbraco.Forms**), follow these steps:

1. Run the following command on a command prompt of your choice:

    ```cs
    dotnet add package Umbraco.Forms
    ```

2. Restart the web application using the following command:

    ```cs
        dotnet run
    ```
    
{% hint style="info" %}
**Note:** Ensure that the version of Umbraco Forms is compatible with the version of Umbraco you are using. For example, if you are using Umbraco 15, you should use Umbraco.Forms version 15.1.0 or a compatible version.
{% endhint %}

## Start Building Forms

Once the installation is successful, you will see a similar screen in the **Forms** section:

![Create form](images/start-with-forms-v14.png)

## Using Forms

For details on using Forms, see the [Editor Documentation](../editor/creating-a-form/README.md).
