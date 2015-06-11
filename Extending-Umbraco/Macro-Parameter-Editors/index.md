#Macro Parameter Editors

Every macro can contain parameters. There are a few default types.  A few default types are 

* bool
* contentAll
* contentPicker
* tabPicker
* text
* textMultiline

... and many others.  Consult the [Backoffice documentation](../../Using-Umbraco/Backoffice-Overview.md) for general information.

## Creating your own macro type ##

If you want to create a new macro parameter editor you will need some c# programming and database knowledge.

First create a class deriving from a webcontrol and implement the IMacroGuiRendering interface. Afterwards, open your database editor.  Find the **cmsMacroPropertyType** table and add the a new property editor.

### IMacroGuiRendering Interface ###
You can find this interface in the umbraco.interfaces namespace contained in the interfaces dll.  You will need to reference this DLL if you are developing your control in a separate project.
This interface implements 2 properties:  Value and ShowCaption.
The value stores a string  and the ShowCaption property a bool.

### Database update ###
<table>
<tr><th>
id</th><th>macroPropertyTypeAlias</th><th>macroPropertyTypeRenderAssembly</th><th>macroPropertyTypeRenderType</th><th>macroPropertyTypeBaseType</th></tr>
<tr><td>
28</td><td>myNewPickerType</td><td>NameOfAssembly</td><td>FullName.OfType.IncludingNamespace</td><td>String</td></tr></table>

### Example ###
A very basic example deriving from a DropDownList ASP.NET server control

    public class MyCustomPicker : DropDownList,  IMacroGuiRendering 
    {
		protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if(this.Items.Count == 0)
            {
                // set properties
                this.SelectionMode = ListSelectionMode.Multiple;           

                // load data
                ...
            }
        }

        public bool ShowCaption
        {
            get { return true; }
        }

        public string Value
        {
            get { return this.SelectedValue; }
            set { this.SelectedValue = value; }
        }
    }


## Further information ###
* A nice blogpost by Richard Soeteman: [Create A Custom Macro ParameterType](http://www.richardsoeteman.net/2010/01/04/CreateACustomMacroParameterType.aspx)
