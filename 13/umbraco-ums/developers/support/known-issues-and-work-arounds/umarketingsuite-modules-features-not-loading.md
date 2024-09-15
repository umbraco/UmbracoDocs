**Behaviour:**

Not (all) uMarketingSuite modules / features / tabs are loading in Umbraco and you are experiencing console errors as of uMarketingSuite version 1.20

**Possible detailed error message:**

1)

**![]()**

2)

![]()

**Cause:**

The AngularJS files are bundled in uMarketingSuite 1.20 based on the Github issue [https://github.com/uMarketingSolutions/uMarketingSuite/issues/24](https://github.com/uMarketingSolutions/uMarketingSuite/issues/24)

**Solution:**

Make sure to remove the ***App\_Plugins/uMarketingSuite*** folder on the target environment before the new deployment.

**Last updated:**

August 23, 2022