# Richtlinien für Beiträge

Um entweder zur Dokumentation oder zu Stubs beizutragen, können Sie unser Repository forken und klonen, Ihre Änderungen vornehmen und zu GitHub zurückschieben und uns eine Pull-Anfrage senden. Alle Elemente, die in das Haupt-Repository gezogen werden, werden automatisch an [our.umbraco.com/documentation] (https://our.umbraco.com/documentation) gepusht.

## Erste Schritte mit Git und GitHub

* [GitHub-Desktop herunterladen](https://desktop.github.com)
* [GitHub Desktop konfigurieren](https://help.github.com/desktop/guides/)
* [GitHub-Repository forken](https://help.github.com/articles/fork-a-repo/)
* [Die grundlegende Anleitung zu Git](https://rogerdudler.github.io/git-guide/)

## Repository-Organisation

Alle aktiven Arbeiten an der Dokumentation werden derzeit im Hauptzweig durchgeführt.

### Halten Sie Ihren UmbracoDocs-Fork mit dem Haupt-Repository synchron

Wenn Sie sich entscheiden, das UmbracoDocs-Repository auf Ihrem lokalen Computer zu klonen, um größere Änderungen vorzunehmen, die nicht direkt auf GitHub vorgenommen werden können, empfehlen wir Ihnen, mit unserem Repository zu synchronisieren, bevor Sie Ihre Pull-Anfrage senden. Auf diese Weise können Sie potenzielle Zusammenführungskonflikte beheben und unser Leben ein wenig einfacher machen.

Um Ihren Fork mit diesem Original zu synchronisieren, müssen Sie die Upstream-URL hinzufügen, Sie müssen dies nur einmal tun:

„xml
git remote add upstream https://github.com/umbraco/UmbracoDocs.git
```

Wenn Sie dann die Änderungen aus dem Haupt-Repository abrufen möchten:

„xml
git stromaufwärts abrufen
git rebase upstream/main
```

In diesem Befehl synchronisieren wir mit dem Hauptzweig. Sie können bei Bedarf eine andere auswählen.

### Beitragende Dokumentation

Alle Dokumente werden in Markdown geschrieben, verwenden eine Grundstruktur und werden als .md-Dateien gespeichert.
Diese werden dann zum Durchsuchen auf [our.umbraco.com/documentation](https://our.umbraco.com/documentation) gezogen.

Forken und klonen Sie zuerst das Repository, damit Sie Ihre eigene Arbeitskopie haben. Erstellen Sie dann einen neuen Zweig auf Ihrer lokalen Kopie, um Ihre Änderungen vorzunehmen. Wenn Sie mit Ihren Änderungen zufrieden sind, verwenden Sie GitHub, um eine „Pull-Anforderung“ zu stellen, was bedeutet, dass Ihre Änderungen überprüft und nach der Annahme in das Haupt-Repository zusammengeführt werden.

**Hinweis:** Es ist eine gute Idee, Upstream-Änderungen einzufügen, zusammenzuführen und an Ihren eigenen Fork zu übergeben, bevor Sie einen Pull-Request senden. Anweisungen zum Einrichten eines Remote-Repos und Pullen aus dem Upstream finden Sie auf dieser [Seite](https://help.github.com/articles/fork-a-repo).

Alles im Haupt-Repository wird es auf die Website [our.umbraco.com/documentation](https://our.umbraco.com/documentation) schaffen, weshalb wir einen Pull-Request-Workflow gewählt haben, um alles unkompliziert zu halten.

## Planung & Diskussionen

Wenn Sie ein Problem melden möchten oder eine große Änderung planen, verwenden Sie [GitHub-Issues](https://github.com/umbraco/UmbracoDocs/issues), um eine Diskussion zu eröffnen. Wenn Sie eine kleine Änderung vornehmen möchten, zögern Sie nicht, eine Pull-Anfrage zu stellen, Sie müssen nicht zuerst ein Problem erstellen.