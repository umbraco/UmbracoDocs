#DynamicNode (and Model) Members and Properties
##Public Member Functions
<table border="0">
<tbody>
<tr>
<td>&nbsp;</td>
<td>DynamicNode (INode n)</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>DynamicNode (int NodeId)</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>DynamicNode (string NodeId)</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>DynamicNode (object NodeId)</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>DynamicNode ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Up ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Up (int number)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Down ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Down (int number)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Next ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Next (int number)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Previous ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Previous (int number)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>XPath (string xPath)</td>
</tr>
<tr>
<td>bool </td>
<td>HasProperty (string name)</td>
</tr>
<tr>
<td>override bool </td>
<td>TryGetMember (GetMemberBinder binder, out object result)</td>
</tr>
<tr>
<td>DynamicMedia </td>
<td>Media (string propertyAlias)</td>
</tr>
<tr>
<td>bool </td>
<td>IsProtected ()</td>
</tr>
<tr>
<td>bool </td>
<td>HasAccess ()</td>
</tr>
<tr>
<td>string </td>
<td>Media (string propertyAlias, string mediaPropertyAlias)</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>AncestorOrSelf ()</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>AncestorOrSelf (int level)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>AncestorOrSelf (string nodeTypeAlias)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>AncestorOrSelf (Func&lt; DynamicNode, bool &gt; func)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>AncestorsOrSelf (Func&lt; DynamicNode, bool &gt; func)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>AncestorsOrSelf ()</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>AncestorsOrSelf (string nodeTypeAlias)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>AncestorsOrSelf (int level)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Descendants (string nodeTypeAlias)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Descendants (int level)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Descendants ()</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Descendants (Func&lt; INode, bool &gt; func)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>DescendantsOrSelf (int level)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>DescendantsOrSelf (string nodeTypeAlias)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>DescendantsOrSelf ()</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>DescendantsOrSelf (Func&lt; INode, bool &gt; func)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Ancestors (int level)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Ancestors (string nodeTypeAlias)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Ancestors ()</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>Ancestors (Func&lt; DynamicNode, bool &gt; func)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>NodeById (int Id)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>NodeById (string Id)</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>NodeById (object Id)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>NodeById (List&lt; object &gt; Ids)</td>
</tr>
<tr>
<td>DynamicNodeList </td>
<td>NodeById (params object[] Ids)</td>
</tr>
<tr>
<td>DynamicMedia </td>
<td>MediaById (int Id)</td>
</tr>
<tr>
<td>DynamicMedia </td>
<td>MediaById (string Id)</td>
</tr>
<tr>
<td>DynamicMedia </td>
<td>MediaById (object Id)</td>
</tr>
<tr>
<td>DynamicMediaList </td>
<td>MediaById (List&lt; object &gt; Ids)</td>
</tr>
<tr>
<td>DynamicMediaList </td>
<td>MediaById (params object[] Ids)</td>
</tr>
<tr>
<td>IProperty </td>
<td>GetProperty (string alias)</td>
</tr>
<tr>
<td>System.Data.DataTable </td>
<td>ChildrenAsTable ()</td>
</tr>
<tr>
<td>System.Data.DataTable </td>
<td>ChildrenAsTable (string nodeTypeAliasFilter)</td>
</tr>
</tbody>
</table>
##Properties
<table border="0">
<tbody>
<tr>
<td>DynamicNodeList </td>
<td>GetChildrenAsList [get]</td>
</tr>
<tr>
<td>DynamicNode </td>
<td>Parent [get]</td>
</tr>
<tr>
<td>int </td>
<td>Id [get]</td>
</tr>
<tr>
<td>int </td>
<td>template [get]</td>
</tr>
<tr>
<td>int </td>
<td>SortOrder [get]</td>
</tr>
<tr>
<td>string </td>
<td>Name [get]</td>
</tr>
<tr>
<td>bool </td>
<td>Visible [get, set]</td>
</tr>
<tr>
<td>string </td>
<td>Url [get]</td>
</tr>
<tr>
<td>string </td>
<td>UrlName [get]</td>
</tr>
<tr>
<td>string </td>
<td>NodeTypeAlias [get]</td>
</tr>
<tr>
<td>string </td>
<td>WriterName [get]</td>
</tr>
<tr>
<td>string </td>
<td>CreatorName [get]</td>
</tr>
<tr>
<td>int </td>
<td>WriterID [get]</td>
</tr>
<tr>
<td>int </td>
<td>CreatorID [get]</td>
</tr>
<tr>
<td>string </td>
<td>Path [get]</td>
</tr>
<tr>
<td>DateTime </td>
<td>CreateDate [get]</td>
</tr>
<tr>
<td>DateTime </td>
<td>UpdateDate [get]</td>
</tr>
<tr>
<td>Guid </td>
<td>Version [get]</td>
</tr>
<tr>
<td>string </td>
<td>NiceUrl [get]</td>
</tr>
<tr>
<td>int </td>
<td>Level [get]</td>
</tr>
<tr>
<td>List&lt; IProperty &gt; </td>
<td>PropertiesAsList [get]</td>
</tr>
<tr>
<td>List&lt; INode &gt; </td>
<td>ChildrenAsList [get]</td>
</tr>
</tbody>
</table>