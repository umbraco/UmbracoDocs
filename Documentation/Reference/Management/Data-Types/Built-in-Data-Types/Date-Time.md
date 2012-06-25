#Date/Time

`GUID b6fb1622-afa5-4bbf-a3cc-d9672a442222`

Displays a calendar UI for selecting dates and time, the value saved is a standard dateTime value.

##Data Type Definition Example

![Approved Color Data Type Definition](images/Date-Time-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/Date-Time-Content.jpg?raw=true)

##XSLT Example

	<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/datePickerWithTime, 'dd MMM yyyy hh:mm tt')"/>

##Razor Example

	@Model.datePickerWithTime.ToString("dd MMM yyyy hh:mm tt")