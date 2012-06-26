#Nested navigation with start and finish levels

    @*
    NESTED NAVIGATION WITH START AND FINISH LEVELS
    =======================================
    This snippet makes it easy to do navigation based lists! It'll automatically produce a nested list all children of a page within certain 
    levels in the hierarchy that's published and visible (it'll filter out any pages with a property named "umbracoNaviHide"
    that's set to 'true'.
    Based on the inbuilt Navigation script in Umbraco 4.7                                                      
                                                      
    How to Customize for re-use (only applies to Macros, not if you insert this snippet directly in a template):
    - If you add a Macro Parameter with the alias of "StartLevel" you can define the starting level for which nodes will be displayed
    - If you add a Macro Parameter with the alias of "FinishLevel" you can define the finish level for which nodes will be displayed                                                  
    *@
    @inherits umbraco.MacroEngines.DynamicNodeContext
    @{ 
      var startLevel = String.IsNullOrEmpty(Parameter.Level) ? 2 : int.Parse(Parameter.StartLevel);
      var finishLevel = String.IsNullOrEmpty(Parameter.Level) ? 5 : int.Parse(Parameter.FinishLevel);   
      var parent = @Model.AncestorOrSelf(startLevel);
      if (parent != null) { @traverse(parent,startLevel,finishLevel) ; }
    }                                                     
                                                   
    @helper traverse(dynamic parent,int startLevel,int finishLevel)
    {
     <ul>
        @foreach (var node in parent.Children.Where("Visible")) {
          var selected = Array.IndexOf(Model.Path.Split(','), node.Id.ToString()) >= 0 ? " class=\"selected\"" : "";
          <li@Html.Raw(selected)>
            <a href="@node.Url">@node.Name</a>                                       
            @if (selected!=""&&@node.Level<=finishLevel) { @traverse(node,startLevel,finishLevel); }  
          </li>
          }
        </ul>                                                            
    }