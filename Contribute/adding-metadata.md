# Annotating a document with meta data

The documentation markdown files are allowed to contain meta data.  This is done by adding [YAML](https://en.wikipedia.org/wiki/YAML) at the top of the document.

To add meta data, the metadata is between lines with each 3 dashes.  Every line contains a keyword followed by a '`:`' and then the value.

    ---
    keywords: content razor v8 version8
    versionTo: 8.0.0
    versionFrom: 7.3.4
    ---

Currently there are 3 different properties of meta data supported.  

1. **keywords**:  with space separated property adding the possibility to supply other keywords which improve findability
2. **versionFrom**: an optional property with semver notation to indicate from which version this page is valid (or the feature the page describes has been introduced).
3. **versionTo**: an optional property with semver notation to indicate till which version this page page valid

Related information:

* [Adding multi version files](file-naming-conventions.md)
