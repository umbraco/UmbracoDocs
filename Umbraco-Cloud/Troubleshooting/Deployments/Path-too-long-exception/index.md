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
In order to fix this error, you will need to use [Power-tools Kudu](../../Set-up/Power-tools/)
1. Go to Kudu and navigate to CMD under the Debug console menu. Here you'll be presented with a navigable file structure 
2. Navigate to site/wwwroot/media
3. Write this command in CMD prompt - ```dir /s /b > out.txt```
4. That will generate an ```out.txt``` file which you have to download

![out.txt](images/out-txt.jpg)

5. Open that file with any editor that shows number of characters in line
6. Locate files with a path longer than 80 characters
7. Rename these files to be less that 80 characters (including folder extension, e.g. 1041/mediafile.jpg)
8. Re-upload the renamed file to the Media section in the backoffice

