---
keywords: numeric property editors v7.3 version7.3
versionFrom: 7.3.0
---

# Numeric

`Alias: Umbraco.Integer`

`Returns: Integer`

Numeric is a simple HTML input control for entering numbers. Since it's a standard HTML element the options and behaviour is all controlled by the browser and therefore is beyond the control of Umbraco.

## Data Type Definition Example

![Numeric Data Type Definition](images/numeric/7_3/numeric-datatype.png)

### Minimum
This allows you to setup a minimum value. If you will always need a minimum value of 10 this is where you set it up and whenever you use the datatype the value will always start at 10. It's not possible to change the value to anything lower than 10. Only higher values will be accepted.

### Step Size
This allows you to control by how much a value should be allowed to increase/decrease when clicking the up/down arrows. If you try to enter a value that does not match with the step setting then it will not be accepted.

### Maximum
This allows you to setup a maximum value. If you will always need a maximum value of 100 this is where you set it up. It's not possible to change the value to anything higher than 100. Only lower values will be accepted.

## Settings

## Content Example:

![Numeric Content Definition](images/numeric/7_3/numeric-content.png)


## MVC View Example:

    @{
        if(Model.Content.HasValue("amount")){
            <p>@(Model.Content.GetPropertyValue<string>("amount"))</p>
        }
    }
