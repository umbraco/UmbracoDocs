# Section Sidebar

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

<figure><img src="../../../.gitbook/assets/section-sidebar.svg" alt=""><figcaption><p>Section Sidebar</p></figcaption></figure>

## Section Sidebar Apps <a href="#section-sidebar-apps" id="section-sidebar-apps"></a>

<figure><img src="../../../.gitbook/assets/section-sidebar-apps.svg" alt=""><figcaption><p>Section Sidebar Apps</p></figcaption></figure>

**Manifest**

```typescript
{
 "type": "sectionSidebarApp",
 "alias": "My.SectionSidebarApp",
 "name": "My Section Sidebar App",
 "meta": {
  "sections": ["My.Section"]
 }
}
```

**Default Element**

```typescript
interface UmbSectionSidebarAppElement {}
```

## **Menu Sidebar App**

**Sidebar Menu**:

* The Backoffice comes with a menu sidebar app that can be used to create a menu in the sidebar.
* To register a new menu sidebar app, add the following to your manifest
* The menu sidebar app will reference a menu that you have registered in the menu with a menu manifest

<figure><img src="../../../.gitbook/assets/section-menu-sidebar-app.svg" alt=""><figcaption><p>Menu Sidebar App</p></figcaption></figure>

**Manifest**

```typescript
{
 "type": "sectionSidebarApp",
 "kind": "menu",
 "alias": "My.SectionSidebarApp.MyMenu",
 "name": "My Menu Section Sidebar App",
 "meta": {
  "label": "My Sidebar Menu",
  "menu": "My.Menu"
 },
 "conditions": [
  {
   "alias": "Umb.Condition.SectionAlias",
   "match": "My.Section"
  }
 ]
}
```

**Default Element**

```typescript
interface UmbMenuSectionSidebarAppElement {}
```

**Adding Items to an existing menu**

This will make it possible to compose a sidebar menu from multiple Apps:

<figure><img src="../../../.gitbook/assets/section-sidebar-composed-apps.svg" alt=""><figcaption><p>Composed sidebar menu</p></figcaption></figure>

You can read more about this in the [Menu](../../../extending/section-trees/menu/) article.
