# Sensitive data

Marking fields and properties on member data as sensitive will hide the data in those fields for backoffice users that are not privy to the data.

In this article, you will get an overview of how you can grant and/or deny your users access to sensitive data as well as how to mark data as sensitive.

## Grant or deny access to sensitive data

Every new Umbraco installation ships with a default set of User Groups. One of them is the **Sensitive data User Group**. To give users in the backoffice access to view and work with sensitive data, they need to be part of the Sensitive data User Group.

Any users who are not part of the Sensitive data User Group, will not be able to see the data in the properties that are marked as sensitive. Instead, they will see a generic message: "_This value is hidden. If you need access to view this value please contact your website administrator._"

![Sensitive data hidden](images/sensitive-data-hidden-v8.png)

While not part of the Sensitive data User Group it is also not possible to export members or member data.

Follow these steps in order to grant a user access to sensitive data:

* Navigate to the **Users** section in the Umbraco backoffice.
* Ensure that **Users** is selected from the Users tree.
* Select the **Groups** menu in the top-right corner.
* Choose the **Sensitive data** group.

![Sensitive data user group](images/sensitive-data-user-group-v8.png)

* Click **Add** in the **Users** box on the right.
* Select the users you want to give access to the sensitive data.
* Click **Submit**.
* **Save** the User Group.

The users you have added to the Sensitive data User Group will now be able to:

* See member data that has been marked as sensitive,
* Mark data and properties on Member Types as sensitive, and
* Export members and member data.

## Marking data as sensitive

Once your user is added to the Sensitive data User Group, you have access to add and configure member properties containing sensitive data.

* Navigate to the **Settings** section in the Umbraco backoffice.
* Open the **Member Types** in the **Settings** tree.
* Select the Member Type you wish to edit.
* **Add** a property or configure an existing property.
* Locate the **Is sensitive data** option at the bottom of the **Property settings** dialog.
* Click to enable.
* Click **Submit** to update the property configuration.
* Click **Save** to save the changes on the Member Type.

When the **Is sensitive data** option is enabled, the value and data in the property will only be visible to the users with access to sensitive data.

![Update member type](images/update-member-type-v8.png)
