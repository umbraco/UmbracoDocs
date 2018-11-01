# ResourceResolvers
A resource resolver is slightly different from data resolvers, as it only triggers when a resource/file is packaged and extracted. This means it can only modify the file itself, but not call back to the item, which the resource belongs to

#### MacroParameters
* **Full name:** `Umbraco.Courier.ResourceResolvers.MacroParameters`
* **Triggers on:**  Files with the extension .master and contains umbraco:macro elements.
* Modifies the template file itself to convert any Node Ids in any macro to a GUID, and vice versa.

#### TemplateResources
* **Full name:** `Umbraco.Courier.ResourceResolvers.TemplateResources`
* **Triggers on:**  Files with the extension .master
* Modifies the template file itself and replaces any locallink references with a GUID
