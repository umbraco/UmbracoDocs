# Rewrite rules on Umbraco Cloud

To make rewrite rules on Umbraco Cloud as seamless as possible, we've installed the [IIS Rewrite Module](https://our.umbraco.org/Documentation/Reference/Routing/IISRewriteRules/) on all our Umbraco Cloud servers.

The rewrite rules should be added to the `<system.webServer><rewrite>` module in your projects `Web.config` file.

    <!--
    If you wish to use IIS rewrite rules, see the documentation here: 
    https://our.umbraco.org/documentation/Reference/Routing/IISRewriteRules
    -->

    <!--
    <rewrite>
        <rules></rules>
    </rewrite>
    -->



## Best practices

- umbraco backoffice access
- Issues with deployments caused by rewrite rules