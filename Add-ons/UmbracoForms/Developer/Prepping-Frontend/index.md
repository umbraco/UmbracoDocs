# Preparing your frontend
In order for Umbraco Forms to work correctly, Umbraco Forms needs three (3) client dependencies.

- jQuery (JavaScript library)
- jQuery validate (jQuery plugin that provides client side form validation)
- jQuery validate unobtrusive. (Add-on to jQuery Validation that provides unobtrusive validation via data-* attributes)

## Adding the scripts to your template
Easiest way to add the dependencies is to fetch them from a [CDN](https://en.wikipedia.org/wiki/Content_delivery_network). There are various CDN services you can use, we've included references for [Microsoft CDN](https://docs.microsoft.com/en-us/aspnet/ajax/cdn/overview). Other CDN services you might want to look at include https://www.jsdelivr.com/ and https://cdnjs.com/about, which may offer better performance and more reliable service. 

Here's how to add the three (3) client dependencies below to your template within the head tags or at the bottom of the page.

**Example within `head` tags.**

```html
<head>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>
</head>
```

**Example before closing `body` tag**

When adding the script to the bottom of the page, you'll also need to perform an extra step — have a look at [this page](../Rendering-Scripts/index.md) for instructions.
	
```html
<body>
    <!-- Page content here -->
    
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.2.4.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.1/jquery.validate.unobtrusive.min.js"></script>
</body>
```
