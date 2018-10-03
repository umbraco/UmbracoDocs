# Color Picker #

`Alias: Umbraco.ColorPicker`

`Returns: String (Hexadecimal)`
`Returns: Umbraco.Core.PropertyEditors.ValueConverters.ColorPickerValueConverter+PickedColor (When using labels)`

The Color picker allows you to set some predetermined colors that the editor can choose between.

## Data Type Definition Example

![Content Picker Data Type Definition](images/Color-Picker-DataType.png)

## Content Example 

![Content Picker Content](images/Color-Picker-Content.png)

## Example: ##

    @{ 
        var hexColor = Model.Content.Color;
        String colorLabel = Model.Content.Color.Label;

        if (hexColor != null)
        {
            <div style="background-color: @hexColor">@colorLabel</div>
        }
    }
