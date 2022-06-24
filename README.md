# Umbraco-Dokumentationsprojekt
 [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org)

# Lesen und Verwenden der Dokumente
Dies ist das Dokumentationsprojekt für Umbraco. Der Umfang dieses Projekts besteht darin, Übersichten über Konzepte, Tutorials, Beispielcode und Links zu API-Referenzen bereitzustellen.

# Was steht in der Dokumentation

## Einstieg
[Erste Schritte](Getting-Started/) ist eine Einführung in Umbraco, die Erläuterungen zu grundlegenden Konzepten und kurze Tutorials enthält.

## Implementierung
[Implementierung](Implementation/) ist ein Überblick über die Struktur und Pipeline von Umbraco.

## Entwicklerreferenz
[Reference](Reference/index.md) ist eine Sammlung von API-Referenzen speziell für Entwickler, die mit Umbraco arbeiten und diese erweitern.

## Verlängerung
[Extending](Extending/) ist eine Dokumentation zum Anpassen und Erweitern des Backoffice.

## Tutorials
[Tutorials](Tutorials/) ist eine Sammlung der umfangreicheren Tutorials, die in der Dokumentation verwendet werden.

# Markdown-Konventionen
Die Umbraco-Dokumentation verwendet Markdown für die gesamte Dokumentation; Bitte informieren Sie sich über unsere [Markdown-Konventionen](Contribute/Markdown-Conventions/).

# Ein Dokument kommentieren

Um Versionsinformationen und zusätzliche Schlüsselwörter hinzuzufügen, [jedes Dokument kann mit YAML kommentiert werden] (Contribute/Adding-Metadata/index.md).

# Dokumentation für mehrere Versionen
Jede neue Version von Umbraco führt neue Funktionen ein. Dies bedeutet, dass möglicherweise nicht jedes Dokument für Ihre möglicherweise ältere Version funktioniert.

Daher haben wir 2 verschiedene Mechanismen eingeführt:
1. Die [YAML-Metadaten beschreiben](Contribute/Adding-Metadata/index.md) „versionFrom“ und „versionTo“.
2. Die Möglichkeit [mehrere Dateien zum selben Thema hinzuzufügen] (Contribute/File-Naming-Conventions/index.md).

# Lokale Vorschau der gerenderten Ausgabe

Es gibt ein experimentelles Projekt, das das lokale Rendern der Dokumentation unterstützt.

Sie können das Tool von [NuGet](https://www.nuget.org/packages/Umbraco.Docs.Preview.App/) installieren, indem Sie den folgenden Befehl ausführen.

```bash
$ dotnet tool install --global Umbraco.Docs.Preview.App
```

Oder schauen Sie sich die Quelle an unter: [https://github.com/umbraco/UmbracoDocs.Preview](https://github.com/umbraco/UmbracoDocs.Preview).

Navigieren Sie nach der Installation zu Ihrem lokalen Klon des UmbracoDocs-Repositorys und führen Sie den Befehl „umbracodocs“ aus. Dadurch wird ein lokaler Webserver gestartet, der standardmäßig auf `http://localhost:5000` und `https://localhost:5001` lauscht (die tatsächlichen URLs werden angezeigt), die Sie in Ihrem Browser öffnen können, um das gerenderte anzuzeigen Dokumentation.

# Beitragen [![Beiträge willkommen](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/umbraco/UmbracoDocs/issues) [ ![GitHub-Mitwirkende](https://img.shields.io/github/contributors/umbraco/UmbracoDocs.svg)](https://GitHub.com/umbraco/UmbracoDocsgraphs/contributors/)
Wir :heart: wertvolle Beiträge von allen, die bereit sind zu helfen. Dabei spielt es für uns keine Rolle, ob es sich um etwas Triviales wie das Korrigieren von Rechtschreibfehlern, das Melden eines Problems oder das Schreiben eines Tutorials handelt! Jede noch so kleine Hilfe zählt und trägt dazu bei, Umbraco für alle benutzerfreundlicher zu machen.
Ansonsten sind [Fehlerberichte](https://github.com/umbraco/UmbracoDocs/issues/), [Fehlerbehebungen](https://github.com/umbraco/UmbracoDocs/pulls) und jedes Feedback zu Umbraco immer willkommen .
Sehen Sie sich die [Contributor Guidelines](CONTRIBUTING.md) an, um zu erfahren, wie Sie sich beteiligen und bei der Umbraco-Dokumentation helfen können.
## Lizenz [![MIT lizenziert](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.md)
Diese Bibliothek wird unter der [MIT-Lizenz](LICENSE.md) veröffentlicht.