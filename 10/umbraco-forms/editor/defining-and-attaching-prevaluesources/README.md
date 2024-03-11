# Defining And Attaching Prevalue Sources

Prevalue sources are a way to pre-define and/or retrieve a list of items from a certain source. They can be added in any field types that include some kind of list like Dropdown and Multiple/Single Choice lists.

## Setting up a Prevalue Source

Prevalue sources can be managed in the **Prevalue sources** folder available in the **Forms** section.

![Prevalue source tree](images/prevaluesourcetree.png)

To set a prevalue source:

1. Navigate to the **Forms** section.
2. Right-click the **Prevalue sources** folder and select **Create**.
3. A new page opens in the right-side of the editor where you'll need to setup and configure your prevalue source.
4. Enter a **Name**.
5.  Select the type of prevalue source from the **Type** drop-down. For more information on the different default types, see the [Overview of the Prevalue Source Types](prevalue-source-types.md) article.

    ![Choose type](images/choosetype.png)

### Configuring the Prevalue Source

Depending on the **Type** you choose, you'll need to provide some additional settings:

1. In this walk-through, we will select **Get values from textfile** from the **Type** drop-down. ![Type settings](images/typesettings.png)
2.  Now, provide a file containing the list to use as prevalues. For example: A `.txt` file containing the following values:

    ```
    example value 1
    example value 2
    example value 3
    example value 4
    example value 5
    ```
3. Select **Pick File** and choose the text file you created.
4. Once the text file is uploaded, click **Save** to save the prevalue source.
5.  If the file is successfully uploaded and validated, you will see an overview of the values in a tabular format.

    <figure><img src="images/preview.png" alt=""><figcaption></figcaption></figure>

If you would like to have different values presented to your users from the value stored, you can provide two values per line, separated with a vertical bar (|), e.g.:

```
1|example value 1
2|example value 2
3|example value 3
4|example value 4
5|example value 5
```

In this case the user would pick from a list showing the captions, but the single integer values would be stored with the record.

This can be useful if the recorded entries are used in any subsequent workflows or business processes, where particular values, that aren't appropriate for the user to select from, are required.

![Prevalues with captions](images/Prevalues-with-caption.png)

### Defining Cache Options for the Prevalue Source

Sometimes retrieving the list of options for a prevalue source can be an expensive operation. If the source depends on data from external systems, it could be that the list changes regularly or rarely.

Given the variation here, we allow you to select an appropriate level of caching for the list of options.

You can choose between:

* `No Caching` - no caching will be applied and the list of options will be retrieved from source on every request. You will likely only want to choose this option if the information changes frequently and it's important that the latest is presented to website visitors.
* `Cache For Specified Time` - the list will be cached for the period of time provided.
* `Cache With No Expiry` - the list will be cached on first request and not retrieved again until either the prevalue source is edited or the website is restarted. This is most appropriate to use for information held within the prevalue source data itself (such as when uploading a text file).

![Prevalue cache options](images/prevalue-cache-options.png)

## Attaching a Prevalue Source to a Field

Once a prevalue source has been created, it can be used while building Forms in the Forms designer.

**Example:** Let's add a Multiple Choice field type in our Form.

If there is at least one prevalue source defined in the project, the Prevalues source will contain a dropdown from where you can choose the predefined value.

![Prevalue source](images/FieldPrevalueSource.png)

Once you have selected the prevalue source, the values are rendered in the Forms designer from the attached source.

![Preview](images/fieldpreview.png)
