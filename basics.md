---
layout: post
title: "Grundlagen"
---

Hier werden Grundlagen erläutert, die für die Vorlesung benötigt werden.
Dabei werden vor allem Inhalte aus den Programmierveranstaltungen noch einmal wiederholt bzw. etwas vertieft.


## Primitive Typen und Objekttypen

In Java unterscheidet man zwei unterschiedliche Arten von Typen.
Typen, die mit einem kleinen Anfangsbuchstaben starten, wie `int` und `boolean`, werden als primitive Typen bezeichnet.
Die Werte dieser Typen werden direkt im Heap gespeichert, das heißt, an der Stelle im Speicher, für die eine Variable steht, steht dann zum Beispiel eine `23`.
Typen, die mit einem großen Anfangsbuchstaben starten, bezeichnet man als Objekt- oder Referenztyp.
Beispiele für solche Typen sind `String`, `Object` oder `ArrayList`.
Bei Objekttypen wird nicht direkt der Wert im Speicher abgelegt, sondern nur eine Referenz auf die Speicherstelle, an der der tatsächliche Wert liegt.
Das heißt, eine Variable enthält intern nicht den konkreten Wert sondern eine Speicheradresse, die sagt, wo wir den tatsächlichen Wert im Speicher finden.
Objekttypen können daher den Wert `null` annehmen.
Der Wert `null` bedeutet dabei, dass Referenz auf die Speicherstelle fehlt.

In Java gibt es zu jedem primitiven Typ auch einen entsprechenden Objekttyp.
So gibt es zu `int` zum Beispiel den Typ `Integer` und zu `boolean` den Typ `Boolean`.
Diese Referenztypen werden auch als Wrapper-Klassen bezeichnet, da es sich um eine einfache Klasse handelt, die als Instanzvariable den konkreten Wert speichert.
Das heißt, ein Objekt vom Typ `Integer` hat eine Instanzvariable, die einen Wert vom Typ `int` enthält.
Man nutzt Wrapper-Klassen an Stelle der primitiven Typen, wenn man zusätzlich zu den möglichen Werten, den Wert `null` nutzen möchte.
Häufig nutzt man diesen Wert, um zu signalisieren, dass eine Methode kein Ergebnis liefern kann.

Die Wrapper-Typen werden auch im Kontext von generischen Definitionen genutzt.
Für Typparameter, die in generischen Definitionen genutzt werden, dürfen wir keine primitiven Typen einsetzen, sondern nur Objekttypen.
Das heißt, wenn wir zum Beispiel eine `ArrayList` mit Zahlen als Einträgen nutzen möchten, verwenden wir `ArrayList<Integer>`, da `ArrayList<int>` nicht erlaubt ist.


## Gleichheit

Werte von primitiven Typen wie `int` und `boolean` werden in Java mithilfe des Operators `==` auf Gleichheit getestet.
Neben den primitiven Typen gibt es in Java noch Objekt- oder Referenztypen, deren Namen mit einem großen Buchstaben starten.
Beispiele sind etwa `String`, `Integer` oder `ArrayList`.
In Java gibt es zwei Möglichkeiten, um Werte von Objekten miteinander zu vergleichen.
Der Operator `==` überprüft, ob es sich bei den beiden übergebenen Argumenten um dasselbe Objekt handelt.
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