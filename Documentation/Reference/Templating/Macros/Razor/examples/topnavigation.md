#Top navigation (using DynamicNode)
Top navigation with the use of DynamicNode - below level 1 - hiding umbracoNavHide's.

    @{
      <ul class="topnavigation">
      @foreach (var c in Model.AncestorOrSelf(1).Children.Where("umbracoNaviHide!=true")) {
          <li><a href="@c.Url">@c.Name</a></li>
      }
      </ul>
    }
