---
versionFrom: 8.17.0
versionTo: 10.0.0
---

# Using Tabs

In this section, you will get an overview of how to add and reorder tabs, convert a group to a tab and manage the “Generic” tab.

## Adding a tab

Using tabs, you can organize properties in the back-office to provide a tailored and efficient workflow for editors creating and maintaining Content, Media and Members.

Tabs allow you to add horizontal organization in your Document Types, Media Types and Member Types and is quite handy for types that need a more defined hierarchy or have many properties and groups.

To add a tab, follow these steps:

1. Go to **Settings**.
2. Create or select a **Document Type/Media Type/Member Type** and click **Add tab**.

    ![Add tab](images/Add-tab.png)

:::note
When adding the first tab, all existing groups are automatically added to the tab.
:::

## Reordering tabs

To reorder tabs, follow these steps:

1. Go to **Settings**.
2. Select a **Document Type/Media Type/Member Type**.
3. Select **Reorder**.
4. You can drag the tab where you want, manually add a numeric value next to the tab name or use the arrows to set a value.

    This is important when using compositions, as you might want to always display a tab/group at a certain position by setting a manual numeric value.

    ![Reorder tabs](images/Reorder-tabs.gif)

5. Select **I am done reordering**.
6. Click **Save**.

## Convert a group to a tab

To convert a group to a tab, follow these steps:

1. Go to **Settings**.
2. Select a **Document Type/Media Type/Member Type**.
3. Select **Reorder**.
4. You can drag the group to the **Convert to tab** option.
5. Select **I am done reordering**.
6. Click **Save**.

:::note
It is not possible to convert a tab back into a group, because tabs can contain groups and nested groups are not supported. You need to create a new group, move all the properties from the tab into the new group and finally delete the empty tab.
:::

## Managing the “Generic” tab

Once you start adding tabs, you might see a “Generic” tab appear. This is done to hold groups and properties that are not assigned to a tab. For example, a group of properties coming from a composition that has no tab. In order to display the groups and properties correctly and have a solid data structure, they will be displayed under the “Generic” tab.

![Generic tab](images/Generic-tab.png)

To manage the **Generic** tab on a **Document Type/Media Type**:

1. Go to the **Composition** Document Type/Media Type.
2. Click **Add tab** and enter the **Name** for the tab. All existing groups and properties are added to the tab.
3. Go to the **Document Type/Media Type**, the **Generic** tab will now be replaced by the tab from the composition.

    ![Composition Add Tab](images/Composition-add-tab.gif)

---
