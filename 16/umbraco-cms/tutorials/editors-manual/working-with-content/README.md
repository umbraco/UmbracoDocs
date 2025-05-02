# Working with Rich Text Editor

The Umbraco Rich Text Editor (RTE) is a field where you, as an editor, can be creative. You can select how much you want to do yourself. You can work on text content, format the text, or leave it the way it is. If you want to do more, you can insert images, create tables, or create links to other pages/documents.

The functionality varies depending on how the editor is set up. Here, we describe the default editor with all the options enabled. Contact your system administrator for details regarding your editor.

## Editor Buttons

By default, the following editor buttons are available. Your system administrator can determine which buttons are displayed in different templates. You therefore might have access to more or fewer buttons than those shown here.

![Editor Bar](images/editor\_bar\_v14.png)

## Paragraph Break/Line Break

The Rich Text Editor is like any other word-processing program. You write the text and the text wraps around when the line reaches the end. Use the following keyboard shortcuts in the editor to add:

* Space between paragraphs - press `ENTER`.
* Line breaks - press `SHIFT + ENTER`.

## Shortcut Keys

To make your work easier, there are shortcut keys for certain editor functions. Use the following shortcut keys to carry out certain commands:

| Shortcut | Action     |
| -------- | ---------- |
| Ctrl + A | Select all |
| Ctrl + B | Bold       |
| Ctrl + C | Copy       |
| Ctrl + I | Italic     |
| Ctrl + U | Underline  |
| Ctrl + V | Paste      |
| Ctrl + X | Cut        |
| Ctrl + Y | Redo       |
| Ctrl + Z | Undo       |

We have listed only a few keyboard shortcuts. For a detailed list of available keyboard shortcuts, see the [Tiptap Documentation](https://tiptap.dev/docs/editor/core-concepts/keyboard-shortcuts).

## View Source Code

![View Source Code](images/view-source-code-v11.png)

If you are proficient in HTML, you can switch to HTML mode to create your page. You can also check the code and make minor adjustments to get the page exactly as you want.

Certain elements such as scripts are not recognized by the HTML view of the Rich Text Editor. You can enter the scripts directly in the text view of the editor.

## Formats

![Format Dropdown](images/Formats-Button-v11.png)

You can apply formatting via the **Formats** drop-down list. The Formats drop-down list provides predefined styles that can be applied to text while maintaining a consistent look and feel throughout the site.

These styles incorporate advanced formatting functionality which can be applied to provide a different look for certain elements such as links, headings, and sub-headings. For example, you can use a format style to change a link into a call-to-action button.

To apply pre-defined styles:

1. Select the text you want to apply the style.
2. Choose the style from the **Format** drop-down list.

For more information on how to create the Styles, see the [Rich Text Editor Styles](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/rte-styles) article.

## Text Formatting

You do not normally need to spend much time formatting text because Umbraco takes care of the formatting. However, the editor provides some options for controlling the text styles.

### Formatting Buttons

![Formatting Buttons](images/Formatting-Buttons-v11.png)

The most familiar way to control formatting is by using the formatting buttons. With these buttons, you can apply basic formatting such as Bold, Italic, aligning text, creating bulleted and numbered lists, and applying indents.

To apply a format using the formatting buttons:

1. Select the text you want to apply the formatting.
2. Click the desired format button.

### Copying Content from Other Programs

{% hint style="info" %}
When you write content in another editor and copy it into a Rich Text Editor, you may encounter style issues on your website.
{% endhint %}

While pasting content, the original text styles are preserved which can lead to different font faces, sizes, and colors displaying on the website when viewed.

{% hint style="info" %}
To prevent formatting issues, we recommended pasting the content first into a markdown editor such as Notepad, then copying and pasting it into your Rich Text Editor.
{% endhint %}

### Remove Formatting

![Remove Format Button](images/Remove-Format-v11.png)

If you have already formatted a paragraph or selection using the formatting buttons, you can remove the formatting rule.

To remove formatting:

1. Select the text you want to remove the style from.
2. Click the relevant formatting button to remove the formatting rule.

You can also add a **Remove format** button in your toolbar. To add the **Remove format** button:

1. Navigate to your Rich Text Editor in the Document Type.
2. Click the cog wheel.
3. Click **Edit** next to the Rich Text Editor Data Type.
4. Select **Remove format** under the **Toolbar Configuration**.
5. Click **Submit**.
6. Click **Save**.

## Links

![Link Button](images/Link-Button-v11.png)

The **Insert/Edit Link** button is used to add or update links to internal pages, external pages, media files, email links, and anchors. The process for inserting a hyperlink differs depending on the type of hyperlink you wish to create.

To insert different types of hyperlinks, follow these steps:

<details>

<summary>Link to a Page on Another Website</summary>

<img src="images/Link-to-an-external-Page-v11.png" alt="Link to a Page on another Website" data-size="original">

1. Select the text that will form the hyperlink.
2. Click the **Insert/Edit Link** button to open the link properties slide-out menu.
3. Enter the URL of the web page you wish to link to in the **Link** field.
4. Enter the text that will be displayed as the link title in the **Link Title** field.
   * This is important information for everyone reading the website with different accessibility aids.
5. Select the **Target** field to open the link in a new window or tab.
6. Click **Submit**.

</details>

<details>

<summary>Link to a Page in Umbraco</summary>

<img src="images/Link-to-a-Page-v11.png" alt="Link to a Page in Umbraco" data-size="original">

1. Select the text that will form the hyperlink.
2. Click the **Insert/Edit Link** button to open the link properties slide-out menu.
3. Select a page from the **Link to page** field.
   * This will populate the **Link** and **Link Title** fields automatically.
4. Select the **Target** field to open the link in a new window or tab.
5. Click **Submit**.

</details>

<details>

<summary>Link to a Media File in Umbraco</summary>

<img src="images/Link-to-Media-File-v11.png" alt="Link to a Media File in Umbraco" data-size="original">

1. Select the text that will form the hyperlink.
2. Click the **Insert/Edit Link** button to open the link properties slide-out menu.
3. Select the **Link to Media** button to select the media item.
4. Click **Select**.
   * This will automatically populate the **Link** and **Link Title** fields with the media item information.
   * By default, the **Link** field contains the media file name and cannot be edited.
5. Select the **Target** field to open the link in a new window or tab.
6. Click **Submit**.

</details>

<details>

<summary>Link to an Email Address in Umbraco</summary>

<img src="images/Link-to-Email-Address-v11.png" alt="Link to an Email Address in Umbraco" data-size="original">

1. Select the text that will form the hyperlink.
2. Click the **Insert/Edit Link** button to open the link properties slide-out menu.
3. Enter the text `mailto:` followed by the email address you wish to link to in the **Link** field. For example, `mailto:contact@umbraco.com`.
4. Enter the text that will be displayed as the link title in the **Link Title** field.
5. Select the **Target** field to open the link in a new window or tab.
6. Click **Submit**.

</details>

<details>

<summary>Link to an Anchor on the Same Page</summary>

An anchor allows you to create internal page links that enable users to navigate within a page. There are two parts to setting up an anchor: the anchor itself and the link to the anchor.

#### Creating an Anchor

<img src="images/Creating-an-anchor-v11.png" alt="Creating an Anchor" data-size="original">

1. Click the editor cursor where you wish to create the anchor.
2. Click the **Anchor Button** which will launch the Anchor creation dialog.
3. Enter your anchor name in the **ID** field.
   * You should avoid special characters and spaces.
4. Click **Save**.
   * You will see a small anchor icon where you previously had the editor cursor.

To delete the anchor:

1. Select the anchor icon.
2. Press your **Delete** key.

<img src="images/Delete-an-anchor-v11.png" alt="Deleting an Anchor" data-size="original">

#### Linking to an Anchor

<img src="images/Linking-to-Anchor-v11.png" alt="Linking to an anchor" data-size="original">

1. Select the text to which you wish to add the anchor link to.
2. Click the **Insert link** button to open the link properties slide-out menu.
3. Add a hash symbol (#) followed by the name of your anchor in the **Anchor/querystring** field.
4. Enter the text that will be displayed as the link title in the **Link Title** field.
5. Click **Submit**.

</details>

<details>

<summary>Create a Link from an Image</summary>

You can make images into clickable links in Umbraco:

<img src="images/Link-from-Image-v11.png" alt="Create a Link from an Image" data-size="original">

1. Insert an image into the Rich Text Editor.
   * For more information, see the [Working with Images](./#working-with-images) section.
2. Select the image that will form the hyperlink.
3. Enter the URL of the web page you wish to link to in the **Link** field.
4. Enter the text that will be displayed as the link title in the **Link Title** field.
5. Select the **Target** field to open the link in a new window or tab.
6. Click **Submit**.

</details>

<details>

<summary>Removing a Link</summary>

<img src="images/Remove-link-v11.png" alt="Remove link Button" data-size="original">

To remove a link:

1. Select the link in the Rich Text Editor.
   * For text links, click the cursor anywhere within the link text. For an image, click the image itself.
2. Click the **Remove Link** button which will remove the hyperlink.
3. Alternatively, you can click the **Insert/Edit Link** button and remove the link from the **Link** field.

</details>

## Working with Images

To display images on a page the images must be uploaded to your Umbraco media library.

Many administrators set up a media library containing images that editors can use on their pages. Others allow their editor's free use of their images. The procedure for uploading an image varies slightly depending on which method your administrators have setup. Check with your system administrator for more information about this.

<details>

<summary>Inserting an Image from the Media Library</summary>

<img src="images/Inserting-Image-from-the-Media-Library-v11.png" alt="Inserting an Image from the Media Library" data-size="original">

1. Place the cursor in the Rich Text Editor where you want to insert your image.
2. Click the **Media Picker** button from the toolbar.
3. Select the folder in which the image is.
4. Click the thumbnail of your chosen image to open the image properties menu.
5. Enter a name/description for the image in the **Caption (optional)** field.
   * It is important to add descriptive titles to images as these are used to assist visually impaired users.
6. Click **Select**.

</details>

<details>

<summary>Inserting an Image from your Computer</summary>

You can upload images directly from the Rich Text Editor on the page you are editing. These images will be stored in the Umbraco Media Library. Therefore, it would be best to ensure the image is placed in the correct location within the library. If you click the plus icon underneath the search bar in the media picker slide-out menu you can create folders in the media library.

<img src="images/Inserting-an-Image-from-Computer-v11.png" alt="Inserting an Image from your Computer" data-size="original">

1. Place the cursor in the Rich Text Editor where you want to insert your image.
2. Click the **Media Picker** button from the toolbar.
3. Click the **Upload** button which is located in the top right-hand corner of the menu.
4. Select the chosen image from the pop-up window.
5. Enter a name/description for the image in the **Caption (optional)** field.
6. Click **Select**.

</details>

<details>

<summary>Deleting an Image from the Page</summary>

To delete an image from the page:

1. Select the image.
2. Press the **Delete** button on your keyboard.
   * The image disappears from the page but is not deleted from the Umbraco Media library.

</details>

## Tables

![Inserting a Table](images/Insert-a-table-v11.png)

Tables are used to format information in a grid-based structure. When you insert a table, you select how many rows and columns the table should comprise of. Additionally, you can fill in some optional formatting properties. These values can be changed later, so it is not important to know exactly what your table will look like when you create it.

### Editing an Existing Table

![Editing an Existing Table](images/Editing-an-existing-table-v11.png)

To edit the table after creating it, click on the table. A pop-up appears with different table properties and options. Alternatively, you can click on the **Table** button in the Rich Text Editor toolbar.

![Table Properties](images/table-properties-v11.png)

Clicking on **Table Properties** gives you different options for modifying the table’s appearance. However, the developer of the website may have already created table styles for you so you may not need to adjust these settings.

There are other options available for modifying cells, rows, and columns such as width, height, alignment, border, and so on.

## Configuring a Rich Text Editor

The Rich Text Editor in Umbraco can be configured in many different ways.

For more information, see the [Rich Text Editor Configuration](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/configuration) article.
