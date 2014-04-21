# Introduction 

The idea of this section is to take you step by step through an Umbraco website build starting from scratch. It will allow you to take any website “template” (e.g. flat HTML, CSS and JS) and install it into a fresh Umbraco and wire up the sections that need content managing in Umbraco.  Umbraco is a seriously powerful CMS but many find the learning curve of installing a website from scratch a little too much – this guide aims to explain the mysteries!

We avoid using one of the starter kits as when it comes to building your own site these don’t give you an understanding of the basics of Umbraco Document Types and Templates and how these work together to build pages. 

# **What You’ll Need**

To take you through a demo of installing a basic site in Umbraco you need the following:

*    A clean, empty installation of Umbraco – e.g. no starter site installed, see the notes below what to do when running through the installation wizard. Use the latest main 7.X download. Follow the installation steps in the documentation http://our.umbraco.org/documentation/Installation  
*    A copy of Initializr – a HTML5, responsive template which is a nice start for any website. https://github.com/verekia/initializr-template/archive/master.zip if you prefer you can use your own flat HTML files but my examples will use this.

# **Getting Started**

## Installing an Empty Umbraco

This guide doesn’t cover the installation of Umbraco – follow the instructions in http://our.umbraco.org/documentation/Installation. When you see the first splash screen click **_customize_** – either fill in your MS SQL blank DB credentials or use the CE option – then on the final screen use the “**_No thanks I do not want to use a starter website_**”. 

 
![Umbraco Installation Splash Screen](images/figure-1-installation-splash-screen.png?raw=true)

*Figure 1 - Installation Splash Screen - note the Customize link*



![Install a starter website](images/figure-2-no-starter-website.png?raw=true)
*Figure 2 - Install a starter website - No Thanks!*



## Checking you have an Empty Umbraco Install

When you hit your local host address (http://localhost or whatever you’ve set up) you should see the Umbraco empty page screen. 

 
![This is correct – we have a blank, empty Umbraco website](images/figure-3-empty-umbraco-install.png?raw=true)
*Figure 3 - This is correct – we have a blank, empty Umbraco website!*

If you can see the Umbraco Starter kit site you’ve missed the option to install Umbraco with no starter site.  

 
![You should NOT see this!](images/figure-4-should-not-see-this.png?raw=true)
*Figure 4- You should NOT see this!*


You need to reinstall Umbraco if you can see the starter kit – if you did a manual install you can delete all files in the directory where your local host is being served from, copy the Umbraco zip contents back in and then hit localhost.  


## Preparing the Initializr Template Site 

Now unzip the Initializr contents to a folder onto your desktop (or a place of your choosing).  Now open the **_index.html_** from this directory in your preferred browser to see the template – you can see it’s full of lovely filler text with dummy links. We’re going to turn this into a fully fledged, working site! 

 
![The Initializr Template](images/figure-5-initializr-template.png?raw=true)
*Figure 5 - The Initializr Template*


Log into your Umbraco installation (e.g. go to http://localhost/umbraco in your browser).  You should be faced with an empty Umbraco installation – but where to start!?

 
![A barren, empty Umbraco installation](images/figure-6-umbraco-empty.png?raw=true)
*Figure 6 - A barren, empty Umbraco installation*


