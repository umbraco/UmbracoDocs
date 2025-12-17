# End-of-Service Policy for Umbraco Cloud Projects
To keep Umbraco Cloud secure and reliable, projects running versions of Umbraco CMS that reach End-of-Life (EOL) follow a clear and predictable lifecycle.

This policy explains what happens at each stage and how long projects remain hosted.

## 1. Continued Hosting After EOL
When a Long-Term Support (LTS) version of Umbraco CMS reaches its End-of-Life date:

* **Hosting continues on Umbraco Cloud** for the duration of the Extended Long-Term Support<sup>1</sup> (XLTS) period.
* **An XLTS contract is not required** to keep your site hosted.
* Only projects with an active XLTS contract receive **security and compliance patches** during this time.

Projects on Standard-Term Support (STS) versions follow the same principle: they remain hosted through the lifecycle of the LTS they are based on.

## 2. After the XLTS Period Ends
When the XLTS coverage period for an Umbraco version ends:

* All projects still running that version are **automatically moved from shared toy dedicated hosting** on Umbraco Cloud.
* This ensures that unsupported software does not affect the shared hosting environment. \

Projects can continue operating on dedicated resources for **12 months** from the end of the XLTS period.

## 3. End-of-Service
After the 12-month grace period on dedicated hosting:

* Hosting for that Umbraco version **is discontinued**.
* Projects that have not been upgraded or migrated to a supported version will **stop working**.
* Data and files will be accessible for an additional **30 days after End-of-Service**. 

To avoid downtime, customers are encouraged to upgrade or migrate to a supported version well before this date.

## 4. Example Timeline
<table>
  <tr>
   <td><strong>Stage</strong>
   </td>
   <td><strong>What Happens</strong>
   </td>
   <td><strong>Duration</strong>
   </td>
  </tr>
  <tr>
   <td>LTS
   </td>
   <td>Full support and updates
   </td>
   <td>Until EOL
   </td>
  </tr>
  <tr>
   <td>XLTS
   </td>
   <td>Hosting continues, patches require XLTS contract
   </td>
   <td>Up to 24 months
   </td>
  </tr>
  <tr>
   <td>Post-XLTS
   </td>
   <td>Projects moved to dedicated hosting
   </td>
   <td>12 months
   </td>
  </tr>
  <tr>
   <td>End-of-Service
   </td>
   <td>Hosting discontinued
   </td>
   <td>-
   </td>
  </tr>
</table>

**Example dates (Umbraco 13):**
* EOL: December 14, 2026
* XLTS ends: December 14, 2028
* Projects move to dedicated hosting: December 14, 2028
* Hosting ends: December 14, 2029

Subsequent Standard-term Support (STS) versions are subject to the same End-of-Service date as the preceding LTS version. This means that Umbraco 14, 15, and 16, will be End-of-Service on December 14, 2029.

## 5. Why This Policy Exists
This policy ensures that Umbraco Cloud remains a **secure, stable, and high-performing platform** for all users. Running unsupported software increases security risks and maintenance complexity. 

By defining a clear process and timeline, every customer and partner can plan upgrades with confidence.

## 6. Summary
* Hosting continues after EOL for the duration of the XLTS period.
* Security and compliance patches are available only with an XLTS contract.
* After XLTS ends, projects move to dedicated hosting for 12 months.
* Hosting ends after the grace period unless the project is upgraded.
* Clear notifications are sent before every stage of the lifecycle.

<sup>1</sup> Information and availability on Extended Long-term support for Umbraco can be found (here)[https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/xlts/].

## 7. End-of-Service Overview

### Active releases
<table>
  <tr>
   <td>Version
   </td>
   <td>Release date
   </td>
   <td>Release Type
   </td>
   <td>End-of-Life
   </td>
   <td>End of XLTS
   </td>
   <td>End-of-Service (Umbraco Cloud)
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 17</strong>
   </td>
   <td><strong>November 27, 2025</strong>
   </td>
   <td><strong>LTS</strong>
   </td>
   <td><strong>November 27, 2028</strong>
   </td>
   <td><strong>November 27, 2030</strong>
   </td>
   <td><strong>November 27, 2031</strong>
   </td>
  </tr>
  <tr>
   <td>Umbraco 16
   </td>
   <td>June 12, 2025
   </td>
   <td>STS
   </td>
   <td>June 12, 2026
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>December 14, 2029
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 13</strong>
   </td>
   <td><strong>December 14, 2023</strong>
   </td>
   <td><strong>LTS</strong>
   </td>
   <td><strong>December 14, 2026</strong>
   </td>
   <td><strong>December 14, 2028</strong>
   </td>
   <td><strong>December 14, 2029</strong>
   </td>
  </tr>
</table>


### Upcoming releases
<table>
  <tr>
   <td>Version
   </td>
   <td>Release date
   </td>
   <td>Release Type
   </td>
   <td>End-of-Life
   </td>
   <td>End of XLTS
   </td>
   <td>End-of-Service (Umbraco Cloud)
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 21</strong>
   </td>
   <td><strong>December 9, 2027</strong>
   </td>
   <td><strong>LTS</strong>
   </td>
   <td><strong>December 9, 2030</strong>
   </td>
   <td><strong>December 9, 2032</strong>
   </td>
   <td><strong>December 9, 2033</strong>
   </td>
  </tr>
  <tr>
   <td>Umbraco 20
   </td>
   <td>June 24, 2027
   </td>
   <td>STS
   </td>
   <td>June 24, 2028
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>November 27, 2031
   </td>
  </tr>
  <tr>
   <td>Umbraco 19
   </td>
   <td>December 10, 2026
   </td>
   <td>STS
   </td>
   <td>December 10, 2027
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>November 27, 2031
   </td>
  </tr>
  <tr>
   <td>Umbraco 18
   </td>
   <td>June 25, 2026
   </td>
   <td>STS
   </td>
   <td>June 25, 2027
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>November 27, 2031
   </td>
  </tr>
</table>


### End-of-life
<table>
  <tr>
   <td>Version
   </td>
   <td>Release date
   </td>
   <td>Release Type
   </td>
   <td>End-of-Life
   </td>
   <td>End of XLTS
   </td>
   <td>End-of-Service (Umbraco Cloud)
   </td>
  </tr>
  <tr>
   <td>Umbraco 15
   </td>
   <td>November 14, 2024
   </td>
   <td>STS
   </td>
   <td>November 14, 2025
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>December 14, 2029
   </td>
  </tr>
  <tr>
   <td>Umbraco 14
   </td>
   <td>May 30, 2024
   </td>
   <td>STS
   </td>
   <td>May 30, 2025
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>December 14, 2029
   </td>
  </tr>
  <tr>
   <td>Umbraco 12
   </td>
   <td>June 29, 2023
   </td>
   <td>STS
   </td>
   <td>June 29, 2024
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>June 16, 2028
   </td>
  </tr>
  <tr>
   <td>Umbraco 11
   </td>
   <td>December 1, 2022
   </td>
   <td>STS
   </td>
   <td>December 1, 2023
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>June 16, 2028
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 10</strong>
   </td>
   <td><strong>June 16, 2022</strong>
   </td>
   <td><strong>LTS</strong>
   </td>
   <td><strong>June 16, 2025</strong>
   </td>
   <td><strong>June 16, 2027</strong>
   </td>
   <td><strong>June 16, 2028</strong>
   </td>
  </tr>
  <tr>
   <td>Umbraco 9
   </td>
   <td>September 28, 2021
   </td>
   <td>STS
   </td>
   <td>December 16, 2022
   </td>
   <td><em>LTS  Only</em>
   </td>
   <td>February 24, 2028
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 8</strong>
   </td>
   <td><strong>February 26, 2019</strong>
   </td>
   <td><strong>N/A</strong>
   </td>
   <td><strong>February 24, 2025</strong>
   </td>
   <td><strong>February 24, 2027</strong>
   </td>
   <td><strong>February 24, 2028</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Umbraco 7</strong>
   </td>
   <td><strong>November 21, 2013</strong>
   </td>
   <td><strong>N/A</strong>
   </td>
   <td><strong>September 30, 2023</strong>
   </td>
   <td><strong>January 1, 2027</strong>
   </td>
   <td><strong>January 1, 2028</strong>
   </td>
  </tr>
</table>

