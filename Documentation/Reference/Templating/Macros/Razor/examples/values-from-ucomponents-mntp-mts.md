#Get values from uComponents: Multi-Node Tree Picker & Multiple Textstring
Here's a snippet to get values from Multi-Node Tree Picker & Multiple Textstring and more.

XML:

    <refKursus>
       <MultiNodePicker>
          <nodeId>1077</nodeId>
          <nodeId>1078</nodeId>
          <nodeId>1079</nodeId>
       </MultiNodePicker>
    </refKursus>

Razor:

    <ul>
    @foreach (var x in Model.refKursus) {
      <li>@x.InnerText</li>
    }
    </ul>


To prevent error if nothing is selected

    @if (@item.HasProperty("myProperty") && @item.GetProperty("myProperty").Value != String.Empty)
    {
      foreach (var x in item.myProperty){
          var n = @Model.NodeById(@x.InnerText);
      }
    }

 

To test if a specific node has been picked

    @if (@Model.refKursus.XPath("//nodeId[. = '1078']").Count() > 0) {...}

 

uQuery:

    using uComponents.Core;
    using uComponents.Core.uQueryExtensions;

    string xml = uQuery.GetCurrentNode().GetProperty<string>("myProperty");
    List<Node> selectedNodes = uQuery.GetNodesByXml(xml);
