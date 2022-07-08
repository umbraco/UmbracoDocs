# Vorgehen um Links zu übersetzen
Folgendes ist beim Übersetzen der Struktur und den entsprechenden Verlinkungen zu beachten:

1. Struktur hier auflisten
2. Abschnitt auf erster Ebene übersetzen und EN Version wieder herstellen
3. Über alle Dokumente einer DE-Ebene suchen und ersetzen. Links haben das Formnat: `[label](url)`.
4. :::tip, :::note, :::center, :::links, :::en-link, etc. Markierungen dürfen nicht übersetzt werden.
5. Git-Commit
6. Seiteninhalt in Google-Translater kopiern und durch Übersetzung ersetzen.
7. URLs und Markdown-Elemente genau kontrollieren.
8. Link zur EN-Version unter Überschrift einfügen: :::en-link [EN-Version](.../index.md) :::

## Struktur
### English -> Deutsch

#### Getting-Started -> 01-Erste-Schritte
1. Managing-an-Umbraco-project -> Verwaltung-eines-Umbraco-Projekts
2. Editing-websites-with-Umbraco -> Webseiten-mit-Umbraco-bearbeiten
3. Creating-websites-with-Umbraco -> Webseiten-erstellen-mit-Umbraco
4. Developing-websites-with-Umbraco -> Webseiten-mit-Umbraco-entwickeln
    1. Customizing-Umbraco-sites -> Umbraco-Webseiten-anpassen
    2. Extending-the-Umbraco-Backoffice -> Erweiterung-des-Umbraco-Backoffice
5. Hosting-an-Umbraco-infrastructure -> Hosting-einer-Umbraco-Infrastruktur
6. Where-can-I-get-help -> Wo-kann-ich-Hilfe-bekommen
#### Fundamentals -> 02-Grundlagen
1. Backoffice -> Verwaltung
    1. Content-Templates -> Inhaltsvorlagen
    2. Infinite-editing -> Endlos-bearbeiten
    3. Login -> Anmeldung
    4. LogViewer -> Protokolanzeige
    5. Property-Editors -> Eigenschaften-bearbeiten
        1. Built-in-Property-Editors -> Vorhandene-Eigenschaften
    6. Sections -> Bereiche
    7. Variants -> Varianten
2. Code -> Kode
    1. Umbraco-Services -> Umbraco-Dienste
    2. Subscribing-To-Events -> Auf-Ereignisse-reagieren
    3. Creating-Forms -> Formulare-erstellen
    4. Debugging -> Fehlersuche
    5. Source-Control -> Quellkodeverwaltung
    6. Subscribing-To-Notifications -> Auf-Benachrichtigungen-reagieren
3. Data -> Daten
    1. Defining-content -> Dokumentarten-definieren 
    2. Creating-Media -> Medien-erzeugen
        1. default-media-types.md -> standard-medientypen.md
    3. Members -> Mitglieder
    4. Data-Types -> Datentypen
        1. default-data-types.md -> standard-datentypen.md
    5. Scheduled-Publishing -> Zeitgesteuertes-Veröffentlichen
    6. Adding-Tabs -> Register-hinzufügen
    7. Content-Version-Cleanup -> Inhaltsversionen-aufräumen
    8. Dictionary-Items -> Wörterbucheinträge
    9. Users -> Benutzer
4. Design -> Entwurf
    1. Templates -> Vorlagen
    2. Rendering-Content -> Inhalte-darstellen
    3. Rendering-Media -> Medien-darstellen
    4. Stylesheets-Javascript -> Stylesheets-Javascript
    5. Partial-View-Macro-Files -> Teilansicht-Makros
    6. Partial-Views -> Teilansichten
5. Setup -> Konfiguration
    1. Requirements -> Anforderungen
    2. Install -> Installation
    3. Upgrading -> Upgrade-durchführen
    4. Server-Setup -> Server-Konfiguration

#### Implementation -> 03-Implementierung (Umsetzung)

    Default-Routing -> Standard-Routing

#### Extending -> 04-Erweitern

#### Reference -> 05-Referenz

#### Tutorials -> 06-Anleitungen

#### Add ons -> 07-Zugaben

#### Umbraco Cloud -> 08-Umbraco Cloud

#### Umbraco Heartcore -> 09-Umbraco Heartcore

#### Contribute -> 10-Beitragen

#### Development-Guidelines -> x-01-Entwicklungsrichtlinien

#### Cheatsheets -> x-02-Cheatsheets