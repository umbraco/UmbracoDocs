#Breadcrumb using Razor in Umbraco 4.7

    <ul>
      @foreach(var level in @Model.Ancestors().Where("Visible"))
      {
        <li><a href="@level.Url">@level.Name</a></li>
      }
      <li>@Model.Name</li>
    </ul>

Add necessary CSS styles.