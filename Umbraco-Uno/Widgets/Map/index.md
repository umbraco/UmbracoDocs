---
versionFrom: 8.0.0
---

# Map (Google)

The Map widget is a feature that lets you use Google Maps to show the location of your choice. This could be if you need to show where your company is located.

The map widget is a handy widget for this as it will display a map, and if you choose to, then the information can be displayed next to the map. The map will have a pointer set to the **Latitude** and **Longitude** of your choice.

The way it works is that you type in the **Latitude** and **Longitude** and select how zoomed in you want the map to be on a scale from 0 - 20 it is recommended to set it to 7.

## Sample

![Frontend example of the Map widget with default details added to info fields](images/Map-Front.png)

When **Show Content Next To Map** is disabled the white section on the left will not appear and the map will take up all the space.

## Configuration Options

There are quite a few options to make your map work and look the best possible, you will, for example, be able to choose how zoomed in it needs to be.

![the map backoffice](images/Map-final.png)

## Content

- Custom Map Pin Icon
- Pre Heading
- Heading
- Text
- Address
- Phone Number
- Email
- Opening Hours
- [Buttons](../Buttons/index.md)

## API key settings

Your maps widget might say something like "Oops! Something went wrong." or "for development purposes only".

This means that you're missing a Google Maps API key. Every Uno project comes with an API key by default, however, if you would like to use your own then check out this link for more information - https://developers.google.com/maps/documentation/javascript/error-messages

Once you have the API key, you can add it by opening the settings content page and then navigating to "General".

There's a section called "Tracking & Access" at the very bottom of that page. That's where you can add your API key.

### Settings

- Height
- Show Content Next To Map
- Background Color
- Text Color
