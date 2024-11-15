---
description: Get started with Routing in the backoffice.
---

# Routes

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Routing

The routing in the backoffice is flexible and customizable. In this article, you can find a couple of starting points for routing.

The overall **divider** is the [Section](../extending-overview/extension-types/section.md) which is a `ManifestSection` extension type. It is also used internally by the following sections: Content, Media, Settings, Members, and so on.

Depending on which section you are working on, there are different options:

* **SectionView**: The [Section View](../extending-overview/extension-types/section-view.md) is a view in a section and one of the automatic router extension types. It can be an entry point to a section. If a section has multiple views defined (or both dashboards and views) then the tabs and icons will be rendered. As some examples, you can check the **Packages** and **Member** sections.
* **Dashboard**: The [Dashboard](../extending-overview/extension-types/dashboard.md) is an entry point to a section. If there is more than one section view or dashboard then the defined tabs and icons will be rendered to make it possible to navigate.
* **Workspace**: The [Workspace](../workspaces.md) concept has built-in features to facilitate editing of an entity of a certain entity type. It is used by many entities in the backoffice like content, media, content types, data types, dictionaries and so on.
* **Custom element**: A [Custom Element](umbraco-element/) is a section that can be configured to use any web component as the **entry point**. The `element()` can be configured in the manifest. By doing this we'll disable the possibility of using dashboards and section views for the section since they will not be automatically routed/rendered. This option should be used only when necessary.

### Building routing

Almost any component can host routable sub-components by defining a list of routes and render a `umb-router-slot` element. Let's assume we have a **custom section** with pathname `custom-section` and a **section view** with pathname `organization`. In this context we can create an element with routes, like this:

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

{% hint style="info" %}
The order in which the routes are defined is important as the first match will be used. So make sure to add more specific routes in the beginning.
{% endhint %}

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
