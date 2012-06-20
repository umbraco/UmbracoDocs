#Media Folder Content List

works in 4.7.1

    @using umbraco.MacroEngines;
    @using umbraco.cms.businesslogic.media;
    
    @helper BuildTable(dynamic mediaList)
    {
        <table border="0" style="width: 866px; height: 431px;">
        <tbody>
        @foreach (var group in mediaList.InGroupsOf(4))
        {
            <tr>
            @foreach(var item in group)
            {
                <td align="center"><img src="@item.umbracoFile" alt="" /></    td>
            }
            </tr>
        }
        </tbody>
        </table>
    }
    
    @{
        if (String.IsNullOrEmpty(@Parameter.MediaFolder))
        {
            <div>A Folder has not been selected for the Macro</div>
        }
        var folderId = @Parameter.MediaFolder;
        var media = Model.MediaById(folderId);
        var items = media.Children;
        if(items.GetType() == typeof(DynamicNull))
        {
            <div>Cannot Find the Folder (@folderId)</div>
        }
        else if(items.Count() <= 0)
        {
            <div>Folder is Empty</div>
        }
        else
        {
            @BuildTable(items);
        }
    }

