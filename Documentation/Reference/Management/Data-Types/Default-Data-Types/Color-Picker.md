#Color Picker

`GUID f8d60f68-ec59-4974-b43b-c46eb5677985`

Adds a list of approved colours which can be selected by clicking. The approved colours need to be added as hex values (without the #) in the prevalues field. i.e. cccccc

##Data Type Definition Example

![Approved Color Data Type Definition](images/Color-Picker-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/Color-Picker-Content.jpg?raw=true)

##XSLT Example

	<div>
		<xsl:attribute name="style">background-color:#<xsl:value-of select="$currentPage/colorPicker"/></xsl:attribute>
		<p>some content</p>
	</div>

##Razor Example

	<div style="background-color:#@Model.colorPicker">
	  <p>some content</p>
	</div>