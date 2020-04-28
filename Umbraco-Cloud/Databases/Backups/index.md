---
versionFrom: 7.0.0
---

# Database backups
Sometimes you might need to have a backup of your Cloud database. This can be accomplished in at least two ways. This article will go through two of those options.

- [Backup with SQL Server Management Studio](#backup-with-sql-server-management-studio).
- [Backup with PowerShell Script](#backup-with-powershell-script)
- [Backup and data retention policy](https://our.umbraco.com/documentation/Umbraco-Cloud/Frequently-Asked-Questions/#backups-and-data-retention)

## Backup with SQL Server Management Studio
Follow these steps:
- Log in to Umbraco Cloud, and visit your project page.
- From the "Settings" drop down for the project, select "Connection Details".
- If your IP address is not listed, click "Add now" next to "Your IP address is not on the list". It should then say "Your IP address is on the list".
- Note the server name, login, password, and database listed on this screen for whichever environment you are backing up (e.g., development or live).
- Open SQL Server Management Studio (SSMS).
- Once the "Connect to Server" dialog appears, enter your server name, login, and password (you will also need to be sure the authentication drop down is set to "SQL Server Authentication" rather than "Windows Authentication").
- Click the "Options >>" button.
- In the "Connect to database" field, type the name of your database (this was listed in the Umbraco Cloud connection details page).
- It is very important that you enter the database name. If you do not, the connection will fail.
- Expand "Databases", right click your database (it should be the only one listed), select "Tasks", then select "Export Data-tier Application...".
- Proceed through the dialog, setting the options appropriate to your situation, to save the "bacpac" file. This is your database backup.

## Backup with PowerShell Script
Make sure to change the following:
- Location of the Dac assembly (if needed)
- Your connection string
- Database name
- Backup directory (if needed)

```
# Location of Microsoft.SqlServer.Dac.dll
$DacAssembly = "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Extensions\Application\Microsoft.SqlServer.Dac.dll"

# Connection details can be found under "Settings" > "Connection details" on Umbraco.io
# If your password contains $ you'll have to escape them with a backtick (`)
$connectionString = "server=example.com;database=julemand;user id=root@example;password=pa`$`$word"

# The name of the database
$databaseName = "julemand"

# Bacpac files will be written to this directory - make sure it already exists
$backupDirectory = "C:\dbbackup\"

# Load DAC assembly
Write-Host "Loading Dac Assembly: $DacAssembly"
Add-Type -Path $DacAssembly
Write-Host "Dac Assembly loaded."

# Initialize Dac
$now = $(Get-Date).ToString("HH:mm:ss")
$services = new-object Microsoft.SqlServer.Dac.DacServices $connectionString
if ($services -eq $null)
{
    exit
}

$dateTime = $(Get-Date).ToString("yyyy-MM-dd-HH.mm.ss")

Write-Host "Starting backup of $databaseName at $now"
$watch = New-Object System.Diagnostics.StopWatch
$watch.Start()
$services.ExportBacpac("$backupDirectory$databaseName-$dateTime.bacpac", $databaseName)
$watch.Stop()
Write-Host "Backup completed in" $watch.Elapsed.ToString()
```
