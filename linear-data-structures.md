---
layout: post
title: "Lineare Datenstrukturen"
---

Wir starten diese Vorlesung mit einer einfachen Klasse von Datenstrukturen, die in der Praxis aber sehr häufig genutzt werden.
Diese Datenstrukturen können genutzt werden, um mehrere Werte zu einem einzigen zusammenzufassen.
Man spricht dabei von linearen Datenstrukturen, da die einzelnen Werte in einer linearen Reihenfolge angeordnet werden.
Genauer gesagt, kann man in einer linearen Datenstruktur jeden Eintrag, der in der Struktur gespeichert wurde, mithilfe einer natürlichen Zahl adressieren.

Arrays
------

Aus der Vorlesung zur Programmierung ist die Datenstruktur Array bekannt.
Diese erlaubt es, eine feste Anzahl von Elementen zu einem Objekt, nämlich einem Array, zusammenzufassen.
Das folgende Java-Programm erzeugt zum Beispiel ein Array mit drei Elementen und gibt diese auf der Konsole aus.

``` java
var array = new int[3];
array[0] = 1;
array[1] = 2;
array[2] = 3;

for (int i = 0; i < array.length; i++) {
    System.out.println(array[i]);
}
```

Wir werden in dieser Vorlesung überall, wo es möglich ist, die lokale Typinferenz von Java verwenden.
Das Konzept der Typinferenz wird in statisch getypten Programmiersprachen genutzt, um Programmierende davon zu befreien, Typen explizit anzugeben.
Ohne lokale Typinferenz müsste die erste Zeile des obigen Codes `int[] array = new int[3]` heißen.
Hier müssen wir explizit angeben, welchen Typ die Variable `array` hat.
Das Schlüsselwort `var` teilt dem Compiler mit, dass er selbst den Typ der Variable bestimmen soll.
Es gibt statisch getypte Programmiersprachen, bei denen Programmierende gar keine Typen angeben müssen, da alle Typen inferiert werden können.
In Java kann die Typinferenz aber nur in ganz bestimmten Fällen eingesetzt werden.
Wir können `var` nur für lokale Variablen nutzen, die direkt initialisiert werden, denen also direkt ein Wert zugewiesen wird.

Ein Array hat immer eine feste Größe, die man initial angeben muss.
Wenn ein solches Array angelegt wird, wird im Speicher des Computers ein fester Teilbereich des Speichers für dieses Array reserviert.
Reservierter Speicher kann vom Programm nicht mehr genutzt werden.
Dieser Speicher ist dabei zusammenhängend, das heißt, die einzelnen Elemente des Arrays stehen hintereinander im Speicher.
Genauer gesagt, wird für eine Zahl `n` und einen Typ `type` durch einen Ausdruck der Form `new type[n]` Speicher der Größe `n * m` reserviert, wobei `m` der Speicher ist, der für einen Wert vom Typ `type` benötigt wird.

Durch die Verwendung eines zusammenhängenden Speicherabschnitts kann effizient auf die einzelnen Elemente eines Array zugegriffen werden.
Genauer gesagt, können wir für ein Array `a` vom Typ `type[]` und eine Zahl `n` bei einem Ausdruck der Form `a[n]` ausrechnen, an welcher Stelle im Speicher der Wert liegt.
Um zu berechnen, an welcher Stelle im Speicher unser Wert vom Typ `type` liegt, nehmen wir einfach die Anfangsstelle unseres Speicherabschnitts und addieren `n`-mal die Größe eines Wertes vom Typ `type`.

Bei vielen Anwendungen möchte man eine dynamische Anzahl an Elementen in einer Datenstruktur speichern. Das heißt, erst nach dem Sammeln der Elemente in einer Datenstruktur ist klar, wie viele Elemente in der Datenstruktur abgelegt werden sollen.
Wenn wir zum Beispiel einen Warenkorb in einem Web-Shop implementieren, wissen wir nicht, wie viele Gegenstände im Warenkorb gespeichert werden müssen.
Um eine solche Anwendung mithilfe eines Arrays zu implementieren, kann man ein sehr großes Array anlegen, dessen Größe garantiert ausreicht, um alle Elemente abzulegen.
Bei unserem Warenkorb-Beispiel gibt es dann aber eine Obergrenze.
Das heißt Nutzer\*innen können dann zum Beispiel nur `100` oder `1000` Gegenstände in den Warenkorb packen.
Es gibt aber noch einen gravierenderen Nachteil.
Wie wir zuvor gelernt haben, wird beim Anlegen eines solchen Arrays Speicher für das gesamte Array reserviert, auch wenn das Array gar nicht gefüllt wird.
Der reservierte Speicher kann von einem Programm nicht mehr genutzt werden.
Das heißt, wir verschwenden sehr viel Speicher.
Im schlechtesten Fall verbrauchen wir den gesamten zur Verfügung stehenden Speicher und das Programm stürzt ab.

Statt initial ein sehr großes Array anzulegen, können wir jedes Mal ein größeres Array anlegen, wenn die Größe des bestehenden Arrays nicht mehr ausreichend ist.
Wir kopieren die Elemente dann aus dem kleinen Array in das neue, größere Array und können anschließend neue Elemente einfügen.
Die Logik für diese Implementierung möchte man aber nicht in der eigentlichen Anwendungslogik haben, in der das Array genutzt wird.
Daher kapselt man diese Idee in einer Klasse.
Das heißt, in unserer Anwendung nutzen wir die Klasse und in der Implementierung der Klasse wird die Verwaltung des Arrays implementiert.
Es muss zum Beispiel gespeichert werden, wie viele Einträge noch in das Array passen und ein größeres Array angelegt werden, wenn der Platz nicht mehr ausreicht.
Im Abschnitt [ArrayListen](#arraylisten) diskutieren wir, wie eine solche Implementierung umgesetzt werden kann.

Listen
------

Wie ein Array erlaubt eine Liste das Speichern mehrerer Werte.
Im Unterschied zu einem Array können wir bei einer Liste aber Werte im Nachhinein hinzufügen oder aus der Liste entfernen.
Dabei entspricht das Entfernen nicht dem Setzen des Eintrages auf `null` sondern dem kompletten Entfernen aus der Struktur.

Es gibt verschiedene Implementierungen von Listen, die intern unterschiedlich implementiert sind, aber alle die gleichen Methoden zur Verfügung stellen.
Um über verschiedene Implementierungen zu sprechen, welche die gleichen Methoden zur Verfügung stellen, verwenden wir einen abstrakten Datentyp.
Ein abstrakter Datentyp (ADT) besteht aus einer Menge von Signaturen.
Eine Signatur ist dabei der Name einer Methode zusammen mit ihren Argumenttypen und ihrem Ergebnistyp.

Zusätzlich zu dieser Menge von Signaturen wird bei einem abstrakten Datentyp spezifiziert, wie sich die angegebenen Methoden verhalten.
Da wir die Implementierung der Methoden nicht kennen und uns auch nicht dafür interessieren, benötigen wir einen anderen Weg, um das Verhalten der Methoden abstrakt zu beschreiben.
In der Theorie werden diese Verhaltensregeln häufig in Form von Gleichungen angegeben, bei denen auf beiden Seiten der Gleichung Terme stehen, die die Operationen des abstrakten Datentyps verwenden.
In der Praxis wird die Spezifikation in der Regel in Form von umgangssprachlichen Kommentaren angegeben, die wir auch an dieser Stelle verwenden wollen.
Die Abbildung <a href="#figure:list-adt">Der abstrakte Datentyp Liste</a> zeigt einen abstrakten Datentyp für eine Liste und präsentiert alle Methoden, die wir im Folgenden betrachten werden.
Das heißt, eine Liste stellt normalerweise mindestens die Methoden in der Abbildung <a href="#list-adt">Der abstrakte Datentyp Liste</a> zur Verfügung.

<figure id="figure:list-adt" markdown="1">

| Signatur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |Beschreibung                                                                                               |
| :---------------------------- | :--------------------------------------------------------------------------------------------------------- |
| `boolean isEmpty()`           | Liefert genau dann `true`, wenn die Liste keine Elemente enthält.                                          |
| `int size()`                  | Liefert die Anzahl der Elemente in der Liste.                                                              |
| `T get(int index)`            | Liefert das Element an Index `index` der Liste.                                                   |
| `void add(int index, T elem)` | Fügt das Element `elem` am Index `index` in die Liste ein.                                                |
| `T remove(int index)`         | Entfernt das Element am Index `index` aus der Liste und liefert dieses Element zurück.                 |

<figcaption>Abbildung 1: Der abstrakte Datentyp Liste</figcaption>
</figure>

Die Elemente einer Liste sind mit null startend durchnummeriert.
Beim Hinzufügen kann man nur an validen Positionen ein Element in die Liste einfügen.
Hat die Liste *n* Elemente, so sind alle Indizes größer gleich null und kleiner gleich *n* valide Indizes.
Das heißt, bei einer Liste mit 3 Elementen, können neue Elemente an den Positionen 0, 1, 2 und 3 hinzugefügt werden.
Beim Entfernen eines Elementes aus einer Liste mit *n* Elementen sind nur die Indizes größer gleich null und kleiner als *n* valide Indizes.

<figure id="examples" markdown="1">
![add(1,"x")](/assets/graphics/example1.svg){: height="80px" .centered}
![add(3,"x")](/assets/graphics/example2.svg){: height="80px" .centered}
![remove(0)](/assets/graphics/example3.svg){: height="80px" .centered}
![remove(1)](/assets/graphics/example4.svg){: height="80px" .centered}
  <figcaption>Abbildung 2: Veränderung einer Liste durch Einfügen und Entfernen</figcaption>
</figure>

Bei mehreren Methoden in der <a href="#figure:list-adt">Abbildung 1</a> wird der Typ `T` verwendet.
`T` ist hier ein Platzhalter, der für den Typ der Elemente in der Liste steht.
Das heißt, wenn wir eine Liste mit Elementen vom Typ `Integer` betrachten, so steht das `T` für den Typ `Integer` und wenn wir eine Liste mit Elementen vom Typ `String` betrachten, so steht das `T` für den Typ `String`.
Wir werden später sehen, wie man diese Art von Platzhalter in Java modelliert.

Programmiersprachen stellen unterschiedliche Konzepte zur Verfügung, um einen abstrakten Datentyp zu implementieren.
In der Programmiersprache Java können wir die Signatur eines ADT zum Beispiel mithilfe eines Interface umsetzen.
Wir werden später aber auch noch Beispiele sehen, bei denen wir kein Interface für einen ADT definieren, da wir nur eine einzige Implementierung des ADT angeben und daher nicht die zusätzliche Abstraktion durch ein Interface benötigen.

``` java
interface List<T> {
    boolean isEmpty();

    int size();

    T get(int index);

    void add(int index, T elem);

    T remove(int index);
}
```

Neben den Methoden in <a href="#figure:list-adt">Abbildung 1</a> stellt eine Liste noch einen Konstruktor zur Verfügung, um eine leere Liste zu erzeugen.
Das folgende Programm zeigt beispielhaft die Verwendung einer Klasse `ArrayList`, die eine Liste implementiert.

``` java
var list = new ArrayList<String>();
list.add(0, "a");
list.add(1, "b");
list.add(2, "c");

var elem = list.remove(1);
```

In diesem Code-Schnipsel wird eine leere Liste erstellt und die Einträge `"a"`, `"b"` und `"c"` werden zur Liste hinzugefügt.
Am Ende wird noch das Element an Index `1` entfernt, so dass eine Liste mit den Einträgen `"a"` und `"c"` entsteht.
Die Methode `remove` entfernt ein Element aus der Liste und liefert den Eintrag als Ergebnis zurück.
Das heißt, die Variable `elem` enthält nach der Ausführung den `String` `"b"`.

Das `T` in der Definition des Interface `List` wird als Typparameter bezeichnet und ist ein Platzhalter für einen konkreten Typ.
Wenn wir das Interface verwenden, geben wir für dieses `T` einen konkreten Typ an.
In dem Code-Schnipsel oben übergeben wir zum Beispiel `String` als konkreten Typ.
Ähnlich wie bei normalen Parametern wird bei Typparametern jedes Vorkommen durch den konkreten Typ ersetzt.
Bei einer Liste gibt der Typ, den wir an das Interface `List` übergeben, an, welchen Typ die Elemente der Liste haben.
Der Typ `List<String>` ist zum Beispiel der Typ von Listen, deren Einträge Zeichenketten sind.
Der Typ `List<Integer>` ist dagegen der Typ von Listen, deren Einträge ganze Zahlen sind.
Wenn wir einen konkreten Typ an das Interface `List` übergeben, werden die Vorkommen von `T` in der Definition des Interface durch `String` ersetzt.
Das heißt, wenn wir eine Klasse vom Typ `List<String>` haben, dann liefert die entsprechende `get`-Methode einen Wert vom Typ `String` als Ergebnis, da das `T` durch `String` ersetzt wird.

### Arraylisten

Wir können die Methoden in <a href="#figure:list-adt">Abbildung 1</a> mithilfe eines Arrays implementieren.
Das heißt, wir können eine Klasse implementieren, die intern ein Array verwendet, um die Elemente einer Liste zu verwalten.
Da ein Array eine feste Anzahl von Elementen aufnimmt, eine Liste aber eine dynamische Anzahl, kann es beim Einfügen mithilfe der Methode `add` dazu kommen, dass der Platz im Array nicht mehr ausreicht, um das neue Element aufzunehmen.
In diesem Fall legen wir einfach ein größeres Array an und kopieren alle Elemente aus dem bisherigen Array in das neue, größere Array.

<figure id="figure:steps" markdown="1">
**1. Schritt**

![](/assets/graphics/step11.svg){: height="50px"}
![](/assets/graphics/step12.svg){: height="50px"}

**2. Schritt**

![](/assets/graphics/step21.svg){: height="80px"}
<!-- ![](/assets/graphics/step22.svg){: height="80px"} -->

**3. Schritt**

![](/assets/graphics/step3.svg){: height="80px"}
  <figcaption>Abbildung 3: Die drei Schritte einer Methode <code class="language-java">add(i, x)</code> in der Implementierung einer Liste mithilfe eines Arrays</figcaption>
</figure>

<a href="#figure:steps">Abbildung 3</a> illustriert die drei Schritte, die in der Methode `add` einer Listenimplementierung mithilfe eines Arrays durchführt werden.
Im ersten Schritt wird überprüft, ob noch freie Plätze im Array vorhanden sind.
Falls dies nicht der Fall ist, muss das Array vergrößert werden.
In beiden Fällen fahren wir mit dem eventuellen Verschieben von Elementen fort.
Im zweiten Schritt werden die Einträge im Array so verschoben, dass anschließend Platz für das neu einzufügende Element ist.
Nach dem Durchführen des ersten und zweiten Schrittes hat das Array ausreichend Platz und die Position, an der das Element eingefügt werden soll, ist frei.
Daher können wir das Element einfach an die freie Stelle schreiben.

### Einfach verkettete Listen

Statt die Methoden einer Liste mithilfe eines Arrays zu implementieren, können wir diese Methoden auch mithilfe von Objekten implementieren.
Wir betrachten zuerst die Implementierung einer Liste mithilfe einer **einfachen Verkettung**.
Man nennt eine solche Liste eine einfach verkettete Liste.
Eine Liste besteht dabei aus einer Menge von Knoten.
Jeder Knoten einer einfach verketteten Liste besteht aus zwei Informationen, dem Element und einer Referenz auf den nächsten Knoten.
<a href="#figure:sllist">Abbildung 4</a> illustriert die Struktur einer einfach verketteten Liste mit drei Elementen.

<figure id="figure:sllist" markdown="1">
![](/assets/graphics/sllist.svg){: height="120px" .centered }
  <figcaption>Abbildung 4: Eine einfach verkettete Liste mit den Elementen <code class="language-java">a</code>, <code class="language-java">b</code> und <code class="language-java">c</code></figcaption>
</figure>

Ein Knoten einer Liste enthält ein Element und eine Referenz auf den nächsten Knoten.
Der Typ des Elementes hängt dabei davon ab, welche Art von Elementen wir in einer Liste ablegen möchten. Wie es Arrays gibt, die Elemente vom Typ `Integer` enthalten und Arrays, die Elemente vom Typ `String` enthalten, so gibt es Listen, die Elemente vom Typ `Integer` enthalten und Listen, die Elemente vom Typ `String` enthalten.
Für eine Liste, die Elemente vom Typ `Integer` enthält, muss der entsprechende Knoten auch Elemente vom Typ `Integer` enthalten.
Für eine Liste, die Elemente vom Typ `String` enthält, muss der entsprechende Knoten auch Elemente vom Typ `String` enthalten.

Um auszudrücken, dass der Knoten Werte von verschiedenen Typen enthalten kann, verwenden wir eine **generische Klasse**.
Wir implementieren einen Knoten einer Liste mithilfe der folgenden Klasse.

``` java
final class Node<T> {
    private final T value;
    private Node<T> next;

    Node(T value, Node<T> next) {
        this.value = value;
        this.next = next;
    }

    T value() {
        return this.value;
    }

    Node<T> next() {
        return this.next;
    }

    void setNext(Node<T> next) {
        this.next = next;
    }
}
```

Die Klasse `Node<T>` ist eine sogenannte generische Klasse.
Das `T` in der Definition der Klasse `Node` bezeichnet man als **Typparameter**.
Bei der konkreten Verwendung der Klasse müssen wir für den Typparameter `T` einen Typ angeben.
Das heißt, bei einem Knoten vom Typ `Node<Integer>` hat das Attribut `value` den Typ `Integer`, während bei einem Knoten vom Typ `Node<String>` das Attribut `value` den Typ `String` hat.
Das heißt, wenn wir eine generische Klasse verwenden, müssen wir einen konkreten Typ für den Typparameter angeben und dann werden alle Vorkommen des Typparameters in der Klasse durch den konkreten Typ ersetzt.
Das heißt auch, dass bei einem Knoten vom Typ `Node<Integer>` das Attribut `next` den Typ `Node<Integer>` hat, da alle Vorkommen des Typparameters `T` durch den Typ `Integer` ersetzt werden.
Bei Typparametern gelten ähnlich wie bei normalen Variablen Sichtbarkeitsregeln.
Zum Beispiel, ist der Typparameter `T`, der in der Definition der Klasse `Node` eingeführt wird, in der gesamten Klasse sichtbar.
Es ist nicht nur möglich, Typparameter bei der Definition einer Klasse einzuführen, sondern auch bei der Definition einer Methode.

Eine einfach verkettete Liste ist ein Objekt vom Typ `SLList`.
Die Klasse hält eine Referenz auf den ersten Knoten, also auf ein Objekt vom Typ `Node`.
Im Folgenden implementieren wir auch gleich eine Methode `isEmpty`, die überprüft, ob die Liste leer ist.

``` java
public class SLList<T> {
    private Node<T> first;

    public SLList() {
        this.first = null;
    }

    public boolean isEmpty() {
        return this.first == null;
    }
}
```

Die generische Klasse `SLList<T>` implementiert eine einfach verkettete Liste.
Die Definition von generischen Typen wurde zur Programmiersprachen Java im Nachhinein hinzugefügt.
Aus Gründen der Abwärtskompatibilität wird der Typ der Elemente eines Arrays daher anders angegeben als der Typ der Elemente einer Liste.
Bereits vor der Einführung von generischen Typen konnten in der Programmiersprachen Java bereits verschiedene Typen von Arrays definiert werden.
Als die generischen Klassen zur Programmiersprache Java hinzugefügt wurden, wurde die bereits bestehende Schreibweise für die Arrays beibehalten.

Um die Methoden `get`, `add` und `remove` zu implementieren, implementieren wir eine Hilfsmethode, die das `Node`-Objekt an einer bestimmten Stelle in der Liste heraussucht.

``` java
private Node<T> nodeAt(int index) {
    var current = this.first;
    for (int i = 0; i < index; i++) {
        current = current.next();
    }
    return current;
}
```

Mithilfe dieser Methode können wir nun sehr einfach die Methoden `get` und `add` implementieren.
<a href="#figure:sllist-add">Abbildung 5</a> zeigt abstrakt das Vorgehen bei einem Aufruf `add(i, x)`.

<figure id="figure:sllist-add" markdown="1">
1\. Fall, `i = 0`

![](/assets/graphics/sllist-add1.svg){: width="740px" .centered}

2\. Fall, `i > 0`

![](/assets/graphics/sllist-add2.svg){: height="440px" .centered}
  <figcaption>Abbildung 5: Einfügen eines Elementes durch einen Aufruf <code class="language-java">add(i, x)</code></figcaption>
</figure>

Die Methode `get` ruft einfach die Methode `nodeAt` auf und selektiert aus dem erhaltenen Knoten den Wert.

``` java
public T get(int index) {
    return nodeAt(index).value();
}
```

Die Implementierung der Methode `add` ist eine Umsetzung von <a href="#figure:sllist-add">Abbildung 5</a>.
Wir haben bei der Implementierung einer Methode immer mehrere Möglichkeiten, zum Beispiel könnten wir in der Methode `add` mehr Hilfsvariablen einführen.
Zum Beispiel könnten wir den neu erzeugten Knoten in Zeile 6 erst einmal in einer Variable speichern, bevor wir den Knoten an die Methode `setNext` übergeben.
Im Kontext dieser Vorlesung werden wir versuchen, in vielen Fällen auf solche Hilfsvariablen zu verzichten.
Auf diese Weise soll ein tieferes Verständnis dafür vermittelt werden, wie man in einer Programmiersprache Aufrufe schachteln kann.

``` java
public void add(int index, T elem) {
    if (index <= 0) {
        this.first = new Node<T>(elem, this.first);
    } else {
        var pred = nodeAt(index - 1);
        pred.setNext(new Node<T>(elem, pred.next()));
    }
}
```

Queues und Stacks
-----------------

Als nächstes wollen wir uns anschauen, wie wir eine Methode `add(T)`[^1] zu unserer Implementierung einer einfach verketteten Liste hinzufügen können.
Diese Methode fügt ein Element am Ende einer Liste an.

``` java
public void add(T elem) {
    var node = new Node<T>(elem, null);
    if (this.first == null) {
        this.first = node;
    } else {
        var current = this.first;
        while (current.next() != null) {
            current = current.next();
        }
        current.setNext(node);
    }
}
```

Um am Ende der Liste ein Element anzufügen, müssen wir die gesamte Liste durchlaufen.
Das Durchlaufen der Liste kostet unter Umständen viel Zeit und kann relativ einfach verhindert werden.
Wir können uns einfach neben der Referenz auf den Kopf der Liste noch eine Referenz auf das Ende der Liste merken.
Für ein gutes Verständnis der Implementierung von Datenstrukturen ist es unerlässlich, zu verstehen, wann eine Programmiersprache eine Berechnung ausführt.

Im Zusammenhang der Methode `add(T)` wollen wir uns noch einen weiteren abstrakten Datentyp anschauen.
<a href="#figure:queue-adt">Abbildung 6</a> zeigt den abstrakten Datentyp Queue.
Die Queue ist dabei parametrisiert über dem Typ `T` der Elemente der Queue.
Eine **Queue (Warteschlange)** ist eine Container-Datenstruktur, die, ähnlich einem Array oder einer Liste, mehrere Werte zusammenfasst.
Eine Queue arbeitet nach dem sogenannten **FIFO-Prinzip (first in, first out)**.
Dieses Prinzip besagt, dass man als nächstes Element aus der Schlange das Element erhält, das zuerst zur Schlange hinzugefügt wurde.
Das heißt, eine Queue funktioniert — wie der Name schon sagt — genau wie eine Personenwarteschlange.

<figure id="figure:queue-adt" markdown="1">

| Signatur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |Beschreibung                                                                               |
| :------------------ | :--------------------------------------------------------------------------------- |
| `boolean isEmpty()` | Liefert genau dann `true`, wenn die Queue keine Elemente enthält.                  |
| `void add(T elem)`     | Fügt das Element `elem` am Ende der `Queue` an.                                       |
| `T remove()`        | Entfernt das erste Element der `Queue` und liefert dieses Element zurück.          |

<figcaption>Abbildung 6: Der abstrakte Datentyp Queue</figcaption>
</figure>

Wir verwenden an dieser Stelle die Namen der Methoden, die Java verwendet.
Die Methode `add` ist in der Literatur eher unter dem Namen `enqueue` und die Methode `remove` eher unter dem Namen `dequeue` bekannt.
Im Folgenden implementieren wir die Methoden des abstrakten Datentyps Queue mithilfe einer einfachen Verkettung.
Wir implementieren die folgende Klasse.

``` java
public class Queue<T> {
    private Node<T> first;
    private Node<T> last;

    public Queue() {
        this.first = null;
        this.last = null;
    }
}
```

Mithilfe der Referenz `last` können wir die Methode `add`, die am Ende der Verkettung anfügt, wie folgt implementieren.

``` java
public void add(T elem) {
    var node = new Node<T>(elem, null);
    if (this.last == null) {
        this.first = node;
    } else {
        this.last.setNext(node);
    }
    this.last = node;
}
```

Wir müssen jetzt nicht mehr durch alle Knoten laufen, um den letzten Knoten zu suchen.

Die Methode `remove` kann wie folgt implementiert werden.

``` java
public T remove() {
    var value = this.first.value();
    if (this.first.next() == null) {
        this.last = null;
    }
    this.first = this.first.next();
    return value;
}
```

Neben der Datenstruktur Queue gibt es noch eine Struktur namens Stack.
Ein **Stack (Stapel)** ist eine Container-Datenstruktur, die nach dem **LIFO-Prinzip (last in, first out)** funktioniert.
Dieses Prinzip besagt, dass man als nächstes Element vom Stapel, das Element erhält, das zuletzt zum Stapel hinzugefügt wurde.
Das heißt, ein Stack funktioniert — wie der Name schon sagt — genau wie ein Ablagestapel.
Der Stack ist eine sehr wichtige Datenstruktur.
Zum Beispiel wird bei der Ausführung eines Methodenaufrufs in einer Programmiersprache ein Stack verwendet.
Dieser Stack wird genutzt, um Informationen an die aufgerufene Methode zu übergeben und nach Abarbeitung einer Methode zu wissen, welcher Teil eines Programms nach der Rückkehr aus einem Methodenaufruf ausgeführt werden soll.
Wir werden bei der Diskussion von Rekursion sehen, warum man zur Ausführung einer Methode einen Stack verwendet.

<a href="#figure:stack-adt">Abbildung 7</a> zeigt den abstrakten Datentyp Stack.
Wir können diesen einfach mithilfe einer einfachen Verkettung implementieren und benötigen dabei nur die Referenz auf das erste Element.

<figure id="figure:stack-adt" markdown="1">

| Signatur&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |Beschreibung                                                                                   |
| :------------------ | :--------------------------------------------------------------------------------- |
| `boolean isEmpty()` | Liefert genau dann `true`, wenn der Stack keine Elemente enthält.                  |
| `void push(T elem)`    | Packt das Element `elem` auf den Stapel.                 |
| `T pop()`           | Nimmt das oberste Element vom Stapel und liefert dieses Element zurück.|

<figcaption>Abbildung 7: Der abstrakte Datentyp Stack</figcaption>
</figure>

Doppelt verkettete Listen
-------------------------

Java stellt eine Klasse `LinkedList` im Paket `java.util` zur Verfügung.
Die Implementierung der Klasse `LinkedList<T>` funktioniert sehr ähnlich wie die Klasse `SLList<T>`, die wir implementiert haben.
Im Gegensatz zu unserer Implementierung, verwendet die Java-Implementierung aber eine **doppelte Verkettung**.
Wir wollen uns im Folgenden anschauen, wie eine doppelte Verkettung funktioniert.

Wir haben gesehen, dass wir das Hinzufügen eines Elementes am Ende verbessern können, indem wir neben einer Referenz auf den Anfang der Liste noch eine Referenz auf das Ende der Liste speichern. Diese Optimierung hilft leider beim Entfernen eines Elementes am Ende der Liste nicht weiter.
Um ein Element am Ende der Liste zu entfernen, benötigen wir eine Möglichkeit, an das vorletzte Element zu gelangen.
<a href="#figure:dllist">Abbildung 8</a> zeigt die Struktur einer doppelten Verkettung, die dieses Problem löst.

<figure id="figure:dllist" markdown="1">
![](/assets/graphics/dllist.svg){: height="120px" .centered }
  <figcaption>Abbildung 8: Eine doppelt verkettete Liste mit den Elementen <code class="language-java">a</code>, <code class="language-java">b</code> und <code class="language-java">c</code></figcaption>
</figure>

Im Vergleich zu einer einfach verketteten Liste, hat bei einer doppelt verketteten Liste jedes Element neben einer Referenz auf seinen Nachfolger noch eine Referenz auf seinen Vorgänger.
Das heißt, zusätzlich zum Element und der Referenz auf das nächste `Node`-Objekt enthält ein Knoten in einer doppelten Verkettung noch eine Referenz auf den Vorgänger-Knoten.
Die folgende Klasse implementiert ein Knoten-Objekt für eine doppelte Verkettung.

``` java
final class DLNode<T> {
    private final T value;
    private DLNode<T> prev;
    private DLNode<T> next;

    DLNode(DLNode<T> prev, T value, DLNode<T> next) {
        this.value = value;
        this.prev = prev;
        this.next = next;
    }

    T value() {
        return this.value;
    }

    DLNode<T> prev() {
        return this.prev;
    }

    void setPrev(DLNode<T> prev) {
        this.prev = prev;
    }

    DLNode<T> next() {
        return this.next;
    }

    void setNext(DLNode<T> next) {
        this.next = next;
    }
}
```

Die Liste selbst besteht dann aus einer Referenz auf den ersten und den letzten Knoten der Liste. Wenn wir ein Element im vorderen Teil der Liste einfügen wollen, ist es sinnvoll, von vorne zu diesem Element zu laufen.
Wollen wir am hinteren Ende einfügen, so ist es sinnvoll, vom hinteren Ende zum gesuchten Element zu laufen.
Um diese Entscheidung treffen zu können, führen wir die Größe der Liste ein.
Zu diesem Zweck erweitern wir die Klasse um ein Feld `size`, das die aktuelle Größe einer Liste vorhält.

``` java
public class DLList<T> {
    private DLNode<T> first;
    private DLNode<T> last;
    private int size;

    public DLList() {
        this.first = null;
        this.last = null;
        this.size = 0;
    }
}
```

<a href="#figure:doubly-linked-list-add">Abbildung 9</a> zeigt die Idee der Implementierung einer doppelt verketteten Liste.

<figure id="figure:doubly-linked-list-add" markdown="1">
1\. Fall, `i = 0` und `size = 0`

![](/assets/graphics/dllist-add1.svg){: width="700px" .centered}

2\. Fall, `i = 0` und `size > 0`

![](/assets/graphics/dllist-add2.svg){: width="740px" .centered}

3\. Fall, `i > 0` und `i = size`

![](/assets/graphics/dllist-add3.svg){: width="740px" .centered}

4\. Fall, `i > 0` und `i < size`

![](/assets/graphics/dllist-add4.svg){: height="380px" .centered}
  <figcaption>Abbildung 9: Einfügen eines Elementes in einer doppelt verketteten Liste durch einen Aufruf <code class="language-java">add(i, x)</code></figcaption>
</figure>

Listen in Java
--------------

Java stellt das Interface `List<T>` im Paket `java.util` zur Verfügung.
Das Interface `List<T>` bietet eine ganze Reihe von Methoden, unter anderem alle Methoden des abstrakten Datentyps in <a href="#figure:list-adt">Abbildung 1</a>.
Das von Java definierte Interface bietet aber noch wesentlich mehr Methoden.
Java stellt in `java.util` außerdem Implementierungen `ArrayList<T>` und `LinkedList<T>` des Interfaces zur Verfügung.
Die Klasse `ArrayList` implementiert das Interface `List`, wie der Name schon sagt, mithilfe eines Arrays.
Die Klasse `LinkedList` implementiert das Interface `List` mithilfe einer doppelten Verkettung.

Neben dem Interface `List<T>` bietet Java auch ein Interface `Queue<T>`.
Die Klasse `LinkedList` implementiert zum Beispiel das Interface `Queue`.
Daneben stellt Java auch noch ein Interface `Deque` zur Verfügung.
Das Wort **Deque** ist eine Kurzform von **_double ended queue_**.
Das heißt, bei einem Deque handelt es sich um eine Queue, bei der man an beiden Enden hinzufügen und entfernen kann.
Da man bei einer doppelt verketteten Liste effizient vorne und hinten hinzufügen und entfernen kann, implementiert die Klasse `LinkedList` das Interface `Deque`.
Neben diesen Interfaces stellt Java noch eine generische Klasse `Stack` zur Verfügung, welche die Methoden `push` und `pop` zur Verfügung stellt.
In der Beschreibung dieser Klasse wird allerdings darauf hingewiesen, dass das Interface `Deque` eine umfangreichere Menge von Stack-Operationen zur Verfügung stellt.
Da man bei einem Deque effizient vorne und hinten hinzufügen und entfernen kann, kann man diese Struktur sowohl als Stack als auch als Queue nutzen.

[^1]: Bei überladenen Methoden kann mithilfe des Namens nicht eindeutig eine Methode referenziert werden. Daher geben wir neben dem Namen der Methode noch die Typen der Argumente an. Diese beiden Informationen zusammen erlauben es, eine Methode in Java eindeutig zu identifizieren.

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="introduction.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"><a href="complexity.html">weiter</a></li>
    </ul>
</div>
