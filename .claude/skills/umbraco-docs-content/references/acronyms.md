# Acronyms Reference

Acronym usage in Umbraco documentation is enforced by a Vale style rule at `.github/styles/UmbracoDocs/Acronyms.yml`.

## Rule Behavior

The Vale rule checks for any 3-5 letter uppercase word and requires it to be defined on first use in the article — unless the acronym is in the exceptions list.

If you use an acronym that is **not** in the exceptions list, you must define it on first use using one of these formats:

```markdown
<!-- Parenthesis format -->
Members will only have access to **Content Delivery Network (CDN)** endpoints.

<!-- Colon format -->
**YSOD: Yellow Screen of Death**, .NET error page
```

## Pre-Approved Exceptions

The following acronyms are in the exceptions list and do **not** need to be defined on first use. They are common enough that readers are expected to know them:

AAAA, ADD, ADO, AJAX, ALT, API, ASCII, ASP, BCC, CD, CDN, CI, CLI, CNAME, CMD, CMS, CPU, CRM, CRUD, CSS, CSV, CTRL, CURL, DELETE, DHL, DIBS, DLL, DNS, DOM, DXP, EOL, FAQ, FTP, GDPR, GET, GIF, GUI, GUID, HAL, HASH, HEX, HTML, HTTP, HTTPS, IaaS, IDE, IIS, INFO, ISO, JPG, JPEG, JSON, JSONP, JS, JWT, KUDU, LDAP, LINK, LINQ, LLM, MCP, MIT, MDN, MFA, MVC, NET, NGINX, NPM, OAuth, ONLY, ORM, PaaS, PATH, PDF, PNG, POST, PUT, RAM, REST, RGBA, RPG, RTX, SaaS, SDK, SEO, SHIFT, SPACE, SKU, SMTP, SQL, SSD, SSL, SVG, TCP, TEMP, TS, TXT, TLS, UDA, UDI, UI, URI, URL, USB, UTC, UUID, UWP, UX, VAL, VAT, VIP, WAF, WYSIWYG, XML, XLTS, XSLT, XSS, YAML, ZIP

## Adding a New Acronym Exception

If you introduce an acronym that will be used frequently across many articles and is widely understood, you can add it to the exceptions list:

1. Open `.github/styles/UmbracoDocs/Acronyms.yml`
2. Add a new entry to the `exceptions:` list in **alphabetical order**
3. Include a comment with the full definition:
   ```yaml
   exceptions:
     # ... existing entries ...
     - MQTT     # Message Queuing Telemetry Transport
     # ... existing entries ...
   ```
4. Keep the formatting consistent: acronym padded to 8 characters, then `# ` followed by the definition

## When to Add vs. Define Inline

- **Add to exceptions**: The acronym appears in many articles and is widely known in the technical community (e.g., API, SQL, HTML)
- **Define inline only**: The acronym is domain-specific, appears in few articles, or may be unfamiliar to the general developer audience
