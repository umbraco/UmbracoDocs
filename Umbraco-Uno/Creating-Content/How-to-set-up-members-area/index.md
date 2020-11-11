---
versionFrom: 8.0.0
---

# Creating an area for members

One of the many features provided with an Umbraco Uno project is the option to create an area on your website which is only accessible to people who are logged in an members.

Creating an area for members requires a few components and involves several steps.

In this article you will find all the information needed, in order to allow people to register as members on your website and have access to an exclusive area when they are logged in.

The article will cover:

* Creating a register form,
* Creating a login form,
* Setting up the member-area, and
* Adding a "Logout" button.

This article will not cover how to add and manage members on your website. For more details on these topics, read the [Members](../../Manage-users/Members) article.

## Creating a register form

The very first thing that needs to be set up is a form where people can register to become members on your website. This can be done using the [Register widget](../../Widgets/Login-and-register/#register).

1. Select the page where you want to place the Register widget - or create a new page and add the widget.
2. Find a select the Register widget from the Widgets calatogue.
3. (Optional) Add a heading and some text that will be displayed above the Register form.
4. Write a message to be diplayed once a member has successfully registered - "Success Message Heading" and "Success Message Text".
5. Select "Confirm" to add the Register widget to the page.

:::center
![Example of a Register widget with heading and a short message about benefits of the membership](images/register-widget-example.png)
:::

![Reister sample](images/Register-members.png)

## Members area

A member's area could be a nice place to share inside stuff that you only want a particular group of your page users to see.

Before we create the login widget, it is a good idea to make the member's area. This is because when we are setting up the login widget, we will have to link to the page that it takes the user to after the login.

To set-up a members area:

1. Press "..." next to Unicorn Hotel/home node and choose to create a page
2. Set up the new page how you would like your member's area to look
3. To make the page members only go to the top right and press actions
4. In the actions menu, select ***Public Access***
5. In the window that shows up, you select whether its a single member or an entire group. In this guide, we will go with the group option
6. Set the login page to the page where you have the login widget
7. Finally, you can add an error page
8. Save it

## Login

Finally, we will end this guide by adding the login page.

To add the login page:

1. Select the page you want to have your login page on
2. Add the login widget and fill out every field how you likeW
3. In the field that says redirect URL choose the members page that you made in the previous chapter.

![Login sample](images/Login-members.png)

Now you should have a system that lets users register and login to a secluded members area.
