#uQuery - Dynamic header
Here's a simple script I use to have dynamic h1-header on my pages. It uses hideHeader property for optional hide, and takes headerProperty if it exists and != null, otherwise node name:

    @using uComponents.Core
    @using uComponents.Core.uQueryExtensions
    @{  
      var currentNode = uQuery.GetCurrentNode();  
      var hideHeader = currentNode.GetPropertyAsBoolean("hideHeader");  
      
      if (!hideHeader)
      {
        var header = currentNode.GetPropertyAsString("header");
        if (header=="")
        {
           header = currentNode.Name;
        }  
        <h1>@header</h1>
      }
    }
    