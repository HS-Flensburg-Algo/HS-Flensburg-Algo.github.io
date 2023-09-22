---
layout: post
title: "Grundlagen"
---

Hier werden Grundlagen erläutert, die für die Vorlesung benötigt werden.
Dabei werden vor allem Inhalte aus den Programmierveranstaltungen noch einmal wiederholt bzw. etwas vertieft.


## Sichtbarkeit von Variablen

Der englische Begriff **_Scope_** beschreibt den Bereich, in dem eine Variable sichtbar ist.
Sichtbar bedeutet, dass wir in diesem Bereich die Variable lesen und schreiben können.
In Java sind Variablen zuerst einmal nur in den Anweisungen hinter ihrer Deklaration sichtbar.

```java
public static void main(String[] args) {
    <hier kann x nicht verwendet werden>
    int x;
    <hier kann x verwendet werden>
}
```

Außerdem ist eine Variable immer nur in dem Block sichtbar, der sie umschließt.
Ein Block wird dabei durch `{` und `}` definiert.
Der Block, der die Variable `x` umschließt, startet mit der `{` in Zeile 1 und endet mit der `}` in Zeile 5.
Da eine Variable außerdem nur nach ihrer Deklaration sichtbar ist, ist die Variable `x` nur in der Zeile 4 sichtbar.

Der umschließende Block kann nicht nur der Block einer Methode, sondern auch der Block einer `if`-Anweisung oder einer Schleife sein.
Im folgenden Beispiel wird die Deklaration der Variable `x` zum Beispiel durch den Block des `else`-Zweiges umschlossen.

```java
public static void main(String[] args) {
    <hier kann x nicht verwendet werden>
    if (args.length < 1) {
        <hier kann x nicht verwendet werden>
    } else { 
        <hier kann x nicht verwendet werden>
        int x;
        <hier kann x verwendet werden>
    }
    <hier kann x nicht verwendet werden>
}
```

Dieser Block startet mit der `{` in Zeile 5 und endet mit der `}` in Zeile 11.
Das heißt, die Variable `x` ist nur in der Zeile 8 sichtbar.

Im folgenden Beispiel sind die beiden Zweige der `if`-Anweisung noch einmal vertauscht.

```java
public static void main(String[] args) {
    <hier kann x nicht verwendet werden>
    if (args.length < 1) {
        <hier kann x nicht verwendet werden>
        int x;
        <hier kann x verwendet werden>
    } else {
        <hier kann x nicht verwendet werden>
    }
    <hier kann x nicht verwendet werden>
}
```

In diesem Beispiel ist die Variable `x` nur im `then`-Zweig der `if`-Anweisung sichtbar.
Das heißt, die Variable `x` ist nur in Zeile 6 sichtbar.


## Die Klasse `Object`

In Java ist die Klasse `Object` die Oberklasse aller Klassen.
Das heißt, alle Klassen in Java erben von der Klasse `Object`.
In der Klasse `Object` sind ein paar sehr grundlegende Methoden implementiert, etwa die Methoden `equals(Object)`, `clone()` und `toString()`.
Da alle Klassen von der Klasse `Object` erben, erben somit alle Klasse die Methoden `equals(Object)`, `clone()` und `toString()`.

In einer Programmiersprache mit Vererbung kann ein Wert von einer Unterklasse in eine Variable der Oberklasse geschrieben werden.

```java
public static void main(String[] args) {
    String s1 = "test";
    Object o = s1;
    String s2 = o;
    char c = s2.charAt(0);
}
```

Die Zuweisung in Zeile 3 ist erlaubt.
Da `String` eine Unterklasse von `Object` ist, können wir auf das Objekt `o` nur Methoden aufrufen, die es auch in der Klasse `String` gibt.
Daher ist die Zuweisung in Zeile 3 in einer Sprache mit Vererbung sicher.
Im Unterschied dazu ist die Zuweisung in Zeile 4 nicht erlaubt.
Das heißt, die Zuweisung in Zeile 4 verursacht einen Fehler beim Kompilieren.
Die Zuweisung in Zeile 4 ist nicht erlaubt, da sie nicht sicher ist.
Wenn die Zuweisung erlaubt wäre, könnten wir auf den `String` `s2` eine Methode aufrufen, die es in der Klasse `Object` gar nicht gibt.
Zum Beispiel könnten wir den Aufruf in Zeile 5 durchführen, die Methode `charAt` gibt es auf dem Typ `Object` aber gar nicht.

Da alle Klassen Unterklassen von `Object` sind, können also alle Werte von Objekttypen in eine Variable vom Typ `Object` geschrieben werden.
Im folgenden Abschnitt sehen wir Beispiele für Werte in Java, die nicht in eine Variable vom Typ `Object` geschrieben werden können, da es sich nicht um Objekttypen handelt.


## Primitive Typen und Objekttypen

In Java unterscheidet man zwei unterschiedliche Arten von Typen.
Typen, die mit einem kleinen Anfangsbuchstaben starten, wie `int` und `boolean`, werden als primitive Typen bezeichnet.
Die Werte dieser Typen werden direkt im Heap gespeichert, das heißt, an der Stelle im Speicher, für die eine Variable steht, steht dann zum Beispiel eine `23`.
Typen, die mit einem großen Anfangsbuchstaben starten, bezeichnet man als Objekt- oder Referenztyp.
Beispiele für solche Typen sind `String`, `Object` oder `ArrayList`.
Bei Objekttypen wird nicht direkt der Wert im Speicher abgelegt, sondern nur eine Referenz auf die Speicherstelle, an der der tatsächliche Wert liegt.
Das heißt, eine Variable enthält intern nicht den konkreten Wert sondern eine Speicheradresse, die sagt, wo wir den tatsächlichen Wert im Speicher finden.
Objekttypen können daher den Wert `null` annehmen.
Der Wert `null` bedeutet dabei, dass die Referenz auf die Speicherstelle fehlt.

In Java gibt es zu jedem primitiven Typ auch einen entsprechenden Objekttyp.
So gibt es zu `int` zum Beispiel den Typ `Integer` und zu `boolean` den Typ `Boolean`.
Diese Referenztypen werden auch als **_Wrapper_-Klassen** bezeichnet, da es sich um eine einfache Klasse handelt, die als Attribut den konkreten Wert speichert.
Das heißt, ein Objekt vom Typ `Integer` hat ein Attribut, das einen Wert vom Typ `int` enthält.
Man nutzt _Wrapper_-Klassen an Stelle der primitiven Typen, wenn man zusätzlich zu den möglichen Werten, den Wert `null` nutzen möchte.
Häufig nutzt man den Wert `null`, um zu signalisieren, dass eine Methode kein Ergebnis liefern kann.
Das heißt, eine Methode, die als Ergebnistyp `Integer` nutzt kann eine ganze Zahl oder kein Ergebnis (`null`) liefern.

Die _Wrapper_-Klassen werden auch im Kontext von generischen Definitionen genutzt.
Für Typparameter, die in generischen Definitionen genutzt werden, dürfen wir keine primitiven Typen einsetzen, sondern nur Objekttypen.
Das heißt, wenn wir zum Beispiel eine `ArrayList` mit Zahlen als Einträgen nutzen möchten, verwenden wir `ArrayList<Integer>`, da `ArrayList<int>` nicht erlaubt ist.
Wir dürfen primitive Typen nicht für Typparameter nutzen, da das Konzept der _Generics_ in Java mithilfe des Typs `Object` implementiert ist.
<!-- Bei der Übersetzung von Java-Klassen wird eine sogenannte _Type Erasure_ durchgeführt.
Das heißt, die generischen Typen werden -->


## Gleichheit

Werte von primitiven Typen wie `int` und `boolean` werden in Java mithilfe des Operators `==` auf Gleichheit getestet.
Neben den primitiven Typen gibt es in Java noch Objekt- oder Referenztypen, deren Namen mit einem großen Buchstaben starten.
Beispiele sind etwa `String`, `Integer` oder `ArrayList`.
In Java gibt es zwei Möglichkeiten, um Werte von Objekten miteinander zu vergleichen.
Der Operator `==` überprüft, ob es sich bei den beiden übergebenen Argumenten um dasselbe Objekt handelt.
Das heißt, der Operator `==` überprüft, ob die beiden Objekte an derselben Stelle im Speicher stehen.
Die Objektmethode `equals(Object)` überprüft dagegen, ob es sich um die gleichen Objekte handelt.
Um zu überprüfen, ob zwei Objekte gleich sind, müssen in den meisten Fällen für alle Attribute getestet werden, ob sie gleich sind.
Der Vergleich der beiden Speicherstellen ist sehr effizient möglich, der Vergleich aller Attribute kann dagegen etwas Zeit in Anspruch nehmen.

Die Methode `equals(Object)` ist in der Klasse `Object` definiert und steht somit für alle Klassen in Java zur Verfügung.
Die Standardimplementierung dieser Methode verwendet den Operator `==`.
Daher sollte die Methode `equals(Object)` überschrieben werden, wenn eine neue Klasse angelegt wird, da ansonsten nur dieselben Objekte als gleich gelten.


## Modifikator `final`

Das Schlüsselwort `final` ist in Java ein Modifikator, der Einfluss auf die Änderungsmöglichkeiten einer Entität hat.
Als `final` deklarierte Variablen (lokale Variablen als auch Attribute) sind nach der Initialisierung nicht mehr änderbar.
Das folgende Programm liefert zum Beispiel einen Fehler.

```java
final int[] array1 = {1, 2, 3, 4};
int[] array2 = {1, 2, 3, 4};
array1 = array2;
```

Die Zuweisung in Zeile 3 ist nicht erlaubt, da die Variable `array1` `final` ist und damit keinen neuen Wert erhalten darf.
Dabei ist wichtig, dass sich das `final` wirklich nur auf die Variable bezieht aber nicht auf den Inhalt der Variable.
Das heißt, wenn wir eine Struktur in einer Variable mit `final`-Modifikator speichern, können wir die Struktur weiterhin verändern.
Das folgende Programm liefert zum Beispiel keinen Fehler.

```java
final int[] array = {1, 2, 3, 4};
array[1] = 12;
```

Hier können wir die Variable `array` zwar nicht neu setzen, wir können aber durchaus die Inhalte des Arrays ändern.
Das heißt, die Variable ist zwar unveränderbar, die Struktur in der Variable kann aber weiterhin veränderbar sein.
Parameter von Methoden oder Konstruktoren, die den `final`-Modifikator haben, verhalten sich ganz analog zu den lokalen Variablen.
Das heißt, wenn eine Methode einen Parameter mit dem Modifikator `final` hat, kann der Wert des Parameters innerhalb der Methode nicht verändert werden.
Hier gilt ebenfalls, dass eine Struktur, die im Parameter gespeichert ist, aber weiterhin verändert werden kann.

Wir können den Modifikator `final` nicht nur für Variablen nutzen, sondern auch für die folgenden Konstrukte.

- **finale Klassen:** können nicht abgeleitet/erweitert werden, dürfen also bei der Definition einer neuen Klasse nicht hinter dem `extends` stehen
- **finale Methoden:** können in abgeleiteten Klassen nicht überschrieben werden


<!-- ## JUnit-Testklassen

JUnit-Testfälle werden in einer normalen Java-Klasse definiert.
Die einzelnen Testfälle sind normale Java-Methoden.
Um aus einer Methode einen JUnit-Testfall zu machen, wird die Annotation `@Test` genutzt.
Jede Methode, die diese Annotation hat, ist ein Testfall und wird bei der Ausführung der Testfälle ausgeführt.
Die folgende Testklasse gibt zum Beispiel an, dass die Methode `testMaximum` ein Testfall ist.

```java
public class MaximumTest {

    @Test
    public void testMaximum() {
        assertEquals(2, Maximum.max(1, 2));
    }
}
```

Die Methode `assertEquals` wird durch die JUnit-Bibliothek zur Verfügung gestellt.
Diese Methode prüft, ob beide Argumente identisch sind. -->


## Lokale Typinferenz

In der Vorlesung und für die Bearbeitung der Aufgaben wird ein Java-Feature genutzt, das **lokale Typinferenz** heißt.
Wenn eine Programmiersprache eine Typinferenz implementiert, ist der Compiler der Sprache in der Lage, den Typ eines Ausdrucks oder eine Anweisung selbst zu berechnen.
Das heißt, der Nutzer muss den Typ nicht mehr manuell angeben.
In statischen Programmiersprachen wie Java müssen an sehr vielen Stellen Typen angegeben werden.
Der folgende Java-Code erzeugt zum Beispiel eine Variable mit einer Liste.

```java
ArrayList<String> list = new ArrayList<String>();
```

Die Information, dass die Variable `list` den Typ `ArrayList<String>` hat, ist hier eigentlich unnötig, da wir an der rechten Seite der Zuweisung diese Information ebenfalls ablesen können.
Eine Typinferenz erlaubt es uns, solche unnötigen Typannotationen wegzulassen.

Java stellt stellt seit Version 10 eine Typinferenz zur Verfügung. 
Diese Typinferenz wird als lokal bezeichnet, da für die Inferenz nur Informationen herangezogen werden, die sich in unmittelbarer Nähe befinden.
In Java wird zum Beispiel nur die rechte Seite der Zuweisung für die Typinferenz herangezogen.
Bei einer (nicht-lokalen) Typinferenz wird auch berücksichtigt, wie die Variable `list` verwendet wird, um den Typ der Variable zu inferieren.

Statt eine Typannotation wie `ArrayList<String>` zu verwenden, können wir in Java das Schlüsselwort `var` verwenden.
Dieses Schlüsselwort gibt an, dass wir die lokale Typinferenz nutzen wollen.
Das heißt, das Beispiel von oben kann mit lokaler Typinferenz wie folgt geschrieben werden.

```java
var list = new ArrayList<String>();
```





<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"><a href="introduction.html">weiter</a></li>
    </ul>
</div>