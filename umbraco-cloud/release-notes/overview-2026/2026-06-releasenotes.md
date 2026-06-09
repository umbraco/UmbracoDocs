# June 2026

## Key Takeaways

* **Baseline enhancements** - The **Manage child projects** page loads faster. More data is shown on each child project, and the list has more filtering options.


## Baseline enhancements

The **Manage child projects** page now loads faster after an overhaul of the underlying API call flow.

<figure><img src="../../.gitbook/assets/baseline-manage-child-project.png" alt="Baselines - Manage child projects page"><figcaption><p>The Manage child projects lists child projects connected to the baseline.</p></figcaption></figure>

The **Manage child projects** page has also been enhanced with more data:

* Last update (UTC) has been added for each child
* If a child has not been updated within the last 5 baseline updates, it shows a generic message
* A child can have an indicator to show that it is behind the baseline

<figure><img src="../../.gitbook/assets/baselines-no-updates-back-five.png" alt="Baselines - Child was not updated in the last 5 updates"><figcaption><p>A child project that has not been updated within the last 5 baseline updates shows a generic message.</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/baselines-components-behind.gif" alt="Baselines - Show components on child project which are behind the baseline"><figcaption><p>Show components on child project which are behind the baseline.</p></figcaption></figure>

Filtering options now allow you to sort by `Project name` or `Last update (UTC)`.

If you have a long list of baseline children, the action bar and headers are now sticky. They stay visible when you scroll.

The action bar has a button to select all children where component versions are behind the baseline.

