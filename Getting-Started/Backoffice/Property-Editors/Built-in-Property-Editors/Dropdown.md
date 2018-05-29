# Dropdown

`Returns: String`

Displays a list of preset values. Either a single value or multiple values (formatted as a comma-seperated string) can be returned.

## Settings

### Enable multiple choice
If ticked, editors will be able to select multiple values from the dropdown otherwise only a single value can be selected.

### Prevalues
Prevalues are the options which are shown in the dropdown list. You can add, edit, or remove values here.

## Data Type Definition Example

![Dropdown Data Type Definition](images/Dropdown-DataType.png)

## Content Example

### Single Value

![Single dropdown content example](images/DropdownSingle-Content.png)

### Multiple Values

![Multiple dropdown content example](images/DropdownMultiple-Content.png)

## MVC View Example

### Typed - single item:

    @if (Model.Content.HasValue("category"))
    {
        <p>@(Model.Content.GetPropertyValue<string>("category"))</p>
    }

### Typed - multiple items:

    @if (Model.Content.HasValue("categories"))
    {
        var categories = Model.Content.GetPropertyValue<string>("categories").Split(',');
        <ul>
            @foreach (var category in categories)
            {
                <li>@category</li>
            }
        </ul>
    }
