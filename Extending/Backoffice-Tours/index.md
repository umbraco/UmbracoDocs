# Backoffice tours

Backoffice tours are managed in a JSON format and stored in files on disk. The filenames should end with the .json extension.

## Tour file locations

The tour functionality will load information from multiple locations.

### Core tours and custom tours

The tour file that ships with Umbraco are stored in /Config/BackofficeTours. This is also the recommended place for storing your own tour files.

### Plugin tours

If you want to include a tour with your custom plugin you can store the tour file in /App_Plugins/<YourPlugin>/backoffice/tours. It is recommend that you place the tour files here when you are creating a plugin.


