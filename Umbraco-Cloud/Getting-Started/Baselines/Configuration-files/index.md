# Handling configuration files

When you are doing your normal development process, you'd just be updating the configuration files in your solution as usual. When you are working with baselines there’s a thing to keep in eye.

When Umbraco Cloud is doing updates from the Baseline project to its children, all solvable merge conflicts on configuration files will be solved by using the setting on the Child project. That also means that if a file has been changed in both the Baseline and in the Child Project, the change won’t be pushed to the Child. To have custom settings on the Child project, you should take advantage of the vendor specific transform files. 

On Umbraco Cloud, it is possible to create transform files that will be applied to certain environments by naming them like `web.live.xdt.config` (see [Config-Transforms](../../Set-Up/Config-Transforms/)). This should be used when a Child Project needs different settings than the Baseline Project has. It can be achieved by using a configuration file that is specific to the Child Project, naming it like `child.web.live.xdt.config`, and only having that configuration file in the Child Projects repository. That will ensure that when doing deploys between the environments in the Child Project, those settings will be applied to the final web.config, and when the Child is updated from the Baseline, the settings won’t be overwritten.

This practice is especially important when the Baseline project gets major new functionality, like new code that is dependent on the configuration files or when it gets upgrades applied.
