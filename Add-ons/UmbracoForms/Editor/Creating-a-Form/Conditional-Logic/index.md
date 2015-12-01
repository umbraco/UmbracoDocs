#Setting up conditional logic on fields

Only showing a field if the value of another field is ... That's what you can do with conditional logic.

##Example form
Take a look at the following as an example

![Example form](ExampleForm.png)

It make sense to only show the email/phone field when that corresponds with the option chosen in the 'how should we contact you?' field.

##Enabling conditional logic

Enabling conditions for a field can be done on the additional settings of a field.


![Enable conditions](EnableConditions.png)

Simply check the enable conditions box and you should then see more options

![Conditions](Conditions.png)

###Action type

First thing that needs to be chosen is the action type this can be either show or hide

![ActionType](ActionType.png)

- Show: the field will be hidden unless the rules match
- Hide: the field will be hidden if the rules match

###Logic type

Then you'll need to specify if all rules need to match. This setting is only important if you have multple rules.

![LogicType](LogicType.png)

- All: all of the rules must match
- Any: any of the rules may match

##Adding a new rule

When adding a new rule you'll need to select the field where you want to evaluate the value and then you can also select an operator.

In this example I only want to show the email field if the value of the 'how should we contact you' field is 'Email'

![Setup rule](SetupRule.png)

Don't forget to hit the add icon so the new rule get's added

![Setup rule add](SetupRuleAdd.png)

##Result

If I setup a similar rule for the phone field I get the following result

![Form render](ExampleFormRender.png)

By default the email and phone field are hidden but when I select the corresponding option from the 'how should we contact you' field it get's shown


![Form render](ExampleFormRender2.png)
