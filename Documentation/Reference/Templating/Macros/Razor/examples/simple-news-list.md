#Simple news list

Simple xslt to razor convert

<div class="newsList">
@foreach (var item in Model.Children.Where("umbracoNaviHide != true").OrderBy("UpdateDate"))
{
    <h3 class="headline">
        <a href="@item.Url">@item.Name</a>
    </h3>
    <small class="meta">
        Posted: @umbraco.library.LongDate(@item.UpdateDate.ToString(), true, " - ")
    </small>
    <br />
    <p class="introduction">
        @umbraco.library.ReplaceLineBreaks(@item.introduction)
    </p>
}
</div>