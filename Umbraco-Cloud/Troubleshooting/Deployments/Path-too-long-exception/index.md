# Path too long Exception

When you have Media files on your Umbraco Cloud project with a file-name longer than 80 characters, you will not be able to transfer and / or restore between your Cloud environments.

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
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Umbraco.Deploy.Environments.RemoteUmbracoEnvironment.d__32.MoveNext()
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

The following command should short for files with a name less than 80 characters - has been reported to not work though: