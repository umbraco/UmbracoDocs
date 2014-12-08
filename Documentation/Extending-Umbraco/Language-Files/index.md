#Language Files

Language files are used to translate the Umbraco back office user interface so that end users can use Umbraco in their native language. This is particularly important for content editors who do not speak English.

##Supported Languages
Current languages that are included in the core are:

- English (UK)
- English (US)
- Danish
- German
- Spanish
- French
- Hebrew (Israel)
- Italian
- Japanese
- Korean
- Dutch
- Norwegian
- Polish
- Portuguese
- Russian
- Swedish
- Chinese (Simple)

##Where to find the language files

The language files are found at the following location within the Umbraco source:

	Umbraco-CMS/src/Umbraco.Web.UI/Umbraco/Config/Lang/

##Help keep the language files up to date

As Umbraco is a continually evolving product it is inevitable that new text is added on a fairly regular basis to the English language version of these files and this may mean that some of the above languages are no longer up to date.

If a translation is missing the key "alias" used will be shown within the user interface, as an example:

	[assignDomain]

The language files are fairly simple XML files with a straight-forward layout as seen below.

	<?xml version="1.0" encoding="utf-8" standalone="yes"?>
	<language alias="en" intName="English (UK)" localName="English (UK)" lcid="" culture="en-GB">
		<creator>
			<name>The Umbraco community</name>
			<link>http://our.umbraco.org</link>
		</creator>
		<area alias="actions">
			<key alias="assignDomain">Culture and Hostnames</key>
			<key alias="auditTrail">Audit Trail</key>
			...
		</area>
		...
	</language>
	
In the above example of a missing translation for "assignDomain", locate this string in the en.xml file and then copy the whole "Key" element into the relevant language file and translate the text, as an example here is the Spanish version of the above snippet:

	<?xml version="1.0" encoding="utf-8" standalone="yes"?>
	<language alias="es" intName="Spanish" localName="español" lcid="10" culture="es-ES">
		<creator>
	    	<name>The Umbraco community</name>
	    	<link>http://our.umbraco.org</link>
		</creator>
		<area alias="actions">
		    <key alias="assignDomain">Administrar hostnames</key>
		    <key alias="auditTrail">Auditoría</key>
			...
		</area>
		...
	</language>

If you do update any of the core language files or you add a new language, don't forget to help the rest of the community by submitting a Pull request so that your changes are merged into the core.