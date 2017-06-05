# Add a Nicely Formatted Blog Publication Date
Learn how to add a new *publication* date to blog posts.

## Outcome
Content editors can specify a new publication date for a blog post if its creation date is not appropriate.

## Takeaway
Learn how to:
* Add a new property to a document
* Edit a template to display the new property
* Use an Umbraco helper method to change how the value is rendered
* Edit a partial template to display the new property
* Sort a list by a custom property

## Steps - Part One
1. In the **Settings** section, expand **Document Types**.  A Document Type is the blueprint for a page: it defines the fields that editors will be asked to complete when creating a new page of that type.
2. Click on *Blogpost*.
3. Scroll to the bottom of the *Content* section in the editing pane and click **Add property**.  This opens the **Property Editor** dialog window.
4. Enter a Name of *Publication Date*.  When you move off this field Umbraco will automatically generate the next item (the property's alias) so you don't need to worry about that, the default is fine.
5. Enter a Description of *If you don't want to publish the actual date that this page was created, specify the date to use instead*.
6. Click **Add editor** to specify what type of data we want the editor to enter.  We need a date, so select the **Reuse** tab, then click on the **Date Picker** icon.
7. Click Submit to close the dialog box.
8. If we were to save these changes, the date picker would appear under the content area, so content editors might miss it.
9. Click the **Reorder** link in the top right of editor pane.
10. Drag and drop the new property you just added to be just above the *Content* property. 
11. Then click *Save*. A confirmation message should appear confirming that the Document Type has been saved.  If you had tried to go elsewhere without saving you would be shown a reminder to do so!

Great! Now [Proceed to Part Two](part-2.md)
