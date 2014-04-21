#Creating More Pages

## Using a Maintainable Template Structure

We’ve seen how to create a **_Document Type_**. We have a simple three page site, Home, News and Contact Us. We could easily just create three **_Document Types_** and leave **_Create matching template_** checkbox checked to also create three matching templates. Then we’d copy the same HTML code, job-lot into each template.  This would work – on a very simple site it actually has some merits however once a site starts to grow this would lead to problems – for instance changing anything in the menu needs to be done on each template - it also means we’d need the user to set the footer on each page etc. 

Umbraco provides us with an elegant solution to keeping a consistent base template – those familiar with MVC will recognise it. 

To start we’re going to unpick a little bit of what we did in creating the homepage to sit the homepage template under a master. 
