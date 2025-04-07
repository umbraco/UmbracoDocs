# Manage Environments

When working with an Umbraco Cloud project, you can add or remove extra environments depending on your plan:

* **Starter plan:** Add a left-most mainline environment for an additional price per month.
* **Standard plan:** The left-most mainline environment is included for free. Additional environments can be added for an additional price per month.
* **Professional plan:** Mainline environments are included for free. You can add or remove environments at no extra cost.

[Learn more about the additional prices on Umbraco Cloud](https://umbraco.com/cloud-pricing/).

## Adding or Removing Environments

Before adding an environment, ensure there are no local changes that haven’t been pushed to Live. Adding an environment will push all changes in the current deployment chain.

After adding a left-most mainline environment, you need to clone the site again. The local version will be set up to push directly to Live, while the fresh clone will push to the left-most mainline environment.

You can add or remove environments from your project overview by selecting Configure environments.

![Adding an environment](images/environments-overview-new.png)

To remove an environment:

1. Navigate to the environment you want to delete.
2. Click on the three dots.
3. Click **Delete**.

![Deleting an environment](images/delete-environment.png)

It may take a few minutes for Cloud to set up the changes after adding or removing an environment.

## Configure Environments

When setting up your environments, it is essential to follow consistent naming conventions and configurations to maintain clarity and ease of management. It is recommended to use straightforward and descriptive names for each environment.

To configure an environment:

1. Click **Configure environments**.
2. Click **Create environment**.

![Create environment](images/create-environment.png)

3. Enter an **Environment name**.
4. Click **Confirm**.
