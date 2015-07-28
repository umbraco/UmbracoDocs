#Slider

`Returns: Integer or String`

The Slider property editor makes use of the jQuery UI Slider plugin, which makes selected elements into sliders. The slider can be moved with the mouse or the arrow keys.

##Data Type Definition Example

![Slider Data Type Definition](images/Slider-DataType.jpg?raw=true)

##Settings

###Database type
Determines the type stored in the database, the options are "Integer" or "Nvarchar". This settings is automatically toggled by the checking/unchecking of the "Enable Range" setting.

###Enable range
If enabled, the slider will detect if you have two handles and create a stylable range element between these two.

###Range
If the "Enable range" setting is enabled, this drop-down list allows you to select from other possible values: 'min' and 'max'. A min range goes from the slider min to one handle. A max range goes from one handle to the slider max.

###Initial Value
Sets the default the value of the slider, if there's only one handle. If there is more than one handle, determines the value of the first handle.

###Initial Value 2
This option can be used to specify the default value of the second handle. (With range enabled there can only be 2 handles.)

###Minimum Value
The minimum value of the slider.

###Maximum Value
The maximum value of the slider.

###Enable Step Increments
If enabled, the slider will use step increments.

###Step Increments
Sets the size or amount of each interval or step the slider takes between min and max. The full specified value range of the slider (max - min) needs to be evenly divisible by the step.

###Orientation
This drop-down list determines the orientation of the slider, the possible values are 'horizontal' or 'vertical'. Horizontal sets the slider to have the min at the left and the max at the right, whilst vertical sets the slider to have the min at the bottom, the max at the top.

##Content Example 

![Slider Content Example](images/Slider-Content.jpg?raw=true)

##MVC View Example

###Typed:

    @{
	    if (Model.Content.HasValue("slider"))
	    {
	        String[] sliderValues = Model.Content.GetPropertyValue<string>("slider").Split(',');                
	        if (sliderValues.Count() == 2)
	        {
	            <p>The price is between $@sliderValues[0] and $@sliderValues[1]</p>   
	        }else if (sliderValues.Count() ==1){
	            <p>The price is $@sliderValues[0]</p> 
	        }                                
	    }      
    }

###Dynamic: 

    @{
        if (CurrentPage.HasValue("slider"))
        {            
            String[] sliderValues = CurrentPage.slider.Split(',');
            if (sliderValues.Count() == 2)
            {
                <p>The price is between $@sliderValues[0] and $@sliderValues[1]</p>   
            }else if (sliderValues.Count() ==1){
                <p>The price is $@sliderValues[0]</p> 
            }                                
        }      
    }

##Razor Macro (DynamicNode) Example

	@{
		if (Model.HasValue("slider"))
		{
			String[] sliderValues = Model.slider.Split(',');                
			if (sliderValues.Count() == 2)
			{
				<p>The price is between $@sliderValues[0] and $@sliderValues[1]</p>   
			}else if (sliderValues.Count() ==1){
				<p>The price is $@sliderValues[0]</p> 
			}                                
		}
	}

##XSLT Macro Example

	<xsl:if test="$currentPage/slider != ''">
		<p>
			<!-- If so, then we can prefix the value(s) with a label -->
			<xsl:text>The price is </xsl:text>
			<xsl:choose>
				<!-- Check if value contains a comma - making the assumption there are 2 values -->
				<xsl:when test="contains($currentPage/slider, ',')">
					<!-- Use the umbraco.library to split the comma-separated values -->
					<xsl:variable name="sliderValues" select="umbraco.library:Split($currentPage/slider, ',')" />
					<xsl:text>between $</xsl:text>
					<xsl:value-of select="$sliderValues/value[1]"/>
					<xsl:text> and $</xsl:text>
					<xsl:value-of select="$sliderValues/value[2]"/>
				</xsl:when>
				<!-- Otherwise we assume that the value is a single number -->
				<xsl:otherwise>
					<xsl:text>$</xsl:text>
					<xsl:value-of select="$currentPage/slider" />
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:if>



