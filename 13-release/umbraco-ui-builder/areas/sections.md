---
description: Configuring sections in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Sections

A section is a distinct area of the Umbraco backoffice, such as content, media, etc. The section is accessed via a link in the main menu at the top of the Umbraco interface. Umbraco UI Builder allows you to define multiple sections in order to organise the management of your models into logical sections.

![Sections](../images/sections.png)

## Defining a section

You can define a section by calling one of the `AddSection` methods on the root level `UIBuilderConfigBuilder` instance.

### **AddSection(string name, Lambda sectionConfig = null) : SectionConfigBuilder**

Adds a section to the Umbraco menu with the given name.

```csharp
// Example
config.AddSection("Repositories", sectionConfig => {
    ...
});
```

### **AddSectionBefore(string beforeAlias, string name, Lambda sectionConfig = null) : SectionConfigBuilder**

Adds a section to the Umbraco menu with the given name **before** the section with the given alias.

```csharp
// Example
config.AddSectionBefore("settings", "Repositories", sectionConfig => {
    ...
});
```

### **AddSectionAfter(string afterAlias, string name, Lambda sectionConfig = null) : SectionConfigBuilder**

Adds a section to the Umbraco menu with the given name **after** the section with the given alias.

```csharp
// Example
config.AddSectionAfter("media", "Repositories", sectionConfig => {
    ...
});
```

## Changing a section alias

### **SetAlias(string alias) : SectionConfigBuilder**

Sets the alias of the section.

**Optional:** When adding a new section, an alias is automatically generated from the supplied name for you. However, if you need a specific alias you can use the `SetAlias` method to override this.

```csharp
// Example
sectionConfig.SetAlias("repositories");
```

## Configuring the section tree

### **Tree(Lambda treeConfig = null) : TreeConfigBuilder**

Accesses the tree config of the current section. For more information check the [Trees documentation](trees.md).

````csharp
// Example
sectionConfig.Tree(treeConfig => {
    ...
});
````

## Adding a dashboard to the section

### **AddDashboard(string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
sectionConfig.AddDashboard("Team", dashboardConfig => {
    ...
});
```

#### **AddDashboardBefore(string beforeAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name **before** the dashboard with the given alias. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
sectionConfig.AddDashboardBefore("contentIntro", "Team", dashboardConfig => {
    ...
});
```

#### **AddDashboardAfter(string afterAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name **after** the dashboard with the given alias. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
sectionConfig.AddDashboardAfter("contentIntro", "Team", dashboardConfig => {
    ...
});
```

## Extending an existing section

You can extend existing sections by adding Umbraco UI Builder trees and dashboards, context apps, and virtual subtrees. This can be done by calling the `WithSection` method on the root level `UIBuilderConfigBuilder` instance.

### **WithSection(string alias, Lambda sectionConfig = null) : WithSectionConfigBuilder**

Starts a sub-configuration for the existing Umbraco section with the given alias.

```csharp
// Example
config.WithSection("member", withSectionConfig => {
    ...
});
```

## Adding a tree to an existing section

### **AddTree(string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder**

Adds a tree to the current section. For more information check the [Trees documentation](trees.md).

````csharp
// Example
withSectionConfig.AddTree("My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTree(string groupName, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder**

Adds a tree to the current section in a group with the given name. For more information check the [Trees documentation](trees.md).

````csharp
// Example
withSectionConfig.AddTree("My Group", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTreeBefore(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder**

Adds a tree to the current section **before** the tree with the given alias. For more information check the [Trees documentation](trees.md).

````csharp
// Example
withSectionConfig.AddTreeBefore("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTreeAfter(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder**

Adds a tree to the current section **after** the tree with the given alias. For more information check the [Trees documentation](trees.md).

````csharp
// Example
withSectionConfig.AddTreeAfter("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

## Adding a dashboard to an existing section

### **AddDashboard (string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
withSectionConfig.AddDashboard("Team", dashboardConfig => {
    ...
});
```

### **AddDashboardBefore (string beforeAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name **before** the dashboard with the given alias. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
withSectionConfig.AddDashboardBefore("contentIntro", "Team", dashboardConfig => {
    ...
});
```

### **AddDashboardAfter (string afterAlias, string name, Lambda dashboardConfig = null) : DashboardConfigBuilder**

Adds a dashboard with the given name **after** the dashboard with the given alias. For more information check the [Dashboards documentation](dashboards.md).

```csharp
// Example
withSectionConfig.AddDashboardAfter("contentIntro", "Team", dashboardConfig => {
    ...
});
```
