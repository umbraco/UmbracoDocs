---
description: >-
  When you have Media files on your Umbraco Cloud project with a file name
  longer than 80 characters, you will not be able to transfer and/or restore
  between your Cloud environments.
---

# Path too long Exception

## How does it look?

The exception you will see on content transfer / restore will look something like this:

`System.IO.PathTooLongException: The specified path, file name, or both are too long. The fully qualified file name must be less than 260 characters, and the directory name must be less than 248 characters.`

The full stacktrace:

```
2017-09-14 07:52:06,178 [P3284/D9/T51] ERROR Umbraco.Deploy.Work.WorkEnvironment - Deployment failed.
Umbraco.Deploy.Exceptions.RemoteApiException: The remote API has thrown an exception. ---> Umbraco.Deploy.Exceptions.GenericException: An error has occurred.
    --- End of inner exception stack trace ---
    at Umbraco.Deploy.Environments.RemoteUmbracoEnvironment.d__15.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
    at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
    at Umbraco.Deploy.Environments.RemoteUmbracoEnvironment.d__16.MoveNext()
--- End of stack trace from previeous location where exception was thrown ---
    at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
    at Umbraco.Deploy.Environments.RemotUmbracoEnvironment.d__32.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
    at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
    at Umbraco.Deploy.WorkItems.DeployRestoreWorkItemBase.d__15.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
    at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
    at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
    at System.Runtime.CompilerServices.TaskAwaiter.ValidateEnd(Task task)
    at Umbraco.Deploy.WorkItems.SourceDeployWorkItem.d__15.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
    at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
    at Umbraco.Deploy.WorkItems.SourceDeployWorkItem.d__15.MoveNext()
---> (RemoteApiException) System.IO.PathTooLongException: The specified path, file name, or both are too long. The fully qualified file name must be less than 260 characters, and the directory name must be less than 248 characters.
```

This is a known issue with Microsoft servers, that limits the amounts of characters allowed in a path.

## Solution

In order to fix this error, you will need to connect to the Live Environments project's database.

1. Connect to your Live environments [database](../../../build-and-customize-your-solution/ready-to-set-up-your-project/databases/cloud-database/local-database.md#connecting-to-your-local-umbraco-installation).
2.  In the database run the following query to find the faulty media files:

    ```sql
    SELECT TOP (2000) [id],
    [path],
    LEN(path) AS valueLength
    FROM [dbo].[umbracoMediaVersion]
    WHERE LEN(path) > 80
    AND path IS NOT NULL
    ORDER BY LEN(path) DESC;
    ```
3. Find the files in the Media section in the Umbraco backoffice.
4. Remove the media files from the backoffice.
   * Make sure to note down where the media item is being used in the content
5. Change the names of the media files giving them a name shorter than 80 characters.
6. Re-upload the renamed file to the Media section in the backoffice.

Once re-added in the backoffice, make sure to add the media back in the content where it was used.
