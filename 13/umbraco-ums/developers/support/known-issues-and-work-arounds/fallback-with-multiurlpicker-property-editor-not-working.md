**Behaviour:**

Properties that use the MultiUrlPicker property editor on a Segmented page variant when left empty doesn't fallback on the non-segmented variant.

**Details:**

In Umbraco v8, v10 and v12, an empty MultiUrlPicker property editor being is treated as a valid value.This is due to Umbraco parsing an empty value for this editor as a 'null' value, but due to a known bug 'null' is being returned as being a valid value for this property editor. Because of this, Umbraco decides that it doesn't use a fallback value instead.

The intended behavior however would ofcourse be that null is an invalid value, and therefor decides to use a fallback value instead!

This bug has been reported and verified by Umbraco: [https://github.com/umbraco/Umbraco-CMS/issues/14716](https://github.com/umbraco/Umbraco-CMS/issues/14716)

**Solution:**

There currently is a pullrequest open which should resolve this issue. For the time being, a possible workaround would be to create a custom version of the MultiUrlPickerValueConverter.cs that overrides the 'IsValue()' method by adding an additional null-check returning false if said value is null.

You can then remove the default MultiUrlPickerValueConverter and replace it with your custom variant adding the null check!

**Last updated:**

August 25th, 2023