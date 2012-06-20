#uQuery - Dynamic title
A snippet to create a dynamic title "page name - site name". It uses header if it exists, otherwise the page name and also its guessing site name from the ancestor node on level 2.

    @using uComponents.Core
    @using uComponents.Core.uQueryExtensions
    @using System.Linq
    @{
    
      // get the site root node = ancestor on level 2
      
      var siteRootNode = uQuery.GetCurrentNode().GetAncestorOrSelfNodes    ().FirstOrDefault(node => node.GetDepth()==2);
      var siteName = siteRootNode.Name;
      
      var currentNode = uQuery.GetCurrentNode();  
      var header = currentNode.GetPropertyAsString("header");    
      
      if (header=="")
      {
         header = currentNode.Name;
      }  
      
      var title = "";
      if (header != siteName)
      {
       title = header + " - " + siteName;
       }
      else
      {
       title = siteName;
       }
    }
    @title
