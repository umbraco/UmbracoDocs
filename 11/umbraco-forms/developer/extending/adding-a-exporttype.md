# Adding An Export Type To Umbraco Forms

_This builds on the "_[_adding a type to the provider model_](adding-a-type.md)_" chapter._

Add a new class to your project and have it inherit from `Umbraco.Forms.Core.ExportType`. You have two options when implementing the class, as shown in the following examples.

## Basic Example

You can implement the method `public override string ExportRecords(RecordExportFilter filter)` in your export provider class. You need to return a string you wish to write to a file. For example, you can generate a `.csv` (comma-separated values) file. You would perform your logic to build up a comma-separated string in the `ExportRecords` method.

{% hint style="info" %}
In the constructor of your provider, you will need a further two properties, `FileExtension` and `Icon`.
{% endhint %}

`FileExtension` is the extension such as `zip`, `txt` or `csv` of the file you will be generating and serving from the file system.

In this example below we will create a single HTML file which takes all the submissions/entries to be displayed as a HTML report. We will do this in conjunction with a Razor partial view to help build up our HTML and thus merge it with the form submission data to generate a string of HTML.

### Provider Class

```csharp
using System;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Models;
using Umbraco.Forms.Core.Searchers;
using Umbraco.Forms.Web.Helpers;

namespace MyFormsExtensions
{
    public class ExportToHtml : ExportType
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IFormRecordSearcher _formRecordSearcher;

        public ExportToHtml(
            IHostEnvironment hostEnvironment,
            IHttpContextAccessor httpContextAccessor,
            IFormRecordSearcher formRecordSearcher)
            : base(hostEnvironment)
        {
            _httpContextAccessor = httpContextAccessor;
            _formRecordSearcher = formRecordSearcher;

            Name = "Export as HTML";
            Description = "Export entries as a single HTML report";
            Id = new Guid("4117D352-FB41-4A4C-96F5-F6EF35B384D2");
            FileExtension = "html";
            Icon = "icon-article";
        }

        public override string ExportRecords(RecordExportFilter filter)
        {
            var view = "~/Views/Partials/Forms/Export/html-report.cshtml";
            EntrySearchResultCollection model = _formRecordSearcher.QueryDataBase(filter);
            return ViewHelper.RenderPartialViewToString(_httpContextAccessor.GetRequiredHttpContext(), view, model);
        }
    }
}
```

### Razor Partial View

```csharp
@model Umbraco.Forms.Core.Searchers.EntrySearchResultCollection

@{
    var submissions = Model.Results.ToList();
    var schemaItems = Model.Schema.ToList();
}

<h1>Form Submissions</h1>

@foreach (var submission in submissions)
{
    var values = submission.Fields.ToList();

    for (int i = 0; i < schemaItems.Count; i++)
    {
      <strong>@schemaItems[i].Name</strong> @values[i].Value
      <br />
    }

    <hr />
}
```

### Registration

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Forms.Core.Providers.Extensions;
using Umbraco.Forms.TestSite.Business.ExportTypes;

namespace MyFormsExtensions
{
    public class TestComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.FormsExporters().Add<ExportToHtml>();
        }
    }
}
```

## Advanced Example

This approach gives us more flexibility in creating the file we wish to serve as the exported file. We do this for the export to Excel file export provider we ship in Umbraco Forms. With this we can use a library to create the Excel file and store it in a temporary location before we send back the filepath for the browser to stream down the export file.

In this example we will create a collection of text files, one for each submission which is then zipped up into a single file and served as the export file.

```csharp
using System;
using System.IO;
using System.IO.Compression;
using System.Linq;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Models;
using Umbraco.Forms.Core.Searchers;

namespace MyFormsExtensions
{
    public class ExportToTextFiles : ExportType
    {
        private readonly IFormRecordSearcher _formRecordSearcher;

        public ExportToTextFiles(
            IHostingEnvironment hostingEnvironment,
            IFormRecordSearcher formRecordSearcher)
            : base(hostingEnvironment)
        {
            _formRecordSearcher = formRecordSearcher;

            this.Name = "Export as text files";
            this.Description = "Export entries as text files inside a zip file";
            this.Id = new Guid("171CABC9-2207-4575-83D5-2A77E824D5DB");
            this.FileExtension = "zip";
            this.Icon = "icon-zip";
        }

        /// <summary>
        /// We do not implement this method from the interface
        /// As this method is called from ExportToFile that we also override here & is expecting the file contents as a string to be written as a stream to a file
        /// Which would be OK if we were creating a CSV or a single based file that can have a simple string written as a string such as one large HTML report or XML file perhaps
        /// </summary>
        public override string ExportRecords(RecordExportFilter filter) => throw new NotImplementedException();

        /// <summary>
        /// This gives us greater control of the export process
        /// </summary>
        /// <param name="filter">
        /// This filter contains the date range & other search parameters to limit the entries we are exporting
        /// </param>
        /// <param name="filepath">
        /// The filepath that the export file is expecting to be served from
        /// So ensure that the zip of text files is saved at this location
        /// </param>
        /// <returns>The final file path to serve up as the export - this is unlikely to change through the export logic</returns>
        public override string ExportToFile(RecordExportFilter filter, string filepath)
        {
            // Before Save - Check Path, Directory & Previous File export does not exist
            string pathToSaveZipFile = filepath;

            // Check our path does not contain \\
            // If not, use the filePath
            if (filepath.Contains('\\') == false)
            {
                pathToSaveZipFile = HostingEnvironment.MapPathContentRoot(filepath);
            }

            // Get the directory (strip out \\ if it exists)
            var dir = filepath.Substring(0, filepath.LastIndexOf('\\'));
            var tempFileDir = Path.Combine(dir, "text-files");


            // If the path does not end with our file extension, ensure it's added
            if (pathToSaveZipFile.EndsWith("." + FileExtension) == false)
            {
                pathToSaveZipFile += "." + FileExtension;
            }

            // Check that the directory where we will save the ZIP file temporarily exists
            // If not just create it
            if (Directory.Exists(tempFileDir) == false)
            {
                Directory.CreateDirectory(tempFileDir);
            }

            // Check if the zip file exists already - if so delete it, as we have a new update
            if (File.Exists(pathToSaveZipFile))
            {
                File.Delete(pathToSaveZipFile);
            }

            // Query the DB for submissions to export based on the filter
            EntrySearchResultCollection submissions = _formRecordSearcher.QueryDataBase(filter);

            // Get the schema objects to a list so we can get items using position index
            var schemaItems = submissions.schema.ToList();

            // We will use this to store our contents of our file to save as a text file
            var fileContents = string.Empty;

            // For each submission we have build up a string to save to a text file
            foreach (EntrySearchResult submission in submissions.Results)
            {
                // The submitted data for the form submission
                var submissionData = submission.Fields.ToList();

                // For loop to match the schema position to the submission data
                for (int i = 0; i < schemaItems.Count; i++)
                {
                    // Concat a string of the name of the field & its stored data
                    fileContents += schemaItems[i].Name + ": " + submissionData[i] + Environment.NewLine;
                }

                // Now save the contents to a text file
                // Base it on the format of the record submission unique id
                var textFileName = Path.Combine(tempFileDir, submission.UniqueId + ".txt");
                File.WriteAllText(textFileName, fileContents);

                // Reset fileContents to be empty again
                fileContents = string.Empty;
            }

            // Now we have a temp folder full of text files
            // Generate a zip file containing them & save that
            ZipFile.CreateFromDirectory(tempFileDir, pathToSaveZipFile);

            // Tidy up after ourselves & delete the temp folder of text files
            if (Directory.Exists(tempFileDir))
            {
                Directory.Delete(tempFileDir, true);
            }

            // Return the path where we saved the zip file containing the text files
            return pathToSaveZipFile;
        }
    }
}
```
