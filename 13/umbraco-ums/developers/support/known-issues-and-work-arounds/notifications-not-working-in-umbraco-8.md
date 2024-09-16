# Notifications not working in Umbraco 8

If you are using the Notification feature on Umbraco nodes and uMarketingSuite is installed you could see the following error:

![]()

This is a known issue and not implemented and supported by Umbraco. See:

![]()

[https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Core/Services/Implement/NotificationService.cs#L380](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Core/Services/Implement/NotificationService.cs#L380)

To implement this you need to create your own NotificationService.cs

Below you will find a custom implementation. The code attached comes without any warranty.

[Download example file.](/{localLink:umb://media/c3d0c7b708f04a47b3d412978975d314} "Customumbnotificationservice")