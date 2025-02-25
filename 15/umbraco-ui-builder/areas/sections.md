---
description: Configuring and customizing sections in Umbraco UI Builder to organize and manage the backoffice interface effectively.
---

# Sections

A section in Umbraco represents a distinct area within the backoffice, such as content, media, and so on. Sections are accessible via links in the main menu at the top of the Umbraco interface. Using Umbraco UI Builder, multiple sections can be defined to organize the management of models logically.

![Sections](../images/sections.png)

## Defining a Section

Sections are defined using the `AddSection` method on the root-level `UIBuilderConfigBuilder` instance.

### Using the `AddSection()` Method

This method adds a new section to the Umbraco menu with the specified name, allowing custom areas for organizing content in the backoffice.

#### Method Syntax

```cs
AddSection(string name, Lambda sectionConfig = null) : SectionConfigBuilder
```

#### Example

```csharp
config.AddSection("Repositories", sectionConfig => {
    ...
});
```

### Using the `AddSectionBefore()` Method

This method adds a section before another section with the specified alias, allowing for customized ordering of sections in the backoffice.

```csharp
config.AddSectionBefore("settings", "Repositories", sectionConfig => {
    ...
});
```

**Code Reference:** `AddSectionBefore(string beforeAlias, string name, Lambda sectionConfig = null) : SectionConfigBuilder`

### Using the `AddSectionAfter()` Method

This method adds a section after another section with the specified alias, allowing for a custom order of sections in the backoffice.

```csharp
config.AddSectionAfter("media", "Repositories", sectionConfig => {
    ...
});
```

**Code Reference:** `AddSectionAfter(string afterAlias, string name, Lambda sectionConfig = null) : SectionConfigBuilder`

## Customizing the Section Alias

### Setting a Custom Alias with `SetAlias()` Method

This method sets a custom alias for the section.

*Optional:* By default, an alias is automatically generated from the section's name. To customize the alias, the `SetAlias()` method can be used.

```csharp
sectionConfig.SetAlias("repositories");
```

**Code Reference:** `SetAlias(string alias) : SectionConfigBuilder`

## Configuring the Section Tree

### Using the `Tree()` Method for Configuration

This method configures the tree structure for the section, which is used to organize content types. For more information, see the [Trees](trees.md) article.

````csharp
sectionConfig.Tree(treeConfig => {
    ...
});
````

**Code Reference:** `Tree(Lambda treeConfig = null) : TreeConfigBuilder`

## Adding Dashboards to the Section

### Adding a Dashboard with the `AddDashboard()` Method

This method adds a dashboard to the section with the specified alias, providing tools and features for content management. For more information, see the [Dashboards](dashboards.md) article.

```csharp
sectionConfig.AddDashboard("Team", dashboardConfig => {
    ...
});
```

**Code Reference:** AddDashboard(string name, Lambda dashboardConfig = null) : DashboardConfigBuilder

### Using `AddDashboardBefore()` to Place a Dashboard

This method adds a dashboard before another dashboard with the specified alias, allowing custom placement in the section. For more information, see the [Dashboards](dashboards.md) article.

```csharp
sectionConfig.AddDashboardBefore("contentIntro", "Team", dashboardConfig => {
    ...
});
```

**Code Reference:** `AddDashboardBefore(string beforeAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder`

### Using `AddDashboardAfter()` to Place a Dashboard

This method adds a dashboard after another dashboard with the specified alias, giving control over dashboard order. For more information, see the [Dashboards](dashboards.md) article.

```csharp
sectionConfig.AddDashboardAfter("contentIntro", "Team", dashboardConfig => {
    ...
});
```

**Code Reference:** `AddDashboardAfter(string afterAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder`

## Extending Existing Sections

You can extend existing sections by adding Umbraco UI Builder trees and dashboards, context apps, and virtual subtrees. This can be done by calling the `WithSection` method on the root-level `UIBuilderConfigBuilder` instance.

### Extending an Existing Section with `WithSection()`

This method extends an existing section with additional configuration, enabling more customization for existing areas.

```csharp
config.WithSection("member", withSectionConfig => {
    ...
});
```

**Code Reference:** `WithSection(string alias, Lambda sectionConfig = null) : WithSectionConfigBuilder`

## Adding Trees to an Existing Section

### Using the `AddTree()` Method

This method adds a tree to the section, helping to visualize and organize content types. For more information, see the [Trees](trees.md) article.

````csharp
withSectionConfig.AddTree("My Tree", "icon-folder", treeConfig => {
    ...
});
````

**Code Reference:** `AddTree(string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder`

### Grouping Trees with `AddTree()` Method

This method adds a tree within a specified group, improving content organization by grouping related trees together. For more information, see the [Trees](trees.md) article.

````csharp
withSectionConfig.AddTree("My Group", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

**Code Reference:** `AddTree(string groupName, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder`

## Adding a Tree Before or After an Existing Tree

### Using `AddTreeBefore()` to Position a Tree

This method adds a tree before another tree within the section, allowing you to customize the tree order. For more information, see the [Trees](trees.md) article.

````csharp
withSectionConfig.AddTreeBefore("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

**Code Reference:** `AddTreeBefore(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder`

### Using `AddTreeAfter()` to Position a Tree

This method adds a tree after another tree within the section, enabling specific ordering of trees. For more information, see the [Trees](trees.md) article.

````csharp
withSectionConfig.AddTreeAfter("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

**Code Reference:** `AddTreeAfter(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder`

## Adding a Dashboard to an Existing Section

### Using the `AddDashboard()` Method

This method adds a new dashboard to the section with the specified name. For more information, see the [Dashboards](dashboards.md) article.

```csharp
withSectionConfig.AddDashboard("Team", dashboardConfig => {
    ...
});
```

**Code Reference:** `AddDashboard (string name, Lambda dashboardConfig = null) : DashboardConfigBuilder`

### Using the `AddDashboardBefore()` Method

This method adds a dashboard before the dashboard with the specified alias. For more information, see the [Dashboards](dashboards.md) article.

```csharp
withSectionConfig.AddDashboardBefore("contentIntro", "Team", dashboardConfig => {
    ...
});
```

**Code Reference:** `AddDashboardBefore (string beforeAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder`

### Using the `AddDashboardAfter()` Method

This method adds a dashboard after the dashboard with the specified alias. For more information, see the [Dashboards](dashboards.md) article.

```csharp
withSectionConfig.AddDashboardAfter("contentIntro", "Team", dashboardConfig => {
    ...
});
```

**Code Reference:** `AddDashboardAfter (string afterAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder`
