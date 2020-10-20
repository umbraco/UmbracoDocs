---
versionFrom: 7.0.0
---

# Error: "An existing connection was forcibly closed by the remote host"

Sometimes you will get an error that looks like this:
```xml
System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host
System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.
System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.
System.Net.Http.HttpRequestException: An error occurred while sending the request.
```

This error indicates that your local environment can not connect to your Umbraco Cloud environment due to a socket exception. Since all Umbraco Cloud connections runs on TLS 1.2, your project will have to support this as well. TLS 1.2 is only supported in the .Net Framework 4.6+.

## How to fix your connection error

To resolve the issue, please follow the following two steps:
1. Locate the two `targetFramework` properties in your `Web.config` file.
2. Update these to a .Net version higher than 4.6 - preferably 4.7.2. 

:::note
You will need to have the runtime of your new .Net version, installed on your computer in order to run the project locally. [You can download all .Net run times from Microsoft right here](https://dotnet.microsoft.com/download).
:::