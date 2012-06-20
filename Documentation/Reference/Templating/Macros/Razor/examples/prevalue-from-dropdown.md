#Helper to get PreValue string from a dropdown
    @helper GetPrevalue(string PrevalueId) {
       if (!String.IsNullOrEmpty(PrevalueId)) {
        @umbraco.library.GetPreValueAsString(Convert.ToInt32(PrevalueId));
      }
    }

Usage:

    @GetPrevalue(Model.dropdownField)

Also works if the field is empty, otherwise we get away with just calling @GetPreValueAsString(Convert.ToInt32(Model.dropdownField)) - but that would error out on the Convert.ToInt32() if nothing had been chosen from the dropdown.