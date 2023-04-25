# Session Timeout

Umbraco is set up to automatically log out users who remain inactive for more than 20 minutes. However, any backoffice request will reset the clock and restore user activity. 

The following snippet allows you to customize the duration of user inactivity in Umbraco. By default, the timeout duration is set to 20 minutes. To adjust this value, simply modify the `"TimeOut"` parameter in the code snippet.

{% hint style="info" %}  If the session timeout is set too long, it may increase the risk of exposing confidential data or enable attackers to gain unauthorized access to the session. Therefore, it is imperative to establish a reasonable session timeout to minimize potential security risks. {% endhint %}

```json
"Umbraco": {
  "CMS": {
    "Global": {
      "TimeOut": "00:20:00",
    }
  }
}
```

