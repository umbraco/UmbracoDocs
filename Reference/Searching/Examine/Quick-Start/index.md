---
versionFrom: 8.0.0
---

# Quick start

_This guide will help you get setup quickly using Examine with minimal configuration options. Umbraco ships Examine with 3 indexes: internal, external, and members. The internal index should not be used for searching when returning results on a public website because it includes content that has not been published yet. Instead you can use the external index to get up and running._

## Performing a search

:::note
In the coming examples the Umbraco Starter Kit has been used, as it provides some example content that can be searched. Some of the examples below therefore may require 'the setting up of templates, etc' if you are following the guide on your own existing site.
:::

The starter kit comes with some Templates, Document Types and content nodes created already. We will use some of these to set up a basic search system. This is a 'Quick Start' guide, as much more complex searches are possible with Examine.

We will make it possible to 'search' on the _People_ page, by adding a search bar to the template page: `people.cshtml` - add the following form at the top of the template, but underneath the `<nav>` element:

```csharp
...
</nav>
-->
<div>
    <form action="@Model.Url()" method="get">
        <input type="text" placeholder="Search" id="query" name="query" />
        <button>Search</button>
    </form>
</div>
<div class="employee-grid">
...
```
This will create a basic input field at the top of the page and make it post to the same people page when submitted along with the search term.
### Retrieving the Search Term

Right below the form, add the following:
```csharp
<div>
    @{
        var searchTerm = string.Empty;
        searchTerm = string.IsNullOrEmpty(Request["query"])
            ? string.Empty
            : Request["query"];
        if (searchTerm == string.Empty)
        {
            <p>Enter search term</p>
        }
        else
        {
            //perform the search
        }
    }
</div>
```
Here we are getting the request query from the form. If the string is empty we ask them to submit a term, otherwise we will perform the search.

### Examine Search Index
To perform the search we will first need to get a reference to the particular Examine index that we want to search. Then we will use this index to access it's corresponding `Searcher`. We use the `Searcher` to construct the query logic to execute and search the index.

Umbraco ships with three indexes:
* ExternalIndex - available to use for indexing published unprotected content.
* InternalIndex - which Umbraco's backoffice search uses.
* InternalMemberIndex - which Umbraco's Membership implementation uses.

([You can create your own indexes too](../indexing)) if you need to analyse text in a different language for example.

You use a convenient service named the `ExamineManager` to retrieve first the Index by its 'alias' and then use the Index to get a reference to the Searcher eg:
```csharp
 if(ExamineManager.Instance.TryGetIndex("ExternalIndex", out var index))
    {
        var searcher = index.GetSearcher();
```
### Creating the Search Query
With this in mind we begin to update the `else` condition with the following:

```csharp
else
{
    //perform the search
    //first we try to get the index, it is the ExternalIndex as we don't want to return unpublished things
    //it returns the index in the var index
    if(ExamineManager.Instance.TryGetIndex("ExternalIndex", out var index))
    {
        var searcher = index.GetSearcher();
        var results = searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", searchTerm).Execute();
        if (results.Any())
        {
            <ul>
                @foreach (var result in results)
                {
                    if (result.Id != null)
                    {
                        var node = Umbraco.Content(result.Id);
                        <li>
                            <a href="@node.Url()">@node.Name</a>
                        </li>
                    }
                }
            </ul>
        }
        else
        {
            <p>No results found for query @searchTerm</p>
        }
    }
    return;
}
```
At this point we have chosen to use the External index and it's searcher. 

:::tip
We reference the External index by it's alias "ExternalIndex". Umbraco has a set of 'Constants' that refer to the indexes that can be more convenient to use `Constants.UmbracoIndexes`. So, in the example here we could have used `Constants.UmbracoIndexes.ExternalIndexName` instead of "ExternalIndex".
:::

The `searcher` has a CreateQuery method, where you can choose to search content, media or members eg:
```csharp
searcher.CreateQuery("content")
```

From here you can see how we can chain together the logic to perform the search. In the example we are searching all `content` using the `person` Document Type, where the `nodeName` is equal to the search term that was typed in the input bar.

```csharp
searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", searchTerm)
```
### Execute the Search

Finally calling `.Execute()` at the end of the query logic will trigger the search and return a set of matching search results that we can loop through.

The final template looks like this:
```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.People>
@using Umbraco.Examine
@using ContentModels = Umbraco.Web.PublishedModels;
@{
    Layout = "master.cshtml";
}
@helper SocialLink(string content, string service)
{
    if (!string.IsNullOrEmpty(content))
    {
        <a class="employee-grid__item__contact-item" href="http://@(service).com/@content">@service</a>
    }
}
@Html.Partial("~/Views/Partials/SectionHeader.cshtml")
<section class="section">
    <div class="container">
        <!-- todo: implement department filter -->
        <!--
        <nav class="nav-bar nav-bar--center nav-bar--air-bottom">
            <a class="nav-link nav-link--black nav-link--active" href="">All</a>
            <a class="nav-link nav-link--black" href="">Marketing</a>
            <a class="nav-link nav-link--black" href="">Package People</a>
            <a class="nav-link nav-link--black" href="">Designers</a>
            <a class="nav-link nav-link--black" href="">Other</a>
        </nav>
        -->
        <div>
            <form action="@Model.Url()" method="get">
                <input type="text" placeholder="Search" id="query" name="query" />
                <button>Search</button>
            </form>
        </div>

        <div>
            @{
                var searchTerm = string.Empty;
                searchTerm = string.IsNullOrEmpty(Request["query"])
                    ? string.Empty
                    : Request["query"];

                if (searchTerm == string.Empty)
                {
                    <p>Enter search term</p>
                }
                else
                {
                    if(ExamineManager.Instance.TryGetIndex("ExternalIndex", out var index))
                    {
                        var searcher = index.GetSearcher();
                        var results = searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", searchTerm).Execute();
                        if (results.Any())
                        {
                            <ul>
                                @foreach (var result in results)
                                {
                                    if (result.Id != null)
                                    {
                                        var node = Umbraco.Content(result.Id);
                                        <li>
                                            <a href="@node.Url">@node.Name</a>
                                        </li>
                                    }
                                }
                            </ul>
                        }
                        else
                        {
                            <p>No results found for query @searchTerm</p>
                        }
                    }
                    return;
                }
            }
        </div>
        <div class="employee-grid">
            @foreach (ContentModels.Person person in Model.Children)
            {
                <div class="employee-grid__item">
                    <div class="employee-grid__item__image" style="background-image: url('@person.Photo.Url')"></div>
                    <div class="employee-grid__item__details">
                        <h3 class="employee-grid__item__name">@person.Name</h3>
                        @if (!string.IsNullOrEmpty(person.Email))
                        {
                            <a href="mailto:@person.Email" class="employee-grid__item__email">@person.Email</a>
                        }
                        <div class="employee-grid__item__contact">
                            @SocialLink(person.FacebookUsername, "Facebook")
                            @SocialLink(person.TwitterUsername, "Twitter")
                            @SocialLink(person.LinkedInUsername, "LinkedIn")
                            @SocialLink(person.InstagramUsername, "Instagram")
                        </div>
                    </div>
                </div>
            }
        </div>
    </div>
</section>
```
## Different ways to query
Examine has a lot of different ways to query data. Building upon the example from before, here are a few other searches that can be done to get different data:
### Search through all nodes
Let's say you want to search through **all content nodes** by their **file names**. You could amend the query from before like this:
```csharp
var results = searcher.CreateQuery("content").Field("nodeName", searchTerm).Execute();
```
### Search using Lucene queries
To do the search like above, but only use Lucene to query, amend the query from before like this:
```csharp
var results = searcher.CreateQuery().NativeQuery("+__IndexType:content +nodeName:" + searchTerm).Execute();
```
### Search children of a specific node
To search through **all child nodes of a specific node** by their **bodyText property**, amend the query from before like this:
```csharp
var results = searcher.CreateQuery("content").ParentId(1105).And().Field("bodyText", searchTerm).Execute();
```

### Search descendants of a specific home node

To search through **all descendants of a specific node** by their **bodyText property**, refer to [this article](../examine-events#Adding-the-path-of-the-node-as-a-searchable-field-into-the-index).

:::tip
If you are familiar with the MVC pattern of working with forms, then have a look at `SurfaceController` documentation. There you can learn how to create a strongly typed form that posts back to a SurfaceController, which then handles the validation of the form post with a custom ViewModel in an MVC-like pattern in Umbraco.
:::
