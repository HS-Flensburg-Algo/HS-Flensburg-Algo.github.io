---
layout: post
title: "Grundlagen"
---

Hier werden Grundlagen erläutert, die für die Vorlesung benötigt werden.
Dabei werden vor allem Inhalte aus den Programmierveranstaltungen noch einmal wiederholt bzw. etwas vertieft.

## Gleichheit

Werte von primitiven Typen wie `int` und `boolean` werden in Java mithilfe des Operators `==` auf Gleichheit getestet.
Neben den primitiven Typen gibt es in Java noch Objekt- oder Referenztypen, deren Namen mit einem großen Buchstaben starten.
Beispiele sind etwa `String`, `Integer` oder `ArrayList`.
In Java gibt es zwei Möglichkeiten, um Werte von Objekten miteinander zu vergleichen.
Der Operator `==` überpüft, ob es sich bei den beiden übergebenen Argumenten um dasselbe Objekt handelt.
Das heißt, der Operator `==` überprüft, ob die beiden Objekte an derselben Stelle im Speicher stehen.
Die Objektmethode `equals` überprüft dagegen, ob es sich um die gleichen Objekte handelt.
Um zu überprüfen, ob zwei Objekte gleich sind, müssen in den meisten Fällen die jeweiligen Attribute auf Gleichheit getestet werden.
Der Vergleich der beiden Speicherstellen ist sehr effizient möglich, der Vergleich aller Attribute kann dagegen etwas Zeit in Anspruch nehmen.

Die Methode `equals` ist in der Klasse `Object` definiert und steht somit für alle Klassen in Java zur Verfügung.
Die Standardimplementierung dieser Methode verwendet den Operator `==`.
Daher sollte die Methode `equals` überschrieben werden, wenn eine neue Klasse angelegt wird, da ansonsten nur dieselben Objekte als gleich gelten.

## Modifikator `final`

`final` ist in Java ein Modifikator, der Einfluss auf die Änderungsmöglichkeiten eines Elements hat.
Als `final` deklarierte Variablen (lokale als auch Instanz-) sind nach der Initialisierung nicht mehr änderbar.
Das folgende Programm liefert zum Beispiel einen Fehler.

```java
final int[] array1 = {1, 2, 3, 4};
int[] array2 = {1, 2, 3, 4};
array1 = array2;
```

Dabei ist wichtig, dass sich das `final` wirklich nur auf die Variable bezieht aber nicht auf den Inhalt der Variable.
Das heißt, wenn wir eine Struktur in einer Variable mit `final`-Modifikator speichern, können wir die Struktur weiterhin verändern.
Das folgende Programm liefert zum Beispiel keinen Fehler.

```java
final int[] array1 = {1, 2, 3, 4};
array[1] = 12;
```

Wir können den Modifikator nicht nur Variablen nutzen, sondern auch für die folgenden Konstrukte.

- **finale Klassen:** können nicht abgeleitet/erweitert werden (`extends`)
- **finale Methoden:** können in abgeleiteten Klassen nicht überschrieben werden
- **finale Methodenparameter:** können innerhalb der Methode nicht geschrieben, sondern nur gelesen werden.
  Hier gilt ebenfalls, dass eine Struktur, die im Parameter gespeichert ist, aber weiterhin verändert werden kann.

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"><a href="introduction.html">weiter</a></li>
    </ul>
</div>