# July 2026

## Key Takeaways

* **Sustainability Dashboard - Bandwidth emissions** - The dashboard now includes the CO2 from network egress as a new Bandwidth component, estimated from your sites' actual data transfer. Network emissions were previously not counted.

## Sustainability Dashboard: Bandwidth emissions

The Sustainability Dashboard now reports the CO2 emissions from network egress. This is the data your sites transfer to visitors over the network. It appears as a new **Bandwidth** component, alongside the Azure resources already in the report.

Until now, the dashboard counted only the Azure infrastructure that hosts your sites, and network traffic was listed as not included. The Bandwidth component closes that gap. The report now reflects both the hosting and the delivery of your sites.

Umbraco Cloud estimates these emissions from the volume of data your sites transfer each month, measured at the edge. The estimate uses the network energy intensity from the Sustainable Web Design Model (0.059 kWh per GB) and a global average grid carbon intensity (494 g CO2e per kWh). Data served from the cache is counted at a lower rate, because it travels a shorter network path.

Bandwidth appears in the per-component breakdown for each project and in the CSV export. Like the other components, it is reported per month. A month's data becomes available a few weeks after the month ends.

For details on the calculation, see the [Sustainability Dashboard](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/sustainability-dashboard.md) documentation.
