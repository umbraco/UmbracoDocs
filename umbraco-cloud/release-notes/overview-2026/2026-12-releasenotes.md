# December 2026

## Key Takeaways

* **Web Application Firewall** - Decide which requests reach each of your sites. Allow, challenge, or block requests for each domain from the Cloud Portal.

## Web Application Firewall

The new Web Application Firewall page lets you decide which requests reach each of your sites. Find the page under **Security** -> **Web Application Firewall** on your project in the Cloud Portal.

Every request passes through four steps, in this order:

* **Allow** - Lets the requests you choose skip the steps below. You can allow by IP address, path, country, or verified bot category.
* **Managed Block** - Stops requests that look like known attacks, such as SQL injection and cross-site scripting (XSS).
* **Challenge** - Answers with a "prove you are human" page. A person passes the page, a bot does not.
* **Block** - Answers with a 403 error.

You choose who is challenged or blocked by continent, country, path, verified bot category, and bot score. Block can also match IP addresses and user agents.

* **Settings for each domain.** A new domain starts with the default settings of its environment. A domain can also have its own settings.
* **Umbraco addresses.** You can block requests on the default `umbraco.io` address and on the deployment address of an environment.
* **Test a visitor.** Preview what your settings do to a request.
* **Pause protection.** Let every request through on one domain while your settings are kept.

The WAF settings under **Transport Security** keep working next to the new page.

For more details, see the [Web Application Firewall](../../build-and-customize-your-solution/set-up-your-project/security/web-application-firewall.md) documentation.
