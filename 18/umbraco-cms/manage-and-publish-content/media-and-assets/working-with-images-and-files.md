# Working with Media Types

The following default Media Types are available:

* Article - Used for uploading and storing documents.
* Audio - used for uploading and storing digital audio files.
* File - used for uploading and storing different types of files in the Media section.
* Folder - a container for organizing media items in the media tree.
* Image - used for uploading and storing images.
* Vector Graphics (SVG) - used for uploading and storing Scalable Vector Graphics files which are text files containing source code to draw the desired image.
* Video - used for uploading and storing video files.

## Uploading a Media Item

In the Media Library, there are multiple ways to upload media items. The two most commonly used ones are:

1. Use the **Create** button to create a new media item and then upload directly from your machine.
2.  The **...** next to the Media tree in the Media section.

    ![mediaUpload.jpg](../../.gitbook/assets/upload-images.png)

{% hint style="info" %}
It is recommended to use folders to organize your media items if you are going to add a lot of media to your website.
{% endhint %}

## Deleting a Media Item

If you wish to tidy up the Media section of your site, you can delete existing media items. Once you have deleted a media item, it is sent to the Recycle Bin. If you change your mind, you can restore the deleted media item from the Recycle Bin.

To delete a Media Item:

1. Select the media item you want to delete.
2. Click **...** and select **Trash**.

    ![mediaUpload.jpg](../../.gitbook/assets/delete-media-item.png)
3. Click **Trash**.

{% hint style="warning" %}
When media is moved to the recycle bin, the files are still accessible at their previous public URL. They will only be unavailable once the recycle bin is emptied or the media item is fully deleted.

If you wish to change this behavior, [see details for the `EnableMediaRecycleBinProtection` configuration option](../../develop-with-umbraco/configuration/contentsettings.md#enable-media-recycle-bin-protection).
{% endhint %}

## Restoring a Media Item from the Recycle Bin

The **Recycle Bin** is a separate tree structure within the Media section. Clicking on the arrow next to the Recycle Bin will display its contents.

To restore a Media Item:

1. Click **•••** next to the Media Item.
2. Select **Restore**.

    ![Restore Folder](../../.gitbook/assets/Restore-MediaItem.png)
3. Click **Restore**.

## Moving an Image or File

To move Media Items within the Media section:

1. Select the Media Item you want to move.
2.  Click **...** next to the Media Item and click **Move to**.

    ![Move media items](../../.gitbook/assets/move-images-v9.png)
3.  Choose the location where you want to move the Media Item to in the tree structure.

    ![Move Media.png](../../.gitbook/assets/Move-media-location.png)
4. Click **Choose**.

## More Information

* [Media Picker](../../model-your-content/property-editors/built-in-umbraco-property-editors/media-picker-3.md)
* [Creating Media](../../model-your-content/content-types-and-structure/data/creating-media/)
* [Rendering Media](../../develop-with-umbraco/templating-and-rendering/design/rendering-media.md)
