---
description: Get started with Routing in the backoffice.
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# Routing
The routing in the backoffice is flexible and customizable. In this article, you can find a couple of starting points for routing.

The overall **divider** is the [Section](extension-types/sections-and-trees/README.md) which is a `ManifestSection` extension type. It is also used internally by the following sections: Content, Media, Settings, Members, and so on. 

Depending on which section you are working on, there are different options:

* **SectionView** The section view is one of the automatically router extension types. It can be an entry point to a section. The "section view" is a view in a section, you'll find examples of these in the Packages-section and the Member-section. If a section has multiple views defined (or both dashboards and views) tabs and icons will be rendered.
* **Dashboard** Also a entry point to a section. If there are more than one section view or dashboard defined tabs and icons will be rendered to make it possible to navigate.
* **Workspace** The workspace-concept has built in features to facilitate editing of entity of a certain entity type. Used by many entities in the backoffice like content, media, content types, data types, dictionaries and so on and so on.
* **Custom element** A section can also be configured to use any web component as the "entry point" (really the `element()` configured in the manifest). By doing this we'll basically disable the possibility of using dashboards and section views for the section since they will not be automatically router/rendered. This option should be quite rare and only needed in very special situations.

### Building routing
Almost any component can host routable sub-components by defining a list of routes and render a `umb-router-slot` element. Let's assume we have a custom section with pathname `custom-section` and a `sectionView` with pathname `organization`. In this context we can create a element with routes, like this:

```typescript
@state()
_routes: UmbRoute[] = [
  {
    // Adding :personId as a parameter
    path: 'person/:personId',
    component: () => import('./person.element.js'),
    setup: (_component, info) => {

      console.log('personId:',info.match.params.personId);
    },
  },
  {
    path: 'people',
    component: () => import('./people.element.js'),
    setup: (_component, info) => {

      console.log('view-route-info',info);

    },
  },
  {
    path: '',
    redirectTo: 'people',
  },
];
```
**Note** that the order in which the routes are defined matters, the first match will be used so be sure to put more specific routes first. 

In the render method of the element, render the `umb-router-slot`:

```html
<umb-router-slot .routes=${this._routes}></umb-router-slot> 
```

One can create links to allow navigation to a given route:

```html
<a href="/umbraco/section/custom-section/organization/people">People</a>
<a href="/umbraco/section/custom-section/organization/person/1">Person 1</a>
<a href="/umbraco/section/custom-section/organization/person/2">Person 2</a>
```