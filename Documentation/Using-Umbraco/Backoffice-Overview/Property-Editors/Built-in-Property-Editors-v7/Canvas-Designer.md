#Canvas designer

##What is this?

The Canvas Designer is a new feature of Umbraco that allows real time styles editing.
This is a set of style editors that can be applied directly to the web pages of your site without any css coding. 

##How it works?

##Get starting

To active the canvas designer, first place @Umbraco.EnableCanvasDesigner() into the head tag of your main template just after your stylesheet links.

![Canvas Designer](images/Canvas-Designer/1.png)

You can now access the Canvas Designer through the preview mode of any page of your Website

![Grid layouts](images/Canvas-Designer/2.png)

A new Canvas Designer option appears just below the device buttons into the right side panel control

![Grid layouts](images/Canvas-Designer/3.png)

First, you access the Canvas Designer palette panel control. It consists on a set of pre-configured styles that can be apply directly to the website.

![Grid layouts](images/Canvas-Designer/4.png)

The third option allow us to edit into detail the style of the website

![Grid layouts](images/Canvas-Designer/5.png)

The first panel show the list of element witch can be edited. 
We can select them through the list or selecting the highlight element at the right sight into the frontend panel.

![Grid layouts](images/Canvas-Designer/6.png)

Once an element selected, we can edit its styles through the different styles editors

![Grid layouts](images/Canvas-Designer/7.png)

You can save your costumed styles at any time just clicking on save style, this action compile and minify all these styles into a css file ready to use.
The statement @Umbraco.EnableCanvasDesigner() mentioned before take care to add a link to this file into the live mode.

![Grid layouts](images/Canvas-Designer/8.png)

![Grid layouts](images/Canvas-Designer/9.png)




























To save the new styles, just click under the button save. This action compile these style 



By default the Canvas Designer comes with predefined settings that allow the edition of the most commun html element:






