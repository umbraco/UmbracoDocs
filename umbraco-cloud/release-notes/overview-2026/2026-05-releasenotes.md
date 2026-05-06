# May 2026

## Key Takeaways

* **Error pages** - Upload your own HTML error pages and assign them per hostname. Visitors see your page instead of the default Umbraco Cloud error page when your site is temporarily unavailable.
* **Baseline enhancements** - An activity starts when the baseline pushes updates to child projects.
* **Edge traffic analytics on Traffic & Performance** - The Traffic & Performance page now combines Azure application metrics with Cloudflare edge analytics. New edge metric tiles, chart series, and breakdown tables let you analyze HTTP traffic by status code, cache status, geography, devices, and more.

## Error pages

You can now upload custom HTML error pages directly from the Umbraco Cloud Portal and assign them to any hostname across your environments. When an environment restarts, like during a deployment, visitors see your page instead of the default Umbraco Cloud error page.

<figure><img src="../../.gitbook/assets/cloud-error-pages-manage.png" alt="Manage Error Pages tab listing uploaded custom error pages"><figcaption><p>The Manage Error Pages tab lists all uploaded pages and their hostname assignments.</p></figcaption></figure>

The feature is available under **Settings** > **Error Pages** and has two tabs:

* **Managing Error Pages**: Upload, preview, edit, replace, and delete custom HTML pages (max 20 KB per file). Mark one as the default fallback for all new hostnames.
* **Hostname Assignments**: See every hostname across all environments and which error page it uses. Assign pages individually or in bulk, and filter by environment, domain, or Top Level Domain.

Because error pages are served by Cloudflare directly from blob storage, they must be fully self-contained. All CSS, JavaScript, and fonts need to be inline; external resources will not load. A reload mechanism is recommended, automatically sending visitors back to your site once it recovers.

For authoring guidelines and a ready-to-use HTML template, see the [Error Pages](../../build-and-customize-your-solution/handle-deployments-and-environments/error-pages.md) documentation.

## Baseline enhancements

Pushing a baseline update to child projects will trigger an activity on the baseline project. The activity is non-blocking, but will run until all children are updated.

## Edge traffic analytics on Traffic & Performance

The **Traffic & Performance** page now combines Azure application metrics with Cloudflare edge analytics. When at least one hostname is selected, the page shows edge metric tiles (Requests and Data Transfer), edge series on the chart, and a Traffic Breakdown Tables section.

<figure><img src="../../.gitbook/assets/tp-page-overview.png" alt="The Traffic & Performance page showing the selectors, overview tiles, chart, and breakdown tables."><figcaption><p>The Traffic & Performance page.</p></figcaption></figure>

The breakdown tables let you drill into edge traffic by status code, cache status, HTTP version, paths, hosts, data centers, geography, browsers, devices, operating systems, and more. A toggle at the top of the section switches the view between request count and data transferred.

For full details, see the [Traffic and Performance](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/traffic-and-performance.md) documentation.
