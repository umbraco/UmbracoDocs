---
description: >-
  A Hostname monitoring is a feature that allows users to track the availability
  and response times of their websites.
---

# Hostname Monitoring

Hostname monitoring in Umbraco Cloud allows users to track the availability and response times of their websites. This feature helps ensure optimal website performance and alerts users to potential downtime or performance issues. Users can add, edit, and view hostname monitors through the Umbraco Cloud Portal. A historical overview of uptime is available in the **Ping Results** section.

Hostname monitoring can be accessed under **Insights > Hostname Monitoring** on your project in the Umbraco Cloud Portal.

## Hostname Monitor Configuration

* **Hostname**: The domain or subdomain to monitor (e.g., `https://example.com` or `http://web.example.com`). Users can also monitor hostnames outside of Umbraco Cloud, such as static frontend websites hosted elsewhere for Heartcore projects.
* **Frequency**: The interval at which the hostname is checked (e.g., every X minutes). Valid values: 5, 10, 15, 30, 60, 360, 720, 1440 minutes.
* **Locations**: Users can select multiple locations to ping the web application from. Supported regions include Europe, the US, Australia, and the UK.
* **Max Response Time**: The maximum acceptable response time in seconds. Must be greater than 0.
* **Expected Status Code**: The HTTP status code that indicates a successful response (e.g., `200`, `301`, `404`). Any status code can be monitored, and this value determines whether the UI marks the response as a failure or success.
* **Monitor Enabled**: Toggle to enable or disable monitoring. Disabling a monitor stops the pings but retains history in **Ping Results**.

## Ping Results

* Displays logs of pings, including:
  * Timestamp
  * Duration
  * Monitoring server location
  * Response code
* A response code different from `200` may indicate an issue.

{% hint style="info" %}
The Ping Results table also shows [platform and CMS events](availability-performance.md#platform-and-cms-events), making it possible to see how different events impact performance.
{% endhint %}

## Plan Limitations

| Plan     | Lowest Frequency | Max Locations | Historical Data | Hostnames Monitors Supported |
| -------- | ---------------- | ------------- | --------------- | ---------------------------- |
| Starter  | 15 minutes       | 1             | 1 month         | 1                            |
| Standard | 10 minutes       | 2             | 3 months        | 5                            |
| Pro      | 5 minutes        | All           | 12 months       | 20                           |

## Notes

* A Ping Result response code of `-7` indicates a timeout. The hostname was unreachable within the timeout period of 60 seconds.
* Ensure that monitored hostnames resolve correctly and are accessible to avoid false alerts.

## Negative Status Codes

Hostname monitoring shows a number of custom HTTP response codes beyond the standard. These response codes are based on [Chromium's response codes](https://source.chromium.org/chromium/chromium/src/+/main:net/base/net_error_list.h) and give you more details about error responses.

| Code  | Error Code                                                | Description                                                                                                                                                                                                                  |
| ----- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| -2    | net::ERR\_FAILED                                          | Generic network error                                                                                                                                                                                                        |
| -3    | net::ERR\_ABORTED                                         | An operation was aborted (due to user action).                                                                                                                                                                               |
| -7    | net::ERR\_TIMED\_OUT                                      | Timed out                                                                                                                                                                                                                    |
| -10   | net::ERR\_ACCESS\_DENIED                                  | Access denied                                                                                                                                                                                                                |
| -20   | net::ERR\_BLOCKED\_BY\_CLIENT                             | Blocked                                                                                                                                                                                                                      |
| -100  | net::ERR\_CONNECTION\_CLOSED                              | Connection was closed (TCP FIN)                                                                                                                                                                                              |
| -101  | net::ERR\_CONNECTION\_RESET                               | Connection was reset (TCP RST)                                                                                                                                                                                               |
| -102  | net::ERR\_CONNECTION\_REFUSED                             | Connection was refused                                                                                                                                                                                                       |
| -103  | net::ERR\_CONNECTION\_ABORTED                             | Connection was aborted (no ACK received)                                                                                                                                                                                     |
| -104  | net::ERR\_CONNECTION\_FAILED                              | Connection attempt failed                                                                                                                                                                                                    |
| -105  | net::ERR\_NAME\_NOT\_RESOLVED                             | Host name could not be resolved                                                                                                                                                                                              |
| -106  | net::ERR\_INTERNET\_DISCONNECTED                          | Internet connection lost                                                                                                                                                                                                     |
| -107  | net::ERR\_SSL\_PROTOCOL\_ERROR                            | SSL protocol error                                                                                                                                                                                                           |
| -108  | net::ERR\_ADDRESS\_INVALID                                | Invalid IP address and/or port number                                                                                                                                                                                        |
| -109  | net::ERR\_ADDRESS\_UNREACHABLE                            | Unreachable IP address                                                                                                                                                                                                       |
| -110  | net::ERR\_SSL\_CLIENT\_AUTH\_CERT\_NEEDED                 | Server requested a client certificate for SSL client authentication                                                                                                                                                          |
| -112  | net::ERR\_NO\_SSL\_VERSIONS\_ENABLED                      | No SSL protocol versions are enabled                                                                                                                                                                                         |
| -113  | net::ERR\_SSL\_VERSION\_OR\_CIPHER\_MISMATCH              | Client and server don't support a common SSL protocol version or cipher suite                                                                                                                                                |
| -114  | net::ERR\_SSL\_RENEGOTIATION\_REQUESTED                   | Server requested a renegotiation (re-handshake)                                                                                                                                                                              |
| -116  | net::ERR\_CERT\_ERROR\_IN\_SSL\_RENEGOTIATION             | During SSL renegotiation (re-handshake), the server sent a certificate with an error                                                                                                                                         |
| -117  | net::ERR\_BAD\_SSL\_CLIENT\_AUTH\_CERT                    | SSL handshake failed because of a bad or missing client certificate                                                                                                                                                          |
| -118  | net::ERR\_CONNECTION\_TIMED\_OUT                          | Timed out                                                                                                                                                                                                                    |
| -123  | net::ERR\_SSL\_NO\_RENEGOTIATION                          | Peer sent an SSL no\_renegotiation alert message                                                                                                                                                                             |
| -138  | net::ERR\_ACCESS\_DENIED                                  | Access denied                                                                                                                                                                                                                |
| -141  | net::ERR\_SSL\_CLIENT\_AUTH\_SIGNATURE\_FAILED            | Unable to sign the CertificateVerify data of an SSL client auth handshake with the client certificate's private key                                                                                                          |
| -145  | net::ERR\_WS\_PROTOCOL\_ERROR                             | WebSocket protocol error - connection terminated due to a malformed frame or other protocol violation                                                                                                                        |
| -147  | net::ERR\_ADDRESS\_IN\_USE                                | Failed to bind to an address because already in use                                                                                                                                                                          |
| -148  | net::ERR\_SSL\_HANDSHAKE\_NOT\_COMPLETED                  | SSL handshake has not completed                                                                                                                                                                                              |
| -149  | net::ERR\_SSL\_BAD\_PEER\_PUBLIC\_KEY                     | SSL peer's public key is invalid                                                                                                                                                                                             |
| -150  | net::ERR\_SSL\_PINNED\_KEY\_NOT\_IN\_CERT\_CHAIN          | Certificate didn't match built-in public key pins for the host name                                                                                                                                                          |
| -151  | net::ERR\_CLIENT\_AUTH\_CERT\_TYPE\_UNSUPPORTED           | Server request for client certificate did not contain any types we support                                                                                                                                                   |
| -152  | net::ERR\_ORIGIN\_BOUND\_CERT\_GENERATION\_TYPE\_MISMATCH | Server requested one type of cert, then requested a different type while the first was still being generated                                                                                                                 |
| -153  | net::ERR\_SSL\_DECRYPT\_ERROR\_ALERT                      | SSL peer sent us a fatal decrypt\_error alert                                                                                                                                                                                |
| -156  | net::ERR\_SSL\_SERVER\_CERT\_CHANGED                      | SSL server certificate changed in a renegotiation                                                                                                                                                                            |
| -157  | net::ERR\_SSL\_INAPPROPRIATE\_FALLBACK                    | SSL server indicated that an unnecessary TLS version fallback was performed                                                                                                                                                  |
| -158  | net::ERR\_CT\_NO\_SCTS\_VERIFIED\_OK                      | All Signed Certificate Timestamps failed to verify                                                                                                                                                                           |
| -159  | net::ERR\_SSL\_UNRECOGNIZED\_NAME\_ALERT                  | SSL server sent us a fatal unrecognized\_name alert                                                                                                                                                                          |
| -164  | net::ERR\_SSL\_CLIENT\_AUTH\_CERT\_BAD\_FORMAT            | Failed to import a client certificate from the platform store into the SSL library                                                                                                                                           |
| -165  | net::ERR\_SSL\_FALLBACK\_BEYOND\_MINIMUM\_VERSION         | SSL server requires falling back to a version older than the configured minimum fallback version                                                                                                                             |
| -166  | net::ERR\_ICANN\_NAME\_COLLISION                          | Resolving a hostname to an IP address list included the IPv4 address "127.0.53.53". This is a special IP address which ICANN has recommended to indicate there was a name collision, and alert admins to a potential problem |
| -200  | net::ERR\_CERT\_COMMON\_NAME\_INVALID                     | Server responded with a certificate whose common name did not match the hostname                                                                                                                                             |
| -201  | net::ERR\_CERT\_DATE\_INVALID                             | Server responded with a certificate that is either expired or not valid yet                                                                                                                                                  |
| -202  | net::ERR\_CERT\_AUTHORITY\_INVALID                        | Server responded with a certificate signed by an untrusted authority                                                                                                                                                         |
| -203  | net::ERR\_CERT\_CONTAINS\_ERRORS                          | Server responded with a certificate that contains errors                                                                                                                                                                     |
| -204  | net::ERR\_CERT\_NO\_REVOCATION\_MECHANISM                 | Certificate has no mechanism for determining if it is revoked                                                                                                                                                                |
| -205  | net::ERR\_CERT\_UNABLE\_TO\_CHECK\_REVOCATION             | Revocation information for the security certificate for this site is not available                                                                                                                                           |
| -206  | net::ERR\_CERT\_REVOKED                                   | Server responded with a certificate that has been revoked                                                                                                                                                                    |
| -207  | net::ERR\_CERT\_INVALID                                   | Server responded with a certificate that is invalid                                                                                                                                                                          |
| -208  | net::ERR\_CERT\_WEAK\_SIGNATURE\_ALGORITHM                | Server responded with a certificate that is signed using a weak signature algorithm                                                                                                                                          |
| -210  | net::ERR\_CERT\_NON\_UNIQUE\_NAME                         | Host name specified in the certificate is not unique                                                                                                                                                                         |
| -211  | net::ERR\_CERT\_WEAK\_KEY                                 | Server responded with a certificate that contains a weak key                                                                                                                                                                 |
| -212  | net::ERR\_CERT\_NAME\_CONSTRAINT\_VIOLATION               | Certificate claimed DNS names that are in violation of name constraints                                                                                                                                                      |
| -213  | net::ERR\_CERT\_VALIDITY\_TOO\_LONG                       | Certificate's validity period is too long                                                                                                                                                                                    |
| -324  | net::ERR\_EMPTY\_RESPONSE                                 | Server closed the connection without sending any data                                                                                                                                                                        |
| -803  | net::ERR\_DNS\_TIMED\_OUT                                 | DNS lookup timed out                                                                                                                                                                                                         |
| -9999 | unknown error                                             | Error not mapped                                                                                                                                                                                                             |
