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

### Dynamic:                              

    @if (CurrentPage.HasValue("miniFigure"))
    {
        var preValue = Umbraco.GetPreValueAsString(CurrentPage.miniFigure);
        <p>@preValue</p>
    }   