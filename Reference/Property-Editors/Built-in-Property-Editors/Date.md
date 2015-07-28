#Date

`Returns: DateTime`

Displays a calendar UI for selecting dates, the value saved is a standard dateTime value.

##Data Type Definition Example

![Approved Color Data Type Definition](images/Date-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/Date-Content.jpg?raw=true)

##XSLT Example

	<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/datePickerWithTime, 'dd MMM yyyy')"/>

##Razor (DynamicNode) Example

	@Model.datePickerWithTime.ToString("dd MMM yyyy")