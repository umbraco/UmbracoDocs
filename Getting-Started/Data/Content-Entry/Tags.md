#Tags

`Returns: Comma Separated String`

##Data Type Definition Example

![Tags Definition](images/wip.png)

##Content Example 

![Tags Example](images/wip.png)

##MVC View Example

###Typed - Get nodes (IPublishedContent) which been been tagged with "Category1"

    <ul>
        @{
            var taggedContent = UmbracoContext.Application.Services.TagService.GetTaggedContentByTag("Category1").Select(x => x.EntityId);
            foreach (var contentItem in Umbraco.TypedContent(taggedContent).Where(x => x != null))
            {
                <li>@contentItem.Name</li>
            }
        }
    </ul>