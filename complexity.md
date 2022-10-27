---
layout: post
title: "Komplexität"
mathjax: true
---

Zur Beschreibung des Aufwandes eines Algorithmus werden häufig zwei Kennzahlen betrachtet, die Laufzeit des Algorithmus und sein Speicherverbrauch.
Wir werden uns hier vor allem mit der Laufzeit beschäftigen.
Bei der Komplexität wird dabei eine abstrakte Einheit zur Beschreibung dieser Kennzahlen verwendet und nicht die tatsächlich verbrauchte Zeit oder der tatsächlich verbrauchte Speicher.
So wird für die Laufzeit etwa angenommen, dass bestimmte Operationen, wie zum Beispiel das Vergleichen von zwei Zahlen oder die Berechnung einer arithmetischen Operation **eine Zeiteinheit/einen Schritt** in Anspruch nehmen.
Auf diese Weise verliert man natürlich Genauigkeit, da der Algorithmus je nach tatsächlichem Aufwand schneller oder langsamer ausgeführt wird, man erhält aber eine Vergleichbarkeit verschiedener Algorithmen unabhängig von ihrer konkreten Umsetzung in einer bestimmten Programmiersprache oder einer bestimmten Rechnerarchitektur.

Die Komplexität eines Algorithmus wird dabei in der Größe der Eingabedaten ausgedrückt.
So wird das Suchen eines Wertes in einer Liste zum Beispiel je mehr Zeit in Anspruch nehmen, desto mehr Elemente die Liste hat.
Formal wird die Komplexität durch eine Funktion ausdrückt, die die Größe der Eingabe als Argument erhält und als Ergebnis die Anzahl der benötigten Schritte liefert.
Dabei hängt es vom betrachteten Problem ab, wie "die Größe der Eingabe" definiert ist.
Bei der Suche eines Elementes in einer Liste bietet sich zum Beispiel die Länge der Liste an.
Man muss für jedes Problem aber einzeln bestimmen, welchen Begriff von Größe man verwendet.

In den meisten Fällen betrachtet man die *worst case*-Laufzeit eines Algorithmus.
Das heißt, man betrachtet, wie viele Schritte die Ausführung im schlechtesten Fall — also bei der ungünstigsten Eingabe — benötigt.
Dabei ist aber zu beachten, dass die Größe der Eingabe nicht verändert werden kann.
Das heißt, man betrachtet unter allen Eingaben einer festen Größe die Eingabe mit der ungünstigsten Struktur.
Es ist sinnvoll, den schlechtesten Fall zu betrachten, da man dann mit Sicherheit weiß, dass die Ausführung des Algorithmus zu einem bestimmten Zeitpunkt beendet sein wird, und zwar unabhängig von der konkreten Eingabe.

Neben dem *worst case* werden in der Komplexitätstheorie noch häufig der *best case* und der *average case* betrachtet.
Der *average case* betrachtet dabei die Anzahl der Schritte, die, gemittelt über alle möglichen Eingaben, benötigt werden.
Zum Beispiel gibt es Algorithmen, die im schlechtesten Fall zwar sehr schlecht sind, deren schlechtester Fall in der Praxis aber sehr selten auftritt.
Ein Beispiel für einen solchen Algorithmus ist Quicksort, der zum Sortieren von Sequenzen genutzt wird.
Die *best case*-Laufzeit beschreibt, wie viele Schritte der Algorithmus im besten Fall benötigt.
Beim Suchen eines Elementes in einer Liste könnte die beste Laufzeit zum Beispiel auftreten, wenn gleich das erste Element der Liste das gesuchte Element ist.
Die *best case*-Laufzeit hat die geringste Bedeutung, da man auf diese Weise wenig über das allgemeine Verhalten eines Algorithmus aussagen kann.

Konkrete Laufzeiten
-------------------

Im Folgenden werden wir uns die Zeit-Komplexität einiger Methoden auf linearen Datenstrukturen anschauen.

### Arrays

Wir haben bereits gesehen, dass der Zugriff auf ein Element eines Arrays mit Hilfe einer einfachen Rechnung umgesetzt werden kann.
In der Komplexitätstheorie nimmt man an, dass jede arithmetische Operation einen Schritt benötigt.
Wir betrachten die folgende Methode der Klasse `ArrayList`.

``` java
public T get(int index) {
    return (T) array[index];
}
```

Wir beschreiben die Laufzeit dieser Methode als Funktion, deren Eingabe die Größe des Arrays ist.
Der Zugriff auf das Element wird intern mit Hilfe einer Multiplikation und einer Addition umgesetzt.
Das heißt, die folgende Funktion beschreibt die Laufzeit dieser Methode.
$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}, T_{\texttt{get}}(x) = 2$$
In diesem Beispiel kann noch erwähnt werden, dass sich bei der Methode `get` der `ArrayList` die *best case*- und *worst case*-Laufzeit nicht unterscheiden.
Unabhängig davon, wie die Liste aussieht und welchen Index wir suchen, benötigt die Methode immer zwei Schritte.

### Einfach verkettete Listen

Zum Vergleich wollen wir uns die Laufzeit der Methode `get` einer einfach verketteten Liste anschauen.
Wir wollen also wissen, wie viele Schritte die Methode `get` bei verschiedenen Eingabegrößen benötigt.
Dazu schauen wir uns noch einmal die Implementierung dieser Methode an.

``` java
public T get(int index) {
    return nodeAt(index).value;
}
```

Die Methode ist mit Hilfe der Methode `nodeAt` implementiert, wir müssen uns also anschauen, wie diese Methode implementiert ist.

``` java
private Node<T> nodeAt(int index) {
    var current = this.first;
    for (int i = 0; i < index; i++) {
        current = current.next;
    }
    return current;
}
```

Wir hatten erwähnt, dass *best case*-, *average case*- und *worst case*-Laufzeiten betrachtet werden.
Wir wollen uns in diesem Fall die *worst case*-Laufzeit der Methode `get` anschauen.
Der *worst case* der Methode `get` tritt ein, wenn die Methode mit dem letzten Index, also *n* − 1 &mdash; wenn *n* die Länge der Liste ist &mdash; aufgerufen wird.

Wir können bei einer solchen Methode jetzt einfach analysieren, wie viele primitive Operationen durchgeführt werden.
Wir schauen uns dazu einmal die Methode `nodeAt` genauer an.
Jeder Aufruf der Methode initialisiert die Variable `current` und weist ihr das Attribut `this.first` zu.
Außerdem initialisiert jeder Aufruf die Variable `i`.
Wie viele Operationen durch die Schleife durchgeführt werden, hängt von der Größe des Index ab.
Wir wollen uns die *worst case*-Laufzeit anschauen, daher hat der Index den Wert *n* − 1.
Dadurch macht die Schleife *n* − 1 Durchläufe. Bei jedem Schleifendurchlauf muss die Bedingung `i <= index` überprüft und der Zähler `i` erhöht werden.
Außerdem wird bei jedem Schleifendurchlauf der Rumpf der Schleife ausgeführt, also `current = current.next`. Nach der Schleife muss unabhängig von der Anzahl der Durchläufe immer noch einmal der Vergleich `i < index` durchgeführt werden, der in diesem Fall aber fehlschlägt. Außerdem wird das `return` ausgeführt.

An dieser Stelle ist nicht relevant, wie viele Schritte die einzelnen Operationen, wie eine Zuweisung genau benötigen, es geht nur darum, dass es grundsätzlich möglich ist, die Schritte einfach zu zählen.
Wir werden im Folgenden sehen, dass eine so genaue Analyse gar nicht notwendig ist.
Wir stellen uns trotzdem einmal vor, dass wir die Analyse durchgeführt haben und die folgende Funktion die Anzahl der Schritte der Methode `nodeAt` beschreibt.

$$T_{\texttt{nodeAt}} : \mathbb{N} \rightarrow \mathbb{R}, T_{\texttt{nodeAt}}(x) = 5 x - 1$$

Da die Methode `get` noch einen zusätzlichen Methodenaufruf durchführt
und auf ein Attribut zugreift, erhalten wir insgesamt folgende Laufzeit.

$$T_{\texttt{get}}(x) = T_{\texttt{nodeAt}}(x) + 2 = 5 x + 1$$

Wir haben am Unterschied zwischen den Laufzeiten der Methoden `get` und `nodeAt` eigentlich kein großes Interesse.
Wenn die Eingabe sehr groß ist, ist der Unterschied zwischen diesen beiden Methoden verschwindend gering.
Bei einer Liste mit 10.000 Elementen benötigt `nodeAt` zum Beispiel 49.999 Schritte, während `get` 50.001 Schritte benötigt.
Im Gegensatz dazu sind wir am Unterschied zwischen der Methode `get` auf einer einfach verketteten Liste und der Methode `get` auf einer `ArrayList` aber sehr wohl interessiert.
So benötigt die Methode auf der einfach verketteten Liste bei einer Liste mit 10.000 Elementen 50.001 Schritte, die Methode auf einer `ArrayList` aber nur 2 Schritte.
Das heißt, wir wollen bestimmte Arten von Unterschieden zwischen Funktionen vernachlässigen, während wir andere weiterhin unterscheiden möchten. Mit Hilfe von asymptotischen Laufzeiten wird die Klassifikation, die wir uns wünschen, vorgenommen.

Asymptotisches Wachstum
-----------------------

Wir haben motiviert, dass wir bei der Betrachtung der Komplexität bestimmte Funktionen nicht unterscheiden, also als gleich auffassen, möchten.
Bevor wir eine formale Definition hierfür angeben, wollen wir noch kurz motivieren, dass wir auch in anderer Hinsicht bestimmte Funktionen als gleich auffassen wollen.
Wir stellen uns einmal vor, dass wir eine Laufzeit betrachten, die wie folgt definiert ist.

$$T_{\texttt{method1}}(x) = \begin{cases}
  2,     & \text{falls}~x < 10\\
  3 x,  & \text{sonst}
\end{cases}$$

Wir wollen eine solche Funktion nicht von einer Funktion unterscheiden, die immer 3*x* Schritte benötigt.
Auf der anderen Seite wollen wir eine Funktion der Form

$$T_{\texttt{method2}}(x) = \begin{cases}
  3 x,  & \text{falls}~x < 10\\
  2,     & \text{sonst}
\end{cases}$$

nicht von einer Funktion unterscheiden, die immer 2 Schritte benötigt, sehr wohl aber von einer Funktion, die immer 3*x* Schritte benötigt.
Die folgende Definition erfüllt alle Anforderungen, die wir uns bisher erarbeitet haben.

#### Definition 1 (Asymptotisch kleiner gleich)

Wir definieren eine Relation $$<_{as}$$ mit der wir Funktionen vergleichen können.
Für zwei Funktionen $$f, g : \mathbb{N} \rightarrow \mathbb{R}$$ definieren wir, dass *f* genau dann asymptotisch kleiner gleich *g* ist ($$f <_{as} g$$), wenn die folgende Bedingung erfüllt ist.

$$\exists c \in \mathbb{R}: c > 0 \wedge \exists n_0 \in \mathbb{N} : \forall n \in \mathbb{N}: n \geq n_0 \Rightarrow f(n) \leq c \cdot g(n)$$

In Worten gesprochen ist eine Abbildung *f* asymptotisch kleiner gleich einer Abbildung *g*, falls es ein Argument *n*<sub>0</sub> gibt, ab dem das Ergebnis von *g* (multipliziert mit einem Faktor *c*) immer größer gleich dem Ergebnis von *f* ist.
Den Faktor *c* müssen wir allerdings ganz zu Anfang wählen.
Das heißt, der Wert, den wir für *c* wählen kann weder von *n*<sub>0</sub> abhängen, noch von dem *n*, das wir uns anschauen.

<a href="#figure:o-notation">Abbildung 1</a> veranschaulicht, wann eine Funktion *f* asymptotisch kleiner gleich einer Funktion *g* ist.

<figure id="figure:o-notation" markdown="1">
  ![](/assets/graphics/o-notation.svg){: width="600px" .centered}
  <figcaption>Abbildung 1: Die Funktion <em>f</em> ist asymptotisch kleiner gleich der Funktion <em>g</em></figcaption>
</figure>

<a href="#figure:constant-factor">Abbildung 2</a> veranschaulicht den Einfluss des Faktors *c*, der auch als konstanter Faktor bezeichnet wird.

<figure id="figure:constant-factor" markdown="1">
  ![](/assets/graphics/constant-factor.svg){: width="400px" .centered}
  <figcaption>Abbildung 2: Verschiedene konstante Faktoren</figcaption>
</figure>

Um zu zeigen, dass eine konkrete Funktion asymptotisch kleiner gleich einer anderen konkreten Funktion ist, müssen wir einen Beweis führen.
In diesen Beweisen nutzen wir die folgenden Eigenschaften von $$\le$$ auf reelen Zahlen.

$$\begin{align}
% k \> 0 \wedge m \< n & \Rightarrow k \cdot m \< k \cdot n \label{eq1}\\\\
% m \< n   & \Rightarrow k + m \< k + n \label{eq2}\\\\
& \forall k, m, n \in \mathbb{R}: & k \ge 0 \wedge m \le n & \Rightarrow k \cdot m \le k \cdot n \tag{1}\label{eq:eq3}\\
& \forall k, m, n \in \mathbb{R}: & m \le n                & \Rightarrow k + m \le k + n \tag{2}\label{eq:eq4}
\end{align}$$

#### Beispiel 1 (Lineares und quadratisches Wachstum (Beweis))

Wir betrachten die Funktionen $$l : \mathbb{N} \rightarrow \mathbb{R}, l(x) = x$$ und
$$q : \mathbb{N} \rightarrow \mathbb{R}, q(x) = x^2$$. Wir wollen beweisen, dass
$$l \le_{as} q$$ gilt.

Setze *c* = 1.
Setze *n*<sub>0</sub> = 1.
Sei *n* ∈ ℕ mit *n* ≥ *n*<sub>0</sub>.
Dann gilt

$$\begin{align*}
l(n) & = n && \text{$1$ ist neutrales Element bezüglich $\cdot$}\\
     & = n \cdot 1 && \text{Regel (\ref{eq:eq3}), $n \ge 0 \wedge 1 \le n$}\\
     & \le n \cdot n && \text{$1$ ist neutrales Element bezüglich $\cdot$}\\
     & = 1 \cdot n^2 && \text{$c = 1$}\\
     & = c \cdot n^2\\
     & = c \cdot q(n)
\end{align*}$$

Dies zeigt, dass $$l \le_{as} q$$ gilt.

<figure id="figure:linear-quadratic">
<div class="centered" style="width:100%;" markdown="1">
![](/assets/graphics/linear-function.svg){: width="365px"}
![](/assets/graphics/quadratic-function.svg){: width="365px"}
</div>
<figcaption>Abbildung 3: Lineares und quadratisches Wachstum</figcaption>
</figure>

<a href="#figure:linear-quadratic">Abbildung 3</a> illustriert diese Aussage. Wir sehen, dass die Funktion *q* ab der Stelle *n*<sub>0</sub> = 1 immer oberhalb von *l* liegt.
<a href="#figure:linear-quadratic">Abbildung 3</a> illustriert außerdem an den Beispielen von *c* = 2 und *c* = 3, dass $$q \not \le_{as} l$$, da die Funktion *q*(*x*) die Funktion *c* ⋅ *l*(*x*) für jedes *c*
immer irgendwann “überholt”.
Wir werden hier nicht formal beweisen, dass eine Funktion nicht asymptotisch kleiner gleich einer anderen Funktion ist.
Wir werden stattdessen nur für bestimmte Klassen von Funktionen lernen, dass sie nicht asymptotisch kleiner gleich einer anderen Klasse von Funktionen sind.
Um zu beweisen, dass die Funktion _q_ nicht asymptotisch kleiner gleich der Funktion _l_ ist, müssten wir die logische Aussage in der Definition von $$\le_{as}$$ negieren und einen Beweis für diese negierte Formel führen.

<a href="#figure:growth">Abbildung 4</a> vermittelt einen Eindruck darüber, wie unterschiedliche Funktionen wachsen.
Die Wachstumsfunktionen *f*(*x*) = 1, *f*(*x*) = *x*, *f*(*x*) = *x*<sup>2</sup>, *f*(*x*) = *x*<sup>3</sup>, *f*(*x*) = *x*<sup>4</sup> und *f*(*x*) = 2<sup>*x*</sup> werden als konstantes, lineares, quadratisches, kubisches, biquadratisches bzw. exponentielles Wachstum bezeichnet.
In der Praxis ist ein Wachstum über quadratischem tatsächlich kaum tolerierbar.
Dagegen wird bei *f*(*x*) = *x*log *x* auch von quasilinearem Wachstum gesprochen, da der zusätzliche logarithmische Faktor kaum ins Gewicht fällt.
<a href="#figure:growth">Abbildung 4</a> erweckt unter Umständen den Eindruck, dass *n*<sup>4</sup> schneller wächst als 2<sup>*n*</sup>.
Dies ist aber nicht der Fall, so gilt zum Beispiel 16<sup>4</sup> = 65.536 und 2<sup>16</sup> = 65.536, aber 17<sup>4</sup> = 83.521 und 2<sup>17</sup> = 131.072.
Außerdem gilt 100<sup>4</sup> = 100.000.000, aber 2<sup>100</sup> = 1.267.650.600.228.229.401.496.703.205.376
Insbesondere gilt für jede Funktion der Form *f*(*x*) = *x*<sup>*p*</sup>, wobei *p* eine natürliche Zahl ist, dass *e*(*x*) = 2<sup>*x*</sup> schneller wächst als das Polynom.
Anders ausgedrückt gilt für jedes Polynom $$p$$ die Aussage $$p \le_{as} e$$ und $$e \not \le_{as} p$$.

<a href="#figure:runtimes">Abbildung 4</a> illustriert die verschiedenen Wachstumsfunktionen noch einmal, indem angenommen wird, dass ein Schritt 1 μs Zeit in Anspruch nimmt.
Auf diese Weise kann man für die verschiedenen Wachstumsfunktionen berechnen, wie der Algorithmus jeweils zur Ausführung benötigt.

<figure id="figure:runtimes" markdown="1">

| f(x) =              | x = 10       | x = 20       | x = 30       | x = 40       |
|---------------------|-------------:|-------------:|-------------:|-------------:|
| x                   | 10 &micro;s  | 20 &micro;s  | 30 &micro;s  | 40 &micro;s  |
| 100 ⋅ x             | 1 ms         | 2 ms         | 3 ms         | 4 ms         |
| x log(x)            | 23 &micro;s  | 60 &micro;s  | 102 &micro;s | 148 &micro;s |
| x<sup>2</sup>       | 100 &micro;s | 400 &micro;s | 900 &micro;s | 1,6 ms       |
| 100 ⋅ x<sup>2</sup> | 10 ms        | 40 ms        | 90 ms        | 160 ms       |
| x<sup>3</sup>       | 1 ms         | 8 ms         | 27 ms        | 64 ms        |
| x<sup>4</sup>       | 10 ms        | 160 ms       | 810 ms       | 2,6 s        |
| 2<sup>x</sup>       | 1 ms         | 1 s          | 17,8 min     | 12,7 d       |
| x!                  | 3,6 s        | 77.164 y     | 8 ⋅ 10<sup>18</sup> y       |

<figcaption>Abbildung 4: Laufzeiten für verschiedene Wachstumsfunktionen (1 Schritt = 1 μs)</figcaption>
</figure>

#### Beispiel 2 (ArrayList)

Wir betrachten die Methode `get` der Klasse `ArrayList`.
Wir haben festgestellt, dass die folgende Funktion die Anzahl der Schritte der Funktion beschreibt.

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}, T_{\texttt{get}}(x) = 2$$

Wir betrachten die Funktion $$k : \mathbb{N} \rightarrow \mathbb{R}, k(x) = 1$$.
Es gilt $$T_{\texttt{get}} \le_{as} k$$.
Außerdem gilt $$k \le_{as} T_{\texttt{get}}$$.
Das heißt, die Funktionen $$T_{\texttt{get}}$$ und $$k$$ wachsen gleich schnell.

#### Beispiel 3 (Einfach verkettete Listen)

Wir betrachten die Methode `get` einer einfach verketteten Liste.
Wir haben festgestellt, dass die folgende Funktion die Anzahl der Schritte dieser Methode angibt.

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}, T_{\texttt{get}}(x) = 5 n + 1$$

Wir betrachten die Funktion $$l : \mathbb{N} \rightarrow \mathbb{R}, l(x) = x$$.
Es gilt $$T_{\texttt{get}} \le_{as} l$$.
Außerdem gilt $$l \le_{as} T_{\texttt{get}}$$.
Für $$k : \mathbb{N} \rightarrow \mathbb{R}, k(x) = 1$$
gilt $$T_{\texttt{get}} \not \le_{as} k$$.
Es gilt allerdings $$k \le_{as} T_{\texttt{get}}$$.
Das heißt $$T_{\texttt{get}}$$ wächst schneller als $$k$$.

Größenordnungen
---------------

Eine Größenordnung ist eine Menge von Funktionen, die — bis auf eine gewisse Abweichung — alle ähnlich schnell wachsen.
Wir führen dafür die $$\mathcal{O}$$-Notation ein, mit deren Hilfe man eine Größenordnung beschreiben kann.

#### Definition 2 (Asymptotisch obere Schranke)

Wir definieren

$$\mathcal{O}(f) := \{ g: \mathbb{N} \rightarrow \mathbb{R} \mid g \le_{as} f \}.$$

Das heißt, in der Menge $$\mathcal{O}(f)$$ sind die Funktionen, die höchstens so schnell wachsen wie die Funktion $$f$$.
An Stelle einer Abbildung verwendet man für $$f$$ häufig den Funktionswert der Funktion.
Das heißt, anstelle von “für $$f(n) = n$$ und $$g(n) = n^2$$ gilt $$f \in \mathcal{O}(g)$$”, schreibt man häufig “$$f \in \mathcal{O}(n^2)$$”.
Bei beiden Varianten sollte man immer angeben, welchen Wert die Variable $$n$$ darstellt, also was in dem jeweiligen Fall "die Größe der Eingabe" ist.
Im Fall von Listen wäre dies etwa die Länge der Liste.

Wir betrachten wieder die Methode `get` einer ArrayList.
In <a href="#beispiel-2-arraylist">Beispiel 2</a> haben wir bereits gesehen, dass für $$k : \mathbb{N} \rightarrow \mathbb{R}, k(x) = 1$$ die Aussage $$T_{\texttt{get}} \le_{as} k$$ gilt.
Also gilt auch $$T_{\texttt{get}} \in \mathcal{O}(k)$$ und wir schreiben dafür auch $$T_{\texttt{get}} \in \mathcal{O}(1)$$.

Wir betrachten wieder die Methode `get` einer einfach verketteten Liste.
In <a href="#beispiel-3-einfach-verkettete-listen">Beispiel 3</a> haben wir bereits gesehen, dass für $$l : \mathbb{N} \rightarrow \mathbb{R}, l(x) = x$$ die Aussage $$T_{\texttt{get}} \le_{as} l$$ gilt.
Also gilt auch $$T_{\texttt{get}} \in \mathcal{O}(l)$$ und wir schreiben dafür auch $$T_{\texttt{get}} \in \mathcal{O}(n)$$, wobei $$n$$ die Länge der Liste ist.

Wir haben gesehen, dass die Laufzeit der Methode `get` einer ArrayList konstant ist, während die Methode `get` einer einfach verketteten Liste eine lineare Laufzeit hat.
Das heißt, die Implementierung der ArrayList ist wesentlicher effizienter.
Auf der anderen Seite benötigt eine Liste mit *n* Elementen bei einer einfach verketteten Liste *n* Knoten. Das heißt, der Speicherverbrauch einer einfach verketteten Liste ist in $$\mathcal{O}(n)$$, wobei *n* die Länge der Liste ist.
Bei einer `ArrayList` benötigen wir aber so viel Speicher wie wir für das nächst-größere Array veranschlagt haben.

Um die praktische Relevanz der $$\mathcal{O}$$-Notation zu illustrieren, wollen wir einen Blick in die Dokumentation der Klasse `ArrayList` des Paketes `java.util` werfen.
Wir haben oben bereits analysiert, dass die Laufzeit der Methode `get` in $$\mathcal{O}(1)$$, also konstant, ist.
Wir werfen einen Blick in die Dokumentation der Klasse `java.util.ArrayList`.

> The size, isEmpty, get, set, iterator, and listIterator operations run
> in constant time. The add operation runs in amortized constant time,
> that is, adding n elements requires O(n) time. All of the other
> operations run in linear time (roughly speaking). The constant factor
> is low compared to that for the LinkedList implementation.

Die Laufzeit der Methoden `size`, `isEmpty`, `get`, `set`, `iterator` und `listIterator` ist also in $$\mathcal{O}(1)$$.
Der Begriff der amortisierten Laufzeit wird für Operationen verwendet, deren Laufzeit bei mehreren hintereinander auftretenden Aufrufen sehr unterschiedlich ist.
Bei Operationen wie dem Einfügen eines Elementes in einen Container kann man sich leicht vorstellen, dass man in der Praxis nicht unbedingt an der Komplexität eines einzelnen Aufrufs interessiert ist.
Unter Umständen kann man damit leben, dass mehrfache Ausführungen einer Einfüge-Operation in der Summe effizient durchgeführt werden.
Die Angabe, dass die Methode `add` in amortisiert linearer Laufzeit läuft, bedeutet, dass eine einzelne Ausführung der Methode vermutlich nicht in $$\mathcal{O}(1)$$ ist, die *n*-fache Ausführung der Methode aber in $$\mathcal{O}(n)$$.
Dies bedeutet, dass man die Komplexität gleichmäßig auf die *n* Anwendungen der Methode verteilen kann und somit amortisiert $$\mathcal{O}(1)$$ für einen Aufruf erhält.

Wenn wir uns an die Implementierung einer `ArrayList` erinnern, musste das Array vergrößert werden, wenn kein Platz mehr vorhanden ist.
Beim Vergrößern des Arrays müssen alle Elemente, die bereits in der Liste waren, kopiert werden.
Daher ist das Vergrößern des Arrays in $$\mathcal{O}(n)$$, wobei *n* die Größe des Arrays ist.
Diese Kopieraktion muss aber nur durchgeführt werden, wenn wir bereits eine ganze Reihe von Elementen eingefügt haben. Genauer gesagt, müssen wir erst nach dem Einfügen von *n* Elementen einmal *n* Elemente kopieren.

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="linear-data-structures.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"></li>
    </ul>
</div>