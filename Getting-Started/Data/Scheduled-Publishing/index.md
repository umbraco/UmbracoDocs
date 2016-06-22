#Scheduled Publishing
Each document in Umbraco can be scheduled for publishing and unpublishing on a pre-defined date and time. In order to do this, go to the "Properties" tab and find the "Publish at" and "Unpublish at" fields. There you can select the exact date and time to publish and unpublish the current content item.

![Scheduled publishing](images/Publish-At.jpg)

##Timezones <a href="#timezones"></a>
Your server may be in a different timezone then where you are located. As of Umbraco version 7.5, you are able to select a date and time in your local timezone and Umbraco will make sure that the item gets published at the selected time. So if you select 12PM then the item will be published at 12PM in the timezone you are in. This may be 8PM on the server, which is indicated when you select the date and time.

![Scheduled publishing](images/Publish-Timezone-Difference.jpg)

If you are in the same timezone as the server, this message will not appear under the date picker.

**Note:** In Umbraco versions lower than 7.5, the time you select has to be the time on the server, these older versions of Umbraco do not detect your local timezone. 

##Permissions
You can only select a date and time if you have permissions to publish the selected content item, so if your user is in the "Writer" role you might not be able to select a time here.