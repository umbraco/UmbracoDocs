#Document
The `Document` class represents a single item in the content tree, its values are
fetched directly from the database, not from the cache. **Notice** the Document class should strictly be used for simple CRUD operations, not complex queries, as it is not flexible nor fast enough for this.


##Properties
A complete walkthrough of all properties are on its way

			d.Children;
            d.ContentType;
            d.ContentTypeIcon;
            d.CreateDateTime;
            d.Creator;
            d.ExpireDate;
            d.HasChildren;
            d.Id;
            d.IsTrashed;
            d.Level;
            d.OptimizedMode;
            d.Parent;
            d.ParentId;
            d.Published;
            d.Relations:
            d.ReleaseDate;
            d.sortOrder;
            d.Template;
            d.Text;
            d.UniqueId;
            d.UpdateDate;
            d.User;
            d.UserId;
            d.Version;
            d.VersionDate;
			d.Writer;


##Methods
A complete walkthrough and samples of all methods are on its way