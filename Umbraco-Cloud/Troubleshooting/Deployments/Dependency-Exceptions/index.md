---
versionFrom: 7.0.0
---

# Dependency Exception

Sometimes you will get an error that looks like this:

    The source environment has thrown a Umbraco.Deploy.Exceptions.DependencyException with message: Entity umb://document/f2820c7766654300bc7aebf34a24def1 ("Contact page" - nodeId 1234) depends on entity umb://document/051ad11bbd8a4c2c81629c1d01d604f8 ("About Us") which cannot be deployed, because it is in the recycle bin.

Or like this:

    The source environment has thrown a Umbraco.Deploy.Exceptions.DependencyException with message: Entity umb://document/f2820c7766654300bc7aebf34a24def1 ("Contact page" - nodeId 1234) depends on entity umb://document/051ad11bbd8a4c2c81629c1d01d604f8 which cannot be deployed, because it does not exist.

These errors indicate that on the `Contact page` has (for example) a picker on it that refers to another content item. This other content item has either been deleted or is in the recycle bin on the environment you're deploying from.

## How to fix your dependency error

To resolve the issue, find the Contact page (hint: the nodeId can be used in the search field in the top-left of the backoffice) and publish it again. This should remove the reference to the node that is no longer available. Transferring the Contact page node should now succeed.
