#uQuery - Top navigation
    @using uComponents.Core
    @using uComponents.Core.uQueryExtensions
    @using System.Linq


    @{
      // look for ancestor at level 2
      var siteRootNode = uQuery.GetCurrentNode().GetAncestorOrSelfNodes().FirstOrDefault(node => node.GetDepth()==2);
      var children = siteRootNode.GetChildNodes().Where(node=>!node.GetPropertyAsBoolean("umbracoNaviHide"));
        <ul class="topnavigation">
        @foreach (var c in children)
        {
          string css="";
          if (c.Id == uQuery.GetCurrentNode().Id)
          {
            css="class =\"selected\"";
          }
          <li @css>      
            <a href="@c.Url">
                @c.Name
            </a>
          </li> 
        }
        </ul>
    }