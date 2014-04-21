#Document Types

## Data first – nothing in = nothing out!

Step 1 of any site is to create a “**_Document Type_**” – after a few installations you’ll speak this terminology but at the start it’s a little bit bewildering.  A **_Document Type_** is a data container in Umbraco where you can add data fields / attributes where the editor user can input data and Umbraco can use it to output it in the relevant part of a “**_template_**” (more on these later).  

**_Document Types_** are infinitely extendable but usually you’ll add data fields something like the following:
*    Page title
*    Sub Heading
*    Body Text
*    Meta Title
*    Meta Description
*    ...


Each **_Data Field_** has a type - e.g. a text string or a number or rich text body... we’ll come to this later.

## Creating your first Document Type


Right, let’s get busy. Go to the **_Settings_** menu in Umbraco. This is the third button on the left hand black menu with the spanner. Then you’ll see a long list of settings – don’t worry about these yet, we’ll introduce them as we need them. 


**_Document Types_** is strangely positioned as the last option in the list yet it’s always the starting point for any Umbraco build.  Hover over the **_Document Types_** **_node_** and you’ll see three dots **_..._** , click this to see the menu. Then click **_+ Create_** button. 


![Creating a Document Type](images/figure-7-creating-a-document-type.png?raw=true)


*Figure 7 - Creating a Document Type*


Ignore the **_Master Document Type_** drop down for now. Give our new **_Document Type_** the **_Name_** = “_HomePage”_ and ensure the **_Create matching template_** checkbox is checked.  Click **_Create_**. 


![Name your Document Type](images/figure-8-name-your-document-type.png?raw=true)


*Figure 8 – Name your Document Type*


Umbraco now adds a **_Document Type_** to the tree under the node. You’ll see four tabs **_Info_**,**_Structure_**, **_Generic properties_**, **_Tabs_**.  Click **_Info_** (should already be selected) and then the **_Choose..._** link next to the **_Icon_** label.   Enter “_home_” into the search and you'll have a house icon – this will help our editors in the **_Content_** tree later.


![Adding an Icon to Document Type](images/figure-9-adding-an-icon-to-document-type.png?raw=true)


*Figure 9 - Adding an Icon to Document Type*


Enter in the **_Description_** field “_This is our homepage template_”.  This text is used to help the user select the correct document type later. 


Next click the **_Structure_** tab and check **_Allow at root_**.  This will allow us to create a homepage at the root (simple huh?). 


Next we go to the **_Tabs_** tab. Create a new tab called “_Contents_” and then another called “_Footer_” (enter the name and click the **_New tab_** button remembering to click **_Save_** after).


![Document Types - Adding Tabs](images/figure-10-document-types-adding-tabs.png?raw=true)


*Figure 10 - Document Types - Adding Tabs*


Now go to the **_Generic properties_** – this tab is where we create the data containers that the homepage will need and use.  Click on the link **_Click here to add a new property_**. Enter the **_Name_** “_Page Title_”. When you move to the next field you’ll see Umbraco helpfully gives you the alias “pageTitle”.  The **_Type_** is defaulted to “_Textstring”_ and **_Tab_** = “_Contents_” (remember, we just created that!).  **_Description_** again helps the editor so we’ll fill this in “_The main title of the page (e.g. Welcome to Widgets Ltd)._ “ 


![Creating our PageTitle Data Type](images/figure-11-creating-our-pagetitle-data-type.png?raw=true)


*Figure 11 - Creating our pageTitle Data Type*


Ignore the rest of the fields for now and click the green **_Save_** button at the top right. 


Repeat this step, clicking the **_Click here to add a new property link_** at the top of the **_Generic Properties tab_** and create these (remembering to click **_Save_** each time):
```
**_Name_**: 	Body Text


**_Alias_**: 	bodyText


**_Type_**: 	Richtext editor _(click the arrow on the Type field!)_


**_Tab:_** 	Contents


**_Description_**: 	The main content of the page. 


**_Name_**:  	Footer Text


**_Alias_**: 	footerText


**_Type_**: 	Textstring 


**_Tab:_** 	Footer _(remember to change this!)


**_Description_**: 	Copyright notice for the footer.  
```

You should now have a **_Generic Properties tab_** that looks like this:


![Generic Properties Tab of your Homepage Document Type](images/figure-12-generic-properties-tab.png?raw=true)


*Figure 12 - Generic Properties Tab of your Homepage Document Type*


We’ve now created our first Document Type – Umbraco needs three things to create a webpage and this is the first and most important. It takes the data inside an instance of the Document Type and merges it with a template – we’ll edit our template next.

