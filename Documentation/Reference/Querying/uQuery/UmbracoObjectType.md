# UmbracoObjectType

This is an Enum to represent each of the Guids used by Umbraco.

	public enum UmbracoObjectType
	{
		Unknown,
		[Guid("EA7D8624-4CFE-4578-A871-24AA946BF34D")] ROOT,
		[Guid("C66BA18E-EAF3-4CFF-8A22-41B16D66A972")] Document,
		[Guid("B796F64C-1F99-4FFB-B886-4BF4BC011A9C")] Media,
		[Guid("39EB0F98-B348-42A1-8662-E7EB18487560")] Member,
		[Guid("7A333C54-6F43-40A4-86A2-18688DC7E532")] ContentItemType,
		[Guid("10E2B09F-C28B-476D-B77A-AA686435E44A")] ContentItem,
		[Guid("A2CB7800-F571-4787-9638-BC48539A0EFB")] DocumentType,
		[Guid("4EA4382B-2F5A-4C2B-9587-AE9B3CF3602E")] MediaType,
		[Guid("9B5416FB-E72F-45A9-A07B-5A9A2709CE43")] MemberType,
		[Guid("366E63B9-880F-4E13-A61C-98069B029728")] MemberGroup,
		[Guid("6FBDE604-4178-42CE-A10B-8A2600A2F07D")] Template,
		[Guid("01BB7FF2-24DC-4C0C-95A2-C24EF72BBAC8")] RecycleBin,
		[Guid("9F68DA4F-A3A8-44C2-8226-DCBD125E4840")] Stylesheet,
		[Guid("30A2A501-1978-4DDB-A57B-F7EFED43BA3C")] DataType
	}

## GetUmbracoObjectType(Guid)
Returns: `uQuery.UmbracoObjectType`

`uQuery.UmbracoObjectType umbracoObjectType = uQuery.GetUmbracoObjectType("C66BA18E-EAF3-4CFF-8A22-41B16D66A972");`

## GetUmbracoObjectType(int)
Returns: `uQuery.UmbracoObjectType`

Gets the UmbracoObjectType for the supplied id

`uQuery.UmbracoObjectType umbracoObjectType = uQuery.GetUmbracoObjectType(1100);`