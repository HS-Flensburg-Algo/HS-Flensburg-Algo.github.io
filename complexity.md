---
layout: post
title: "Komplexität"
mathjax: true
---

Zur Beschreibung des Aufwandes eines Algorithmus werden häufig zwei Kennzahlen betrachtet, die Laufzeit des Algorithmus und sein Speicherverbrauch.
Wir werden uns hier vor allem mit der Laufzeit beschäftigen.
Bei der Komplexität wird dabei eine abstrakte Einheit zur Beschreibung dieser Kennzahlen verwendet und nicht die tatsächlich verbrauchte Zeit oder der tatsächlich verbrauchte Speicher.
So wird für die Laufzeit etwa angenommen, dass bestimmte Operationen, wie zum Beispiel das Vergleichen von zwei Zahlen oder die Berechnung einer arithmetischen Operation, **eine Zeiteinheit/einen Schritt** in Anspruch nehmen.
Man bezeichnet die Operationen, für die man eine feste Anzahl an Schritten annimmt, als **primitive Operationen**.
Auf diese Weise verliert man natürlich Genauigkeit, da der Algorithmus je nach tatsächlichem Aufwand schneller oder langsamer ausgeführt wird.
Man erhält aber eine Vergleichbarkeit verschiedener Algorithmen unabhängig von ihrer konkreten Umsetzung in einer bestimmten Programmiersprache oder einer bestimmten Rechnerarchitektur.

Die Komplexität eines Algorithmus wird dabei in der Größe der Eingabedaten ausgedrückt.
So wird das Suchen eines Wertes in einer Liste zum Beispiel je mehr Zeit in Anspruch nehmen, desto mehr Elemente die Liste hat.
Formal wird die Komplexität durch eine Funktion ausgedrückt, die die Größe der Eingabe als Argument erhält und als Ergebnis die Anzahl der benötigten Schritte liefert.
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

## Konkrete Laufzeiten

Im Folgenden werden wir uns die konkreten Laufzeiten einiger Methoden auf linearen Datenstrukturen anschauen.
Konkrete Laufzeit bedeutet dabei, dass wir mathematische Funktionen angeben, die berechnen, wie viele Schritte eine Methode benötigt.
Die konkreten Laufzeiten, die wir hier angeben, dienen nur zur Illustration.
Wir werden im zweiten Schritt sehen, dass wir an den ganz genauen Anzahlen an Schritten, die eine Methode durchführt, gar nicht interessiert sind.

### Arrays

Als Beispiel für eine konkrete Laufzeit wollen wir die folgende Implementierung der `get`-Methode einer `ArrayList` betrachten.

``` java
public T get(int index) {
    @SuppressWarnings("unchecked")
    var value = (T) array[index];
    return value;
}
```

Wir beschreiben die Laufzeit dieser Methode als Funktion, deren Eingabe die Größe des Arrays ist.
Wir haben bereits gesehen, dass der Zugriff auf ein Element eines Arrays mithilfe einer einfachen Rechnung umgesetzt werden kann.
Bei der Bestimmung von Laufzeiten von Methoden geht man davon aus, dass der Zugriff auf ein Array einen Schritt benötigt.
Außerdem wird der Variable `value` ein Wert zugewiesen, dafür zählen wir ebenfalls einen Schritt.
Der generische Typ `T` ist in Java nur zur Compile-Zeit existent.
Das heißt, zur Laufzeit verursacht der _Cast_ keinerlei Aufwand.
Für die `return`-Anweisung zählen wir einen weiteren Schritt.

Die folgende mathematische Funktion beschreibt die Laufzeit der Methode `get` einer `ArrayList`.[^1]

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{get}}(x) = 3$$

In diesem Beispiel kann noch erwähnt werden, dass sich bei der Methode `get` der `ArrayList` die *best case*- und *worst case*-Laufzeit nicht unterscheiden.
Unabhängig davon, wie die Liste aussieht und welchen Index wir suchen, benötigt die Methode immer 3 Schritte.


### Einfach verkettete Listen

Zum Vergleich wollen wir uns die Laufzeit der Methode `get` einer einfach verketteten Liste anschauen.
Wir wollen also wissen, wie viele Schritte die Methode `get` bei verschiedenen Eingabegrößen benötigt.
Dazu schauen wir uns noch einmal die Implementierung dieser Methode an.

``` java
public T get(int index) {
    return nodeAt(index).getValue();
}
```

Die Methode ist mithilfe der Methode `nodeAt` implementiert, wir müssen uns also anschauen, wie die Methode `nodeAt` ist.

``` java
private Node<T> nodeAt(int index) {
    var current = this.first;
    for (int i = 0; i < index; i++) {
        current = current.getNext();
    }
    return current;
}
```

Wir hatten erwähnt, dass *best case*-, *average case*- und *worst case*-Laufzeiten betrachtet werden.
Wir wollen uns in diesem Fall die *worst case*-Laufzeit der Methode `get` anschauen.
Der *worst case* der Methode `get` tritt ein, wenn die Methode mit dem letzten Index, also $$n − 1$$ &mdash; wenn $$n$$ die Länge der Liste ist &mdash; aufgerufen wird.

Wir können bei einer solchen Methode jetzt einfach analysieren, wie viele primitive Operationen durchgeführt werden.
Wir schauen uns dazu einmal die Methode `nodeAt` genauer an.
Jeder Aufruf der Methode initialisiert die Variable `current` und weist ihr das Attribut `this.first` zu.
Außerdem initialisiert jeder Aufruf die Variable `i`.
Das heißt, die Methode `nodeAt` führt 3 primitive Operationen vor der Schleife durch.
Wie viele Operationen durch die Schleife durchgeführt werden, hängt von der Größe des Index ab.
Wir wollen uns die *worst case*-Laufzeit anschauen, daher hat der Index den Wert $$n − 1$$.
Wenn der Index den Wert $$n - 1$$ hat, führt die Schleife $$n - 1$$ Durchläufe durch.
Bei jedem Schleifendurchlauf muss die Bedingung `i < index` überprüft und der Zähler `i` erhöht werden.
Außerdem wird bei jedem Schleifendurchlauf der Rumpf der Schleife ausgeführt, also `current = current.getNext()`.
Das heißt, in jedem Schleifendurchlauf wird noch die Methode `getNext` ausgeführt und die Variable `current` zugewiesen.
In jedem Schleifendurchlauf führen wir also 4 primitive Operationen durch.
Nach der Schleife muss unabhängig von der Anzahl der Durchläufe immer noch einmal der Vergleich `i < index` durchgeführt werden, der in diesem Fall aber fehlschlägt.
Außerdem wird das `return` ausgeführt.
Daher werden nach der Schleife noch zwei weitere primitive Operationen durchgeführt.

An dieser Stelle ist nicht relevant, wie viele Schritte die einzelnen Operationen, wie eine Zuweisung genau benötigen, es geht nur darum, dass es grundsätzlich möglich ist, die Schritte einfach zu zählen.
Wir werden im Folgenden sehen, dass eine so genaue Analyse gar nicht notwendig ist.
Wir stellen uns trotzdem einmal vor, dass wir die Analyse durchgeführt haben und die folgende Funktion die Anzahl der Schritte der Methode `nodeAt` beschreibt.

$$T_{\texttt{nodeAt}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{nodeAt}}(x) = 4 x + 5$$

Da die Methode `get` noch einen zusätzlichen Methodenaufruf durchführt, auf ein Attribut zugreift und ein `return` ausführt, erhalten wir insgesamt folgende Laufzeit.

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{get}}(x) = T_{\texttt{nodeAt}}(x) + 3 = 4 x + 8$$

Wir haben am Unterschied zwischen den Laufzeiten der Methoden `get` und `nodeAt` eigentlich kein großes Interesse.
Wenn die Eingabe sehr groß ist, ist der Unterschied zwischen diesen beiden Methoden verschwindend gering.
Bei einer Liste mit 10.000 Elementen benötigt `nodeAt` zum Beispiel 50.005 Schritte, während `get` 50.008 Schritte benötigt.
Im Gegensatz dazu sind wir am Unterschied zwischen der Methode `get` auf einer einfach verketteten Liste und der Methode `get` auf einer `ArrayList` aber sehr wohl interessiert.
So benötigt die Methode auf der einfach verketteten Liste bei einer Liste mit 10.000 Elementen 50.008 Schritte, die Methode auf einer `ArrayList` aber nur 3 Schritte.
Das heißt, wir wollen bestimmte Arten von Unterschieden zwischen Funktionen vernachlässigen, während wir andere weiterhin unterscheiden möchten. Mithilfe von asymptotischen Laufzeiten wird die Klassifikation, die wir uns wünschen, vorgenommen.

## Asymptotisches Wachstum

Wir haben motiviert, dass wir bei der Betrachtung der Komplexität bestimmte Funktionen nicht unterscheiden, also als gleich auffassen, möchten.
Bevor wir eine formale Definition hierfür angeben, wollen wir noch kurz motivieren, dass wir auch in anderer Hinsicht bestimmte Funktionen als gleich auffassen wollen.
Wir stellen uns einmal vor, dass wir eine Laufzeit betrachten, die wie folgt definiert ist.

$$T_{\texttt{method1}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{method1}}(x) = \begin{cases}
  2,     & \text{falls}~x < 10\\
  3 x,  & \text{sonst}
\end{cases}$$

Wir wollen eine solche Funktion nicht von einer Funktion unterscheiden, die immer $$3 x$$ Schritte benötigt.
Auf der anderen Seite wollen wir eine Funktion der Form

$$T_{\texttt{method2}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{method2}}(x) = \begin{cases}
  3 x,  & \text{falls}~x < 10\\
  2,     & \text{sonst}
\end{cases}$$

nicht von einer Funktion unterscheiden, die immer $$2$$ Schritte benötigt, sehr wohl aber von einer Funktion, die immer $$3 x$$ Schritte benötigt.
Die folgende Definition erfüllt alle Anforderungen, die wir uns bisher erarbeitet haben.

#### Definition 1 (Asymptotisch kleiner gleich)

Wir definieren eine Relation $$\le_{\text{as}}$$ mit der wir Funktionen vergleichen können.
Für zwei Funktionen $$f, g : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}$$ definieren wir, dass $$f$$ genau dann asymptotisch kleiner gleich $$g$$ ist ($$f \le_{\text{as}} g$$), wenn die folgende Bedingung erfüllt ist.[^2]

$$\exists c \in \mathbb{R}_{>0}: \exists n_0 \in \mathbb{N} : \forall n \in \mathbb{N}: n \geq n_0 \Rightarrow f(n) \leq c \cdot g(n)$$

In Worten gesprochen ist eine Abbildung $$f$$ asymptotisch kleiner gleich einer Abbildung $$g$$, falls es ein Argument $$n_0$$ gibt, ab dem das Ergebnis von $$g$$ (multipliziert mit einem Faktor $$c$$) immer größer gleich dem Ergebnis von $$f$$ ist.
Den Faktor $$c$$ müssen wir allerdings ganz zu Anfang wählen.
Das heißt, der Wert, den wir für $$c$$ wählen, kann weder von $$n_0$$ abhängen, noch von dem $$n$$, das wir uns anschauen.

<a href="#figure:o-notation">Abbildung 1</a> veranschaulicht, wann eine Funktion $$f$$ asymptotisch kleiner gleich einer Funktion $$g$$ ist.

<figure id="figure:o-notation" markdown="1">
  ![](/assets/graphics/o-notation.svg){: width="600px" .centered}
  <figcaption>Abbildung 1: Die Funktion <em>f</em> ist asymptotisch kleiner gleich der Funktion <em>g</em></figcaption>
</figure>

<a href="#figure:constant-factor">Abbildung 2</a> veranschaulicht den Einfluss des Faktors $$c$$, der auch als konstanter Faktor bezeichnet wird.

<figure id="figure:constant-factor" markdown="1">
  ![](/assets/graphics/constant-factor.svg){: width="400px" .centered}
  <figcaption>Abbildung 2: Verschiedene konstante Faktoren</figcaption>
</figure>

Um zu zeigen, dass eine konkrete Funktion asymptotisch kleiner gleich einer anderen konkreten Funktion ist, müssen wir einen Beweis führen.
In diesen Beweisen nutzen wir die folgenden Eigenschaften von $$\le$$ auf reelen Zahlen.

<figure id="figure:le-rules" markdown="1">
$$\begin{align}
& \forall k, x, y \in \mathbb{R}: & k \ge 0 \wedge x \le y & \Rightarrow k \cdot x \le k \cdot y \tag{1}\label{eq:eq1}\\
& \forall k, x, y \in \mathbb{R}: & x \le y                & \Rightarrow k + x \le k + y \tag{2}\label{eq:eq2}
\end{align}$$
<figcaption>Abbildung 3: Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;">≤</span></figcaption>
</figure>

Aus den Regeln in <a href="#figure:le-rules">Abbildung 3</a> können wir zwei weitere Regeln ableiten, die wir zur Vereinfachung der Beweise in der folgenden Form nutzen werden.

<figure id="figure:additional-le-rules" markdown="1">
$$\begin{align}
& \forall x, y \in \mathbb{R}: & x \ge 0 \wedge y \ge 1 & \Rightarrow x \le x \cdot y \tag{3}\label{eq:eq3}\\
& \forall x, y \in \mathbb{R}: & y \ge 0                & \Rightarrow x \le x + y \tag{4}\label{eq:eq4}
\end{align}$$
<figcaption>Abbildung 4: Abgeleitete Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;">≤</span></figcaption>
</figure>

Aufgrund der Kommutativität der Operatoren $$\cdot$$ und $$+$$ gelten diese Regeln auch jeweils mit vertauschten Argumenten für $$\cdot$$ und $$+$$.
Wenn wir die jeweils duale Regel anwenden, werden wir neben der jeweiligen Regel noch angeben, dass wir Kommutativität angewendet haben.

#### Beweis 1 (Lineares Wachstum kleiner gleich quadratischem)

Wir betrachten die Funktionen $$l : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, l(x) = x$$ und
$$q : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, q(x) = x^2$$. Wir wollen beweisen, dass
$$l \le_{\text{as}} q$$ gilt.

**Behauptung:** Es gilt $$l \le_{\text{as}} q$$.

**Beweis:**

Setze $$c = 1$$.
Setze $$n_0 = 1$$.
Sei $$n \in \mathbb{N}$$ mit $$n \ge n_0$$.
Dann gilt

$$\begin{align*}
l(n) & = n\\
     & \le n \cdot n && \text{(1)}\\
     & = n^2\\
     & = 1 \cdot n^2 && \text{$1$ ist neutrales Element bezüglich $\cdot$}\\
     & = c \cdot n^2 && c = 1\\
     & = c \cdot q(n)
\end{align*}$$

Bei Schritt $$(1)$$ müssen wir noch argumentieren, warum dieser Schritt korrekt ist.
Dazu wenden wir Regel (\ref{eq:eq3}) mit $$x := n$$ und $$y := n$$ an.
Wir müssen dann noch zeigen, dass $$n \ge 0$$ und $$n \ge 1$$ gilt.
Beide Aussagen gelten, da $$n \ge n_0 = 1$$.

Dies zeigt, dass $$l \le_{\text{as}} q$$ gilt.

<figure id="figure:linear-quadratic">
<div class="centered" style="width:100%;" markdown="1">
![](/assets/graphics/linear-function.svg){: width="365px"}
![](/assets/graphics/quadratic-function.svg){: width="365px"}
</div>
<figcaption>Abbildung 5: Lineares und quadratisches Wachstum</figcaption>
</figure>

<a href="#figure:linear-quadratic">Abbildung 4</a> illustriert diese Aussage.
Wir sehen, dass die Funktion $$q$$ ab der Stelle $$n_0 = 1$$ immer oberhalb von $$l$$ liegt.
<a href="#figure:linear-quadratic">Abbildung 4</a> illustriert außerdem an den Beispielen von $$c = 2$$ und $$c = 3$$, dass $$q \not \le_{\text{as}} l$$, da die Funktion $$q(x)$$ die Funktion $$c \cdot l(x)$$ für jedes $$c$$ immer irgendwann "überholt".
<!-- Wir werden hier nicht formal beweisen, dass eine Funktion nicht asymptotisch kleiner gleich einer anderen Funktion ist.
Wir werden stattdessen nur für bestimmte Klassen von Funktionen lernen, dass sie nicht asymptotisch kleiner gleich einer anderen Klasse von Funktionen sind. -->
Um zu beweisen, dass die Funktion $$q$$ nicht asymptotisch kleiner gleich der Funktion $$l$$ ist, müssten wir zeigen, dass die beiden Funktionen nicht in der der $$\le_{\text{as}}$$-Relation stehen.
Dazu müssen wir die logische Aussage in der Definition von $$\le_{\text{as}}$$ negieren und einen Beweis für diese negierte Formel führen.

#### Beweis 2 (Quadratisches Wachstum nicht kleiner gleich linearem)

Wir betrachten wieder die Funktionen $$l : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, l(x) = x$$ und
$$q : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, q(x) = x^2$$.
Wir wollen beweisen, dass $$q \le_{\text{as}} l$$ nicht gilt.
Bevor wir mit dem Beweis starten, wollen wir ein paar Vorüberlegungen durchführen.
Um zu zeigen, dass die Aussage nicht gilt, müssen wir zeigen, dass die negierte Aussage gilt.
Zuerst müssen wir die Aussage von $$q \le_{\text{as}} l$$ also negieren.

$$\begin{align*}
\neg (q \le_{\text{as}} l) & \Leftrightarrow \neg (\exists c \in \mathbb{R}_{>0}: \exists n_0 \in \mathbb{N} : \forall n \in \mathbb{N}: n \geq n_0 \Rightarrow q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \neg (\exists n_0 \in \mathbb{N} : \forall n \in \mathbb{N}: n \geq n_0 \Rightarrow q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \forall n_0 \in \mathbb{N} : \neg (\forall n \in \mathbb{N}: n \geq n_0 \Rightarrow q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \forall n_0 \in \mathbb{N} : \exists n \in \mathbb{N}: \neg (n \geq n_0 \Rightarrow q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \forall n_0 \in \mathbb{N} : \exists n \in \mathbb{N}: \neg (\neg (n \geq n_0) \vee q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \forall n_0 \in \mathbb{N} : \exists n \in \mathbb{N}: \neg \neg (n \geq n_0) \wedge \neg (q(n) \leq c \cdot l(n))\\
     & \Leftrightarrow \forall c \in \mathbb{R}_{>0}: \forall n_0 \in \mathbb{N} : \exists n \in \mathbb{N}: n \geq n_0 \wedge q(n) > c \cdot l(n)
\end{align*}$$

Wir müssen jetzt eigentlich "nur" diese formale Aussage beweisen.
Um vor dem Beweis eine Intuition für den Beweis zu vermitteln, nehmen wir einmal an, jemand behauptet, $$q \le_{\text{as}} l$$ gilt.
Um die Text im Folgenden etwas zu vereinfachen, nennen wir diese Person im Folgenden Professor Klein.
Professor Klein behauptet also, dass $$q \le_{\text{as}} l$$ gilt.
Wir sind aber sofort skeptisch.
Daher verlangen wir von Professor Klein als Beleg Werte für $$c$$ und $$n_0$$.
Professor Klein gibt also $$c = 2$$ und $$n_0 = 0$$ an.
Professor Klein behauptet also, dass $$q(n) = n^2 \le 2 \cdot n = c \cdot l(n)$$ für alle $$n \in \mathbb{N}$$ mit $$n \ge 0$$ gilt.
Diese Aussage können wir aber sofort als falsch belegen.
Wir sagen Professor Klein, dass diese Aussage für $$n = 3$$ nicht wahr ist, denn es gilt $$q(3) = 3^2 = 3 \cdot 3 > 2 \cdot 3 = c \cdot l(3)$$.

Wir wollen Professor Klein noch eine Chance geben.
Er darf also noch einmal Werte für $$c$$ und $$n_0$$ angeben.
Dieses Mal nennt Professor Klein $$c = 1$$ und $$n_0 = 2$$ an.
Professor Klein behauptet also, dass $$q(n) = n^2 \le n = 1 \cdot n = c \cdot l(n)$$ für alle $$n \in \mathbb{N}$$ mit $$n \ge 2$$ gilt.
Aber auch diese Aussage können wir sofort als falsch belegen.
Wir sagen Professor Klein, dass diese Aussage für $$n = 2$$ nicht wahr ist, denn es gilt $$q(2) = 2^2 = 2 \cdot 2 > 1 \cdot 2 = c \cdot l(2)$$.

Bei einem genaueren Blick auf unsere Gegenbeispiele können wir ein Muster erkennen.
Wir müssen unser Gegenbeispiel $$n$$ nur so groß wählen, dass es größer als $$c$$ ist, da in diesem Fall $$n \cdot n$$ größer ist als $$c \cdot n$$.
Da das $$n$$ die Bedingung $$n \ge n_0$$ erfüllen soll, müssen wir das $$n$$ außerdem so wählen, dass es mindestens so groß ist wie $$n_0$$.
Diese Idee wird durch den folgenden Beweis formal umgesetzt.
Dabei entsteht noch eine technische Schwierigkeit.
Der Wert der Variable $$n$$ muss eine natürliche Zahl sein, der Wert der Variable $$c$$ ist aber eine reele Zahl.
Das heißt, Professor Klein könnte als Wert für $$c$$ zum Beispiel $$0,12345$$ oder $$\sqrt 2$$ angeben.
Wir müssen daraus dann eine natürliche Zahl konstruieren, die größer ist als $$c$$.
Zu diesem Zweck nutzen wir die mathematische Operation zum Aufrunden, die als $$\lceil c \rceil$$ geschrieben wird.

In dem folgenden Beweis werden wir die folgenden formalen Eigenschaften des Maximums und des Aufrundens verwenden.
Außerdem verwenden wir Regeln für $$<$$, die analog zu den Regeln für $$\le$$ sind.

<figure id="figure:max-rules" markdown="1">
$$\begin{align}
& \forall x, y \in \mathbb{R}: & \max \{ x, y \} & \ge x \tag{5}\label{eq:eq5}
\end{align}$$
<figcaption>Abbildung 6: Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;">max</span></figcaption>
</figure>

<figure id="figure:-ceil-rules" markdown="1">
$$\begin{align}
& \forall x \in \mathbb{R}: & \lceil x \rceil \ge x \tag{6}\label{eq:eq6}
\end{align}$$
<figcaption>Abbildung 7: Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;"><</span></figcaption>
</figure>

<figure id="figure:lt-rules" markdown="1">
$$\begin{align}
& \forall k, x, y \in \mathbb{R}: & k > 0 \wedge x < y & \Rightarrow k \cdot x < k \cdot y \tag{7}\label{eq:eq7}\\
& \forall k, x, y \in \mathbb{R}: & x < y              & \Rightarrow k + x < k + y \tag{8}\label{eq:eq8}
\end{align}$$
<figcaption>Abbildung 3: Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;">≤</span></figcaption>
</figure>

<figure id="figure:additional-le-rules" markdown="1">
$$\begin{align}
& \forall x, y \in \mathbb{R}: & x > 0 \wedge y > 1 & \Rightarrow x < x \cdot y \tag{9}\label{eq:eq9}\\
& \forall x, y \in \mathbb{R}: & y > 0              & \Rightarrow x < x + y \tag{10}\label{eq:eq10}
\end{align}$$
<figcaption>Abbildung 4: Abgeleitete Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;"><</span></figcaption>
</figure>

**Behauptung:** Die Aussage $$q \le_{\text{as}} l$$ gilt nicht.

**Beweis:**
Um diese Aussage zu beweisen, beweisen wir, dass $$\neg (q \le_{\text{as}} l)$$ wahr ist.

Sei $$c \in \mathbb{R}_{>0}$$.
Sei $$n_0 \in \mathbb{N}$$.
Setze $$n = \max \{\lceil c \rceil + 1, n_0\}$$.
Dann gilt

$$\begin{align*}
q(n) & = n^2\\
     & = n \cdot n &&\\
     & = \max \{\lceil c \rceil + 1, n_0\} \cdot n && n = \max \{\lceil c \rceil + 1, n_0\}\\
     & \ge (\lceil c \rceil + 1) \cdot n && \text{(1)}\\
     & = \lceil c \rceil \cdot n + \lceil c \rceil \cdot 1 && \text{Distributivität}\\
     & = \lceil c \rceil \cdot n + \lceil c \rceil && \text{$1$ ist neutrales Element bezüglich $\cdot$}\\
     & > \lceil c \rceil \cdot n && \text{(2)}\\
     & \ge c \cdot n && \text{(3)}\\
     & = c \cdot l(n)
\end{align*}$$

Bei den Schritten $$(1)$$, $$(2)$$ und $$(3)$$ müssen wir noch argumentieren, warum diese Schritte korrekt sind.

Bei Schritt $$(1)$$ wenden wir Kommutativität von $$\cdot$$ an und Regel (\ref{eq:eq1}).
Wir nutzen dabei $$k := n$$, $$x := \lceil c \rceil + 1$$ und $$y := \max \{\lceil c \rceil + 1, n_0\}$$ und müssen dann noch zeigen, dass $$n \ge 0$$ und $$\lceil c \rceil + 1 \le \max \{\lceil c \rceil + 1, n_0\}$$ gilt.
Da $$n \in \mathbb{N}$$, gilt auch $$n \ge 0$$ und $$\lceil c \rceil + 1 \le \max \{\lceil c \rceil + 1, n_0\}$$ folgt aus Regel (\ref{eq:eq5}) mit $$x := \lceil c \rceil + 1$$ und $$y := n_0$$.

Bei Schritt $$(2)$$ wenden wir Regel (\ref{eq:eq10}) mit $$x := \lceil c \rceil \cdot n$$ und $$y := \lceil c \rceil$$ an.
Wir müssen dann noch zeigen, dass $$\lceil c \rceil > 0$$ gilt.
Mit Regel (\ref{eq:eq6}) und den Voraussetzung für $$c$$ folgt $$\lceil c \rceil \ge c > 0$$.

Bei Schritt $$(3)$$ wenden wir Kommutativität von $$\cdot$$ an und Regel (\ref{eq:eq1}).
Wr nutzen dabei $$k := n$$, $$x := c$$ und $$y := \lceil c \rceil$$ und müssen dann noch zeigen, dass $$n \ge 0$$ und $$\lceil c \rceil \ge c$$ gilt.
Da $$n \in \mathbb{N}$$, gilt auch $$n \ge 0$$ und $$\lceil c \rceil \ge c$$ foglt aus Regel (\ref{eq:eq6}) mit $$x := c$$.

Dies zeigt, dass $$q \le_{\text{as}} l$$ nicht gilt.

<figure id="figure:growth">
<div class="centered" style="width:100%;" markdown="1">
![](/assets/graphics/growth.svg){: width="700px" .centered}
</div>
<figcaption>Abbildung 5: Verschiedenes Wachstum im Vergleich</figcaption>
</figure>

<a href="#figure:growth">Abbildung 5</a> vermittelt einen Eindruck darüber, wie unterschiedliche Funktionen wachsen.
Die Wachstumsfunktionen $$f(x) = 1$$, $$f(x) = x$$, $$f(x) = x^2$$, $$f(x) = x^3$$, $$f(x) = x^4$$ und $$f(x) = 2^x$$ werden als konstantes, lineares, quadratisches, kubisches, biquadratisches bzw. exponentielles Wachstum bezeichnet.
In der Praxis ist ein Wachstum über quadratischem tatsächlich kaum tolerierbar.
Dagegen wird bei $$f(x) = x \log(x)$$ auch von quasilinearem Wachstum gesprochen, da der zusätzliche logarithmische Faktor kaum ins Gewicht fällt.
<a href="#figure:growth">Abbildung 5</a> erweckt unter Umständen den Eindruck, dass $$x^4$$ schneller wächst als $$2^x$$.
Dies ist aber nicht der Fall, so gilt zum Beispiel 16<sup>4</sup> = 65.536 und 2<sup>16</sup> = 65.536, aber 17<sup>4</sup> = 83.521 und 2<sup>17</sup> = 131.072.
Außerdem gilt 100<sup>4</sup> = 100.000.000, aber 2<sup>100</sup> = 1.267.650.600.228.229.401.496.703.205.376
Insbesondere gilt für jede Funktion der Form $$f(x) = x^p$$, wobei $$p$$ eine natürliche Zahl ist, dass $$e(x) = 2^x$$ schneller wächst als das Polynom.
Anders ausgedrückt gilt für jedes Polynom $$p$$ die Aussage $$p \le_{\text{as}} e$$ und $$e \not \le_{\text{as}} p$$.

<a href="#figure:runtimes">Abbildung 6</a> illustriert die verschiedenen Wachstumsfunktionen noch einmal, indem angenommen wird, dass ein Schritt 1 μs Zeit in Anspruch nimmt.
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

<figcaption>Abbildung 6: Laufzeiten für verschiedene Wachstumsfunktionen (1 Schritt = 1 μs)</figcaption>
</figure>

#### Beispiel 2 (ArrayList)

Wir betrachten die Methode `get` der Klasse `ArrayList`.
Wir haben festgestellt, dass die folgende Funktion die Anzahl der Schritte der Funktion beschreibt.

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{get}}(x) = 3$$

Wir betrachten die Funktion $$k : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, k(x) = 1$$.
Es gilt $$T_{\texttt{get}} \le_{\text{as}} k$$.
Außerdem gilt $$k \le_{\text{as}} T_{\texttt{get}}$$.
Das heißt, die Funktionen $$T_{\texttt{get}}$$ und $$k$$ wachsen gleich schnell.

#### Beispiel 3 (Einfach verkettete Listen)

Wir betrachten die Methode `get` einer einfach verketteten Liste.
Wir haben festgestellt, dass die folgende Funktion die Anzahl der Schritte dieser Methode angibt.

$$T_{\texttt{get}} : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, T_{\texttt{get}}(x) = 4 x + 8$$

Wir betrachten die Funktion $$l : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, l(x) = x$$.
Es gilt $$T_{\texttt{get}} \le_{\text{as}} l$$.
Außerdem gilt $$l \le_{\text{as}} T_{\texttt{get}}$$.
Für $$k : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, k(x) = 1$$
gilt $$T_{\texttt{get}} \not \le_{\text{as}} k$$.
Es gilt allerdings $$k \le_{\text{as}} T_{\texttt{get}}$$.
Das heißt $$T_{\texttt{get}}$$ wächst schneller als $$k$$.

## Größenordnungen

Eine Größenordnung ist eine Menge von Funktionen, die — bis auf eine gewisse Abweichung — alle ähnlich schnell wachsen.
Wir führen dafür die $$\mathcal{O}$$-Notation ein, mit deren Hilfe man eine Größenordnung beschreiben kann.

#### Definition 2 (Asymptotisch obere Schranke)

Wir definieren

$$\mathcal{O}(f) := \{ g: \mathbb{N} \rightarrow \mathbb{R}_{\ge 0} \mid g \le_{\text{as}} f \}.$$

Das heißt, in der Menge $$\mathcal{O}(f)$$ sind die Funktionen, die höchstens so schnell wachsen wie die Funktion $$f$$.
An Stelle einer Abbildung verwendet man für $$f$$ häufig den Funktionswert der Funktion.
Das heißt, anstelle von “für $$f(n) = n$$ und $$g(n) = n^2$$ gilt $$f \in \mathcal{O}(g)$$”, schreibt man häufig “$$f \in \mathcal{O}(n^2)$$”.
Bei beiden Varianten sollte man immer angeben, welchen Wert die Variable $$n$$ darstellt, also was in dem jeweiligen Fall "die Größe der Eingabe" ist.
Im Fall von Listen wäre dies etwa die Länge der Liste.

Wir betrachten wieder die Methode `get` einer ArrayList.
In <a href="#beispiel-2-arraylist">Beispiel 2</a> haben wir bereits gesehen, dass für $$k : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, k(x) = 1$$ die Aussage $$T_{\texttt{get}} \le_{\text{as}} k$$ gilt.
Also gilt auch $$T_{\texttt{get}} \in \mathcal{O}(k)$$ und wir schreiben dafür auch $$T_{\texttt{get}} \in \mathcal{O}(1)$$.

Wir betrachten wieder die Methode `get` einer einfach verketteten Liste.
In <a href="#beispiel-3-einfach-verkettete-listen">Beispiel 3</a> haben wir bereits gesehen, dass für $$l : \mathbb{N} \rightarrow \mathbb{R}_{\ge 0}, l(x) = x$$ die Aussage $$T_{\texttt{get}} \le_{\text{as}} l$$ gilt.
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

[^1]: Dabei gilt $$\mathbb{R}_{\ge 0} = \{ x \in \mathbb{R} \mid x \ge 0 \}$$.

[^2]: Dabei gilt $$\mathbb{R}_{>0} = \{ x \in \mathbb{R} \mid x \gt 0 \}$$.

{% include bottom-nav.html previous="linear-data-structures.html" %}
