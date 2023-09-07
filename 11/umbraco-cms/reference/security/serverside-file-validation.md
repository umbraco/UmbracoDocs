---
meta.Title: "Server-side File Validation"
description: "This section describes how you can implement File Validation to improve"
---

# Validating file content before saving to disk
Sometimes it might be necessary to validate the contents of a file before it gets saved to disk when uploading trough the backoffice.

To help with this, Umbraco supplies a `FileStreamSecurityValidator` that runs all registered `IFileStreamSecurityAnalyzer` implementations on the file streams it receives from it's different file upload endpoints.
When any of the analyzers deem the file to be unsafe, the endpoint disregards the file and shows a relevant validation message where appropriate. This all happens in memory before the stream is written to a temporary file location.

### Implementing a FileStreamSecurityValidator
The `IFileStreamSecurityAnalyzer` needs a single method to be implemented:
- `IsConsideredSafe`: This method should return false if the analyzer finds a reason not to trust the file

### Example FileStreamSecurityValidator
The following class shows how one could potentially guard against Cross-site scripting(XSS) vulnerabilities in an svg file.

```csharp
public class SvgXssSecurityAnalyzer : IFileStreamSecurityAnalyzer
{

    private bool HasMatchingStartAndEndTags(Stream fileStream)
    {
        var startBuffer = new byte[256];
        var endBuffer = new byte[256];
        fileStream.Read(startBuffer);
        if (endBuffer.Length > fileStream.Length)
            fileStream.Seek(0, SeekOrigin.Begin);
        else
            fileStream.Seek(fileStream.Length - endBuffer.Length, SeekOrigin.Begin);
        fileStream.Read(endBuffer);
        var startString = System.Text.Encoding.UTF8.GetString(startBuffer);
        var endString = System.Text.Encoding.UTF8.GetString(endBuffer);
        return startString.Contains("<svg")
               && startString.Contains("xmlns=\"http://www.w3.org/2000/svg\"")
               && endString.Contains("/svg>");
    }

    /// <summary>
    /// Analyzes whether the svg contains any XSS vulnerability
    /// </summary>
    public bool IsConsideredSafe(Stream fileStream)
    {
        // reduce memory footprint by partially reading the file
        if(HasMatchingStartAndEndTags(fileStream) == false){
            return false;
        }

        fileStream.Seek(0, SeekOrigin.Begin);
        var streamReader = new StreamReader(fileStream); // do not use a using as this will dispose of the underlying stream
        var fileContent = streamReader.ReadToEnd();
        return !(fileContent.Contains("<script") && fileContent.Contains("/script>"));
    }
}
```

You can [register it during startup or with a composer](https://docs.umbraco.com/umbraco-cms/reference/using-ioc#registering-dependencies).
Then you can upload a file with the following content to the backoffice and see that it is not persisted.
```
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<svg version="1.1" baseProfile="full" xmlns="http://www.w3.org/2000/svg">
   <polygon id="triangle" points="0,0 0,50 50,0" fill="#009900" stroke="#004400"/>
   <script type="text/javascript">
      alert('xss');
   </script>
</svg>
```