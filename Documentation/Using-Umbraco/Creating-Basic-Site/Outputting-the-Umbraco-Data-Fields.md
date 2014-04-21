#Outputting the Umbraco Data Fields

What you’ll notice though is that our content we added to the homepage isn’t being output. We need to wire up the data properties to the template.  Let’s look at our template and identify where the data fields we created before should go.  


![IMAGETITLE](images/FILENAME.png?raw=true)


*Figure 14 - Where our Data Fields Content should be output*


We’ve marked in blue where we want our data field content to be output. Now we need to wire up the relevant fields. 


24.  Go to the **_Settings > Templates > Homepage_**. Scroll down and highlight the text “h1#title” around line 27. 


![IMAGETITLE](images/FILENAME.png?raw=true)


*Figure 15 - Preparing to replace the hardcoded text with an Umbraco Page Field*


25.  Click the button **_Insert Umbraco Page Field_** and under the **_Choose field _**drop down select **_pageTitle_** from the **_Custom Fields_** section. 


![IMAGETITLE](images/FILENAME.png?raw=true)


*Figure 16 - Umbraco Page Field*


26.  Click the green **_Insert_** button then the **_Save_** button.  

27.  Next do the same for the content between the “_<header></header>_” tags (around lines 42 -43) using field **_bodyText_**.  Again click the **_Insert_** and then **_Save _**buttons. 


![IMAGETITLE](images/FILENAME.png?raw=true)


*Figure 17 - Replacing the bodyText with the Umbraco Page Field*


28.  Finally we do the footer – between the <h3></h3> tags in the footer div (line 68). 

 
*Figure 18 - Footer Text*
29.  Now go and reload your homepage... viola! We have content!   Now, we could go back and add two tabs called Article1, Article 2, Article Footer each containing a title and content field and wire these to the relevant places in the template. However this would limit the content manager to always having to have these sections. This might be OK but we could also use child nodes – we’ll learn about those later. 

