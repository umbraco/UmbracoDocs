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

When the XLTS coverage period for an Umbraco version ends, all projects on that version are **automatically moved from shared to dedicated hosting**.

This is done to ensure that unsupported software does not affect the shared hosting environment.

Projects can continue operating on dedicated resources for **12 months** from the end of the XLTS period.

## 3. End-of-Service

After the 12-month grace period on dedicated hosting:

* Hosting for that Umbraco version **is discontinued**.
* Projects that have not been upgraded or migrated to a supported version will **stop working**.
* Data and files will be accessible for an additional **30 days after End-of-Service**. 

To avoid downtime, customers are encouraged to upgrade or migrate to a supported version well in advance of this date.

## Example Timeline

| Stage           | What Happens                                      | Duration           |
|-----------------|---------------------------------------------------|--------------------|
| LTS             | Full support and updates                          | Until EOL          |
| XLTS            | Hosting continues, patches require XLTS contract  | Up to 24 months    |
| Post-XLTS       | Projects moved to dedicated hosting               | 12 months          |
| End-of-Service  | Hosting discontinued                              | -       

**Example dates (Umbraco 13):**

* EOL: December 14, 2026
* XLTS ends: December 14, 2028
* Projects move to dedicated hosting: December 14, 2028
* Hosting ends: December 14, 2029

Subsequent Standard-term Support (STS) versions are subject to the same End-of-Service date as the preceding LTS version. This means that Umbraco 14, 15, and 16 will be End-of-Service on December 14, 2029.

## Why This Policy Exists

This policy ensures that Umbraco Cloud remains a **secure, stable, and high-performing platform** for all users. Running unsupported software increases security risks and maintenance complexity. 

By defining a clear process and timeline, every customer and partner can plan upgrades with confidence.

## Summary

* Hosting continues after EOL for the duration of the XLTS period.
* Security and compliance patches are available only with an XLTS contract.
* After XLTS ends, projects move to dedicated hosting for 12 months.
* Hosting ends after the grace period unless the project is upgraded.
* Clear notifications are sent before every stage of the lifecycle.

<sup>1</sup> Information and availability on Extended Long-term support for Umbraco can be found on [umbraco.com](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/xlts/).

## End-of-Service Overview

### Active releases

| Version       | Release date           | Release Type | End-of-Life           | End of XLTS           | End-of-Service (Umbraco Cloud) |
|---------------|------------------------|--------------|-----------------------|-----------------------|--------------------------------|
| **Umbraco 17** | **November 27, 2025** | **LTS**      | **November 27, 2028** | **November 27, 2030** | **November 27, 2031**          |
| Umbraco 16    | June 12, 2025          | STS          | June 12, 2026         | *LTS Only*            | December 14, 2029              |
| **Umbraco 13** | **December 14, 2023** | **LTS**      | **December 14, 2026** | **December 14, 2028** | **December 14, 2029**          |


### Upcoming releases

| Version        | Release date         | Release Type | End-of-Life          | End of XLTS          | End-of-Service (Umbraco Cloud) |
|----------------|----------------------|--------------|----------------------|----------------------|--------------------------------|
| **Umbraco 21** | **December 9, 2027** | **LTS**      | **December 9, 2030** | **December 9, 2032** | **December 9, 2033**           |
| Umbraco 20     | June 24, 2027        | STS          | June 24, 2028        | *LTS Only*           | November 27, 2031              |
| Umbraco 19     | December 10, 2026    | STS          | December 10, 2027    | *LTS Only*           | November 27, 2031              |
| Umbraco 18     | June 25, 2026        | STS          | June 25, 2027        | *LTS Only*           | November 27, 2031              |


### End-of-life

| Version        | Release date          | Release Type | End-of-Life            | End of XLTS           | End-of-Service (Umbraco Cloud) |
|----------------|-----------------------|--------------|------------------------|-----------------------|--------------------------------|
| Umbraco 15     | November 14, 2024     | STS          | November 14, 2025      | *LTS Only*            | December 14, 2029              |
| Umbraco 14     | May 30, 2024          | STS          | May 30, 2025           | *LTS Only*            | December 14, 2029              |
| Umbraco 12     | June 29, 2023         | STS          | June 29, 2024          | *LTS Only*            | June 16, 2028                  |
| Umbraco 11     | December 1, 2022      | STS          | December 1, 2023       | *LTS Only*            | June 16, 2028                  |
| **Umbraco 10** | **June 16, 2022**     | **LTS**      | **June 16, 2025**      | **June 16, 2027**     | **June 16, 2028**              |
| Umbraco 9      | September 28, 2021    | STS          | December 16, 2022      | *LTS Only*            | February 24, 2028              |
| **Umbraco 8**  | **February 26, 2019** | **N/A**      | **February 24, 2025**  | **February 24, 2027** | **February 24, 2028**          |
| **Umbraco 7**  | **November 21, 2013** | **N/A**      | **September 30, 2023** | **January 1, 2027**   | **January 1, 2028**            |

