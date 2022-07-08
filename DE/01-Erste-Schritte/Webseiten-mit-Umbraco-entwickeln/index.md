---
meta.Title: "Webseiten mit Umbraco entwickeln"
meta.Description: "Dieser Abschnitt zeigt Ihnen einige Einsteiger-Tools und Informationen für den Einstieg in Umbraco 8. Von der Erstellung einer lokalen Installation bis zur Erweiterung des Backoffice."
VersionVon: 8.0.0
---
# Webseiten mit Umbraco entwickeln
:::right
[EN-Version](/Getting-Started/Developing-websites-with-Umbraco/index.md)
:::
Umbraco basiert auf einem Microsoft MVC-Framework. Sie können auf dieser Technologie aufbauen, um parallel zur Funktionalität von Umbraco zu arbeiten und diese zu erweitern. Es ist außerdem modular konzipiert, sodass Sie Schlüsselkomponenten bei Bedarf durch Ihre eigenen benutzerdefinierten Implementierungen ersetzen können.

:::tip
Es ist durchaus möglich, eine Umbraco-Site ohne Visual Studio zu erstellen und die auf dieser Seite vorgestellten Techniken zu verwenden - siehe Abschnitt [Websites erstellen mit Umbraco](../Websites-erstellen-mit-Umbraco).
:::

Dieser Abschnitt widmet sich der Einführung von Techniken, die Ihnen beim Einstieg in die Entwicklung mit einer Umbraco-Site helfen. Sie finden Informationen darüber, wie Sie mit dem zugrunde liegenden Framework eines Umbraco-Projekts entwickeln können, sowie Details darüber, wie Sie das Umbraco-Backoffice erweitern können, um die Bearbeitungserfahrung anzupassen.

Die in diesem Abschnitt beschriebenen Konzepte gehen über standardmäßige, sofort einsatzbereite Templating-Methoden hinaus und führen einige Umbraco-spezifische Begriffe und Hilfsfunktionen ein, wie z.B. SurfaceControllers und Verwaltungsdienst-APIs. All dies sind Technologien, die Sie bei der Entwicklung mit Umbraco nutzen können.

Sie finden auch Informationen zum zugrunde liegenden Dependency-Injection-Framework von Umbraco.

Dies wird in zwei Abschnitte unterteilt: Erweiterung des Umbraco-Backoffice und Entwicklung benutzerdefinierter Websites.

## [Erweitern des Umbraco-Backoffice](Erweiterung-des-Umbraco-Backoffice)

Das Umbraco-Backoffice kann mit AngularJS und C# erweitert werden. Das Anpassen des Umbraco-Backoffice und der Bearbeitungserfahrung umfasst das Erstellen Ihrer eigenen Eigenschaftseditoren, Dashboards und Pakete. Sie finden auch Informationen darüber, wie Sie Zustandsprüfungen und die integrierte Suchfunktion anpassen können.

[Schauen Sie sich den Abschnitt Erweitern dieser Dokumente an](../../Extending/) für einen guten Anfang.

:::note
Aus Frontend-Perspektive schreibt Umbraco HTML, CSS oder JS in Ihrem Website-Build nicht vor. Daran ist nichts Umbraco-spezifisches.
:::

## [Anpassen von Umbraco-Sites](Umbraco-Webseiten-anpassen)

Umbraco ist hochgradig anpassbar, was bedeutet, dass Sie es grundsätzlich in alles integrieren und es sich so verhalten können, wie Sie es möchten. Mit Umbraco starten Sie mit einer sauberen Weste.

Umbraco verwendet ASP.NET- und MVC-Entwurfsmuster, und Sie können Ihre eigenen Controller mit dem in diesem Abschnitt beschriebenen Ansatz erweitern und schreiben.

:::center
![Umbraco auf Geräten](images/Umbraco_Brand_Guidelines_2020_30_Illustrationbuilding.png)
:::

## IDE-Empfehlungen

Wenn Sie Ihre Umbraco-Website mit C# anpassen oder erweitern, empfehlen wir die Verwendung von [Visual Studio](https://visualstudio.microsoft.com/vs/community/).

Sie können auch ein einfacheres Tool wie [Visual Studio Code](https://visualstudio.microsoft.com/free-developer-offers/) oder einen beliebigen anderen Texteditor verwenden, mit dem Sie lieber arbeiten. Dies wird jedoch nur empfohlen, wenn Sie nicht direkt mit den C#-Dateien arbeiten.

:::tip
Obwohl es durchaus möglich ist, ein Tool wie Notepad zu verwenden und den Code in den Ordner "App_code" Ihrer Website zu legen und ihn beim Start der Website kompilieren zu lassen, empfehlen wir stattdessen die Verwendung eines Tools wie Visual Studio.

Das Tool wird Ihnen dabei viel Unterstützung bieten, da es für die Arbeit mit C#-Dateien, ASP.NET- und MVC-Frameworks entwickelt wurde.
:::