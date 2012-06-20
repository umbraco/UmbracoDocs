#Simple media browser

Sample using the businesslogic.media namespace to display folder and file contents (with links to open folder / display image). It's using some helpful methods from uComponents.uQuery.

This sample uses uQuery.  Newer umbraco versions could do this functionality with uQuery.  Check out this example: [media folder content list](media-folder-content-list.md).

    @using umbraco.cms.businesslogic.media;
    @using uComponents.Core;
    @using uComponents.Core.uQueryExtensions;
    @using System
    @{
      // Set default media root node id
      int rootNodeId = -1;
    
      // Try to get media id from macro parameter "mediaFolderNodeId" type     "mediacurrent"
      Int32.TryParse(Parameter.mediaFolderNodeId, out rootNodeId);
    
      // Try to get media id from querystring
      if (Request["OpenMediaFolderId"]!=null)
      {
        Int32.TryParse(Request["OpenMediaFolderId"], out rootNodeId);
      }
    
      // Get media node and iterate the children
      var m = new Media(rootNodeId);
    
      <table>
      @foreach (var c in m.GetChildMedia())
      {
        var type = c.ContentType.Alias;
        <tr>
        <td>@type</td>
        @switch (type)
        {
        case "Folder":
          <td><a href="?OpenMediaFolderId=@c.Id">@c.Text</a></td>
          break;
        default:
          var filePath = m.GetPropertyAsString("umbracoFile");
          <td><a href="@filePath">@c.Text</a></td>
          break;
        }
        </tr>
      }
      </table>
    }
