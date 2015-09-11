#Working with Record data

Umbraco Forms includes some helper methods that return dynamic objects, making it easy to output records using razor.

##Available methods
The static methods can be found in Umbraco.Forms.Mvc.DynamicObjects.Library

###GetApprovedRecordsFromPage

	DynamicRecordList GetApprovedRecordsFromPage(int pageId)
Returns all records with the state set to approved from all forms on the Umbraco page with the id = pageId as a DynamicRecordList

###GetApprovedRecordsFromFormOnPage

	DynamicRecordList GetApprovedRecordsFromFormOnPage(int pageId, string formId)
Returns all records with the state set to approved from the form with the id = formId on the Umbraco page with the id = pageId as a DynamicRecordList

###GetApprovedRecordsFromForm
	DynamicRecordList GetApprovedRecordsFromForm(string formId)
Returns all records with the state set to approved from the form with the ID = formId as a DynamicRecordList
###GetRecordsFromPage

	DynamicRecordList GetRecordsFromPage(int pageId)
Returns all records from all forms on the Umbraco page with the id = pageId as a DynamicRecordList

###GetRecordsFromFormOnPage

	DynamicRecordList GetRecordsFromFormOnPage(int pageId, string formId)
Returns all records from the form with the id = formId on the Umbraco page with the id = pageId as a DynamicRecordList

###GetRecordsFromForm

	DynamicRecordList GetRecordsFromForm(string formId)
Returns all records from the form with the ID = formId as a DynamicRecordList

##DynamicRecordsList and DynamicRecord
As you see all of these methods will return an object of type DynamicRecordList so you can easily iterate trough the DynamicRecord objects.

The properties available on a DynamicRecord are:

	DateTime Created
	string Form
	string Id
	string IP
	object MemberKey
	Dictionary<Guid, RecordField> RecordFields
	FormState? State
	int UmbracoPageId
	DateTime Updated

In order to access custom form fields you can simply use the dot notation, using the field caption but removing all spaces and non alphanumeric characters.

##Sample razor script (DynamicNode, pre Umbraco 6.0.0)

Sample script that is outputting comments using a form created with the default comment form template.
	
	@using Umbraco.Forms.Mvc.DynamicObjects

	<ul id="comments">
	 @foreach (dynamic record in Library
	           .GetApprovedRecordsFromPage(@Model.Id).OrderBy("Created"))
	 {
	     <li>
	          @record.Created.ToString("dd MMMM yyy")
	          @if(string.IsNullOrEmpty(record.Website)){
	             <strong>@record.Name</strong>
	          }
	          else{
	             <strong>
	               <a href="@record.Website" target="_blank">@record.Name</a>
	             </strong>
	          }
	         <span>said</span>
	        <p>@record.Comment</p>
	     </li>
	  }
	</ul>




