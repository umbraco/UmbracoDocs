#LocalizationService

**Applies to Umbraco 6.x and newer**

The LocalizationService acts as a "gateway" to Umbraco data for operations which are related to Dictionary items and Languages.

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

**Please note that this page will be updated with samples and additional information about the methods listed below**

##Getting the service
The LocalizationService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the LocalizationService is available through a local `Services` property.

	Services.LocalizationService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.LocalizationService

##Methods

###Delete(IDictionaryItem dictionaryItem, [int userid = 0])
Deletes a `IDictionaryItem` object and its related translations as well as its children.

###Delete(ILanguage language, [int userid = 0])
Deletes a `ILanguage` by removing it and its usages from the db 

###DictionaryItemExists(string key)
Checks if a `IDictionaryItem` with given key exists

###GetAllLanguages()
Gets all available languages as an `IEnumerable<Core.Models.ILanguage>`

###GetDictionaryItemById(int id)
Gets a `IDictionaryItem` by its id

###GetDictionaryItemById(Guid id)
Gets a `IDictionaryItem` by its id

###GetDictionaryItemByKey(string key)
Gets a `IDictionaryItem` by its key

###GetDictionaryItemChildren(Guid parentId)
Gets a list of children as `IEnumerable<IDictionaryItem>` for parent `IDictionaryItem`

###GetLanguageByCultureCode(string cultureName)
Gets a `ILanguage` by its culture code  (Culture Name - also referred to as 'Friendly name')

###GetLanguageById(int id)
Gets a `ILanguage` by its id 

###GetLanguageByIsoCode(string isoCode)
Gets a `Language` by its ISO code (ISO code of the language, i.e. `en-US`)

###GetRootDictionaryItems()
Gets the root/top `IDictionaryItem` objects as `IEnumerable<Core.Models.IDictionaryItem>`

###Save(IDictionaryItem dictionaryItem, [int userid = 0])
Saves a `IDictionaryItem` object

###Save(ILanguage language, [int userid = 0])
Saves a `ILanguage` object
