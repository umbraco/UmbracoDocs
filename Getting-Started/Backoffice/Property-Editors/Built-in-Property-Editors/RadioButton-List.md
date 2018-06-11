# Radiobutton List

`Returns: Prevalue ID`

Pretty much like the name indicates this Data type enables editors to choose from list of radiobutton

## Data Type Definition Example

![Radiobutton List Data Type Definition](images/wip.png)

## Content Example 

![Radiobutton List Content](images/wip.png)

## MVC View Example

### Typed:

    @if (Model.Content.HasValue("miniFigure"))
    {
        var preValue = Umbraco.GetPreValueAsString(Model.Content.GetPropertyValue<int>("miniFigure"));
        <p>@preValue</p>
    }

### Dynamic (Obsolete):

The below example is using Dynamic access content access, which is considered obsolete and is not recommended to use. However the example is included for historical reasons if for instance a developer has overtaken a project where this approach is being used. This approach will be obsolete when Umbraco 8 is released and therefore is best to use the strongly typed example listed above.

    @if (CurrentPage.HasValue("miniFigure"))
    {
        var preValue = Umbraco.GetPreValueAsString(CurrentPage.miniFigure);
        <p>@preValue</p>
    }   
