---
layout: post
title: "Einleitung"
---

Diese Vorlesung ist eine Einführung in die Grundkonzepte im Bereich Algorithmen und Datenstrukturen.
Erfolgreiche Studierende sind nach dem Besuch dieser Vorlesung in der Lage, sich die abstrakte (mathematische) Beschreibung einer Datenstruktur oder eines Algorithmus selbstständig zu erarbeiten.
Des Weiteren sind sie in der Lage, den abstrakten Algorithmus in eine konkrete Implementierung zu überführen.
Bei der konkreten Implementierung werden Grundregeln guter Programmierung beachtet, wie Formatierung, Wahl von Bezeichnern und Strukturierung des Codes.
Zu guter Letzt sind die Studierenden in der Lage, Laufzeiten von Algorithmen zu vergleichen und bei der Wahl eines geeigneten Algorithmus zu berücksichtigen.

## Was ist ein Algorithmus?

Ein Algorithmus ist eine **exakte** und **abstrakte** Beschreibung eines systematischen Vorgehens zur **Lösung eines Problems**.
Die “Lösung eines Problems” bedeutet dabei, dass ein Algorithmus aus einer definierten Menge von Eingaben eine bestimmte Ausgabe errechnet.
Ein Algorithmus ist in der Hinsicht “exakt”, dass die Beschreibung keine Lücken lässt, sondern alle benötigten Schritte enthält.
Der Begriff “abstrakt” besagt, dass die Beschreibung unabhängig von einer konkreten Umsetzung in einer bestimmten Programmiersprache ist.
Das heißt, ein Algorithmus lässt sich mit Anpassungen an die entsprechende Sprache in verschiedenen Programmiersprachen umsetzen.
Aus diesem Grund werden Algorithmen häufig in Form von Pseudocode angegeben.
Dabei handelt es sich um eine Programmiersprache, welche die Konstrukte typischer imperativer bzw. objektorientierter Programmiersprachen wie Zuweisungen, Konditionale und Schleifen zur Verfügung stellt.
Diese Programmiersprachen sind aber nicht ausführbar wie “normale” Programmiersprachen, da es keine Implementierung für die Sprache gibt.
Das heißt, es gibt weder einen Interpreter noch einen Compiler für die Sprache.
Einzelne Anweisungen werden in Pseudocode außerdem häufig umgangssprachlich oder mathematisch beschrieben.
In dieser Vorlesung werden wir in den allermeisten Fällen Java-Programme verwenden und keinen Pseudocode.
Die Ideen der Implementierungen in dieser Vorlesung sind aber nicht auf Java beschränkt sondern können in allen imperativen bzw. objektorientierten Programmiersprachen umgesetzt werden.

## Was ist eine Datenstruktur?

Eine Datenstruktur ist ein systematischer Ansatz, Daten zu organisieren und zu speichern.
Darüber hinaus bietet sie Operationen für den Zugriff und die Veränderung der Daten.
Algorithmen und Datenstrukturen gehen dabei Hand in Hand.
Einerseits kann man komplexere Operationen auf Datenstrukturen als einfache Algorithmen verstehen, andererseits verwenden Algorithmen Datenstrukturen, um Probleme effizient zu lösen.
Die Wahl der Datenstruktur bestimmt häufig die Laufzeit und den Speicheraufwand eines Algorithmus.

## Was ist eine Komplexität?

Die abstrakte Klassifikation des Aufwandes, den ein Algorithmus benötigt, wird als Komplexität des Algorithmus bezeichnet.
Die Komplexität beschreibt dabei nicht die reale Zeit, die die Ausführung eines Algorithmus benötigt, sondern eine abstrakte Größenordnung.
Man verwendet eine solche abstrakte Klassifikation, um von der konkreten Wahl der Programmiersprache und des Rechners, auf dem der Algorithmus ausgeführt wird, abstrahieren zu können.
Diese Klassifikation dient vor allem, um die Effizienz von verschiedenen Algorithmen schnell gegeneinander abschätzen zu können.

{% include bottom-nav.html previous="basics.html" next="linear-data-structures.html" %}
