---
layout: post
title: "Dynamische Programmierung"
---

Die dynamische Programmierung kann man anwenden, wenn eine Methode mehrfach mit identischen Argumenten aufgerufen wird.
Die Idee der dynamischen Programmmierung besteht darin, das Ergebnis des jeweils ersten Aufrufs in einer Datenstruktur zu speichern.
Beim zweiten Aufruf wird dann nicht die gleiche Berechnung noch einmal durchgeführt, sondern das zuvor berechnet Ergebnis wird in der Datenstruktur nachgeschlagen.
Damit dieser Ansatz eine Implementierung liefert, die effizienter ist als die ursprüngliche Implementierung, muss das Nachschlagen der Ergebnisse in der Datenstruktur entsprechend effizient sein.
Häufig wird für die Datenstruktur daher ein Array verwendet.


Beispiel
--------

Um die Methode der dynamischen Programmierung zu motivieren, die wir uns im Folgenden anschauen, wollen wir uns die Implementierung der Methode `fib` noch mal etwas genauer anschauen.
Wir wollen uns einmal anschauen, welche Aufrufe der Methode `fib` für den Aufruf `fib(5)` durchgeführt werden.
Bei der Struktur, welche die Aufrufe der Methode darstellt, handelt es sich um einen Baum.
Daher wird die Struktur auch als Rekursionsbaum bezeichnet.
Jeder Knoten des Baumes ist ein Aufruf der Methode `fib`.
Ein Knoten hat dann jeweils die rekursiven Aufrufe der Methode als Nachfolger.
Der Knoten `fib(5)` hat zum Beispiel die Nachfolger `fib(4)` und `fib(3)`.

<figure id="figure:fib-calls" markdown="1">

![](/assets/graphics/fib-calls.svg){: width="100%" .centered}

<figcaption>Abbildung 3: Der Rekursionsbaum für <code class="language-plaintext highlighter-rouge">fib(5)</code></figcaption>
</figure>

<a href="#figure:fib-calls">Abbildung 3</a> zeigt, dass viele Aufrufe der Methode `fib` mehrfach durchgeführt werden.
Mit Hilfe der dynamischen Programmierung können wir die mehrfache Berechnung dieser Werte vermeiden.

Bei der dynamischen Programmierung werden die Ergebnisse einer Methode in einer Datenstruktur gespeichert.
Wird die Methode dann mit den gleichen Argumenten noch einmal aufgerufen, so wird das Ergebnis nicht erneut berechnet, sondern in der Datenstruktur nachgeschlagen.
Wir können diese Methode nutzen, um die Berechnung einer Fibonacci-Zahl effizienter durchzuführen. 
Um uns die Mehrfachberechnungen zu sparen, merken wir uns einfach die bereits berechneten Werte in einem Array.

``` java
static int fibDyn(int n) {
    var memo = new Integer[n + 1];
    return fibDyn(memo, n);
}

private static int fibDyn(Integer[] memo, int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        if (memo[n] == null) {
            memo[n] = fibDyn(memo, n - 1) + fibDyn(memo, n - 2);
        }
        return memo[n];
    }
}
```

Um zu verstehen, wie die Aufrufe im Array `memo` nachgeschlagen werden, müssen wir wissen, dass Java die Argumente einer Methode von links nach rechts auswertet.
Das heißt, beim Aufruf `fibDyn(memo, n - 1) + fibDyn(memo, n - 2)` wird der Aufruf `fibDyn(memo, n - 1)` ausgeführt bevor der Aufruf `fibDyn(memo, n - 2)` ausgeführt wird.
Die folgende Abbildung zeigt die Aufrufstruktur mit Hilfe der dynamischen Programmierung. 

<figure id="figure:fib-calls" markdown="1">

![](/assets/graphics/fib-calls-reduced.svg){: width="100%" .centered}

<figcaption>Abbildung 4: Der Rekursionsbaum für <code class="language-plaintext highlighter-rouge">fibDyn(5)</code></figcaption>
</figure>

Da wir die ersten beiden Einträge des Arrays gar nicht verwenden, können wir den Speicherverbrauch der Implementierung noch optimieren, indem wir ein Array der Größe `Math.max(0, n - 1)` anlegen und jeweils `memo[n - 2]` nutzen.
Wir müssen die Funktion `Math.max` nutzen, da Java einen Laufzeitfehler wirft, wenn wir versuchen, ein Array mit einer negativen Größe zu erzeugen.
Diese Implementierung spart zwei Arrayeinträge, hat aber den Nachteil, dass sie schwieriger zu verstehen ist.

Die Idee der dynamischen Programmierung kann auf verschiedene Arten angewendet werden.
Wir beschäftigen uns hier nur damit, wie man dynamische Programmierung anwenden kann und dabei die grundlegende Struktur der Originalimplementierung möglichst erhält.
Es gibt aber auch Ansätze, bei denen das Füllen der Datenstruktur und das Auslesen stärker getrennt werden.
Zur Implementierung der Fibonacci-Funktion können wir zum Beispiel ein Array mit Zahlen füllen und anschließend im gefüllten Array den entsprechenden Wert nachschlagen.

Um noch einmal den Ansatz der dynamischen Programmierung zu motivieren, wollen wir uns Gedanken über die Laufzeiten der beiden Implementierungen machen.
Zuerst geben wir eine Rekurrenz für die Laufzeit der Methode `fib` an.
Um das Problem etwas zu vereinfachen, gehen wir davon aus, dass alle konstanten Aufwände, die in der Methode vorkommen, identisch sind.
Wir könnten für die Konstante $$c_1$$ hier zum Beispiel das Maximum der tatsächlichen Konstanten nutzen.

$$
\begin{align}
T_{\texttt{fib}} & : \mathbb{N} \rightarrow \mathbb{R}\\
T_{\texttt{fib}} & (n)= \begin{cases}
  c_1                       & \text{falls}~n = 0\\\\
  c_1                       & \text{falls}~n = 1\\\\
  c_1 + T_{\texttt{fib}}(n - 1) + T_{\texttt{fib}}(n - 2) & \text{sonst}
\end{cases}
\end{align}
$$

Mithilfe der starken Induktion wollen wir nun zeigen, dass $$T_{\texttt{fib}}(n) \in \mathcal{O}(2^n)$$ gilt.
Dazu müssen wir zeigen, dass ein $$c \in \mathbb{R}$$ mit $$c > 0$$ und ein $$n_0 \in \mathbb{N}$$ existieren, so dass $$T_{\texttt{fib}}(n) \le c \cdot 2^n$$ für alle $$n \in \mathbb{N}$$ mit $$n \ge n_0$$ gilt.
Wir zeigen zunächst eine Hilfsaussage.

**Beh.:** $$\forall n \in \mathbb{N} \colon n \ge 1 \Rightarrow T_{\texttt{fib}}(n) \le c_1 \cdot 2^n$$

**Bew.:**

Zur Lesbarkeit nennen wir die Funktion $$T_{\texttt{fib}}$$ im Folgenden $$T$$.

Wir zeigen die Aussage per starker Induktion mit $$n_0 = 1$$.

Induktionsschritt:

Sei $$n \in \mathbb{N}$$ mit $$n \ge 1$$ und es gelte $$\forall m \in \mathbb{N} \colon m \ge n_0 \wedge m < n \Rightarrow T(m) \le c_1 \cdot 2^n$$.
Dann gilt

1\. Fall: $$n = 1$$

$$
\begin{align}
T(1) & = c_1\\
     & = c_1 \cdot 1 & \text{Regel (1): $0 \le c_1 \wedge 1 \le 2$}\\
     & \le c_1 \cdot 2\\
     & = c_1 \cdot 2^1
\end{align}
$$

2\. Fall: $$n = 2$$

$$
\begin{align}
T(2) & = c_1 + T(1) + T(0)\\
     & = c_1 + c_1 + c_1\\
     & = c_1 \cdot 3\\
     & \le c_1 \cdot 4 & \text{Regel (1): $0 \le c_1 \wedge 3 \le 4$}\\
     & = c_1 \cdot 2^2
\end{align}
$$

3\. Fall: $$n > 2$$

$$
\begin{align}
T(n) & = c + T(n - 1) + T(n - 2)\\
     & \le c + c \cdot 2^{n - 1} + T(n - 2) & \text{Regel (2): Induktionshypothese mit $m = n - 1$}\\
     & \le c + c \cdot 2^{n - 1} + c \cdot 2^{n - 2} & \text{Regel (2): Induktionshypothese mit $m = n - 2$}\\
     & \le c + c \cdot 2^{n - 1} + c \cdot 2^{n - 2} + c (2^{n - 2} - 1) & \text{Regel (2): $0 \le c (2^{n - 2} - 1)$}\\
     & = c + c \cdot 2^{n - 1} + c \cdot 2^{n - 2} + c \cdot 2^{n - 2} - c\\
     & = c \cdot 2^{n - 1} + c \cdot 2^{n - 2} + c \cdot 2^{n - 2}\\
     & = c \cdot 2^{n - 1} + 2 \cdot c \cdot 2^{n - 2}\\
     & = c \cdot 2^{n - 1} + c \cdot 2^{n - 1}\\
     & = c \cdot 2^n
\end{align}
$$

Für einen der Schritte benötigen wir die Eigenschaft $$0 \le 2^{n - 2} - 1$$, also $$1 \le 2^{n - 2}$$.
In diesem Fall gilt $$3 \le n$$, also $$1 \le n - 2$$ und somit nach <a href="#figure:le-rules">Regel (4)</a> $$2 = 2^1 \le 2^{n - 2}$$.

Dieser Beweis zeigt, dass die Methode `fib` eine exponentielle Laufzeit hat.


Einschub: Größenordnungen
-------------------------

Wir haben im Kapitel [Komplexität](complexity.md) die obere Schranke kennengelernt.
Dabei handelt es sich, wie der Name schon sagt, aber nur um eine obere Schranke.
Wenn die Laufzeit eines Algorithmus in $$\mathcal{O}(n^2)$$ liegt, kann der Algorithmus zum Beispiel eine lineare Laufzeit haben.
Das heißt, durch den vorherigen Beweis wissen wir nur, dass die Laufzeit von `fib` nicht schlechter als exponentiell ist.
Wir wissen aber nicht, ob die Laufzeit von `fib` vielleicht linear oder quadratisch ist.
Tatsächlich könnte die Laufzeit von `fib` damit immer noch irgendeine polynomielle Laufzeit sein.

Intuitiv möchten wir auch ausdrücken können, dass die Lösung für ein bestimmtes Problem genau exponentiell viele Schritte benötigt.
Um diese Eigenschaft formal auszudrücken, definieren wir zuerst den Begriff der unteren Schranke.


#### Definition 3 (Asymptotische untere Schranke)

Sei $$f \colon \mathbb{N} \rightarrow \mathbb{R}$$.
Dann definieren wir

$$
\Omega(f) := \{ g \colon \mathbb{N} \rightarrow \mathbb{R} \mid f \le_{\text{as}} g \}.
$$

#### Beispiel 3 (Quadratische Komplexität)

Es gilt $$2 n^2 + 3 n \in \Omega(n^2)$$.
Das heißt, $$p \in \Omega(q)$$, wobei $$q(n) = n^2$$ und $$p(n) = 2 n^2 + 3 n$$.
Wir können zum Beispiel $$c = \frac{1}{2}$$ und $$n_0 = 0$$ wählen, denn es gilt die folgende Ungleichung.

$$
\begin{align}
q(n) & = n^2\\
     & \leq n^2 + \frac{3}{2}n && \text{Regel (4): $0 \le \frac{3}{2}n$}\\
     & = \frac{1}{2} \cdot (2 n^2 + 3 n)\\
     & = c \cdot p(n).
\end{align}
$$

Für diese Ungleichung benötigen wir noch $$0 \le \frac{3}{2}n$$.
Es gilt $$0 \le \frac{3}{2}$$ und $$0 \le n$$ und nach Regel (1) gilt somit $$\frac{3}{2} \cdot 0 = 0 \le \frac{3}{2} n$$.

Die Funktion $$p$$ ist sowohl in $$\mathcal{O}(n^2)$$ als auch in $$\Omega(n^2)$$, das heißt, sie ist durch quadratisches Wachstum nach unten und oben beschränkt.
Um auszudrücken, dass eine Funktion zum Beispiel asymptotisch quadratisch wächst, definieren wir den Begriff der scharfen Schranke.

#### Definition 3 (Asymptotisch scharfe Schranke)

Sei $$f \colon \mathbb{N} \rightarrow \mathbb{R}$$.
Dann definieren wir

$$
\Theta(f) := \mathcal{O}(f) \cap \Omega(f).
$$

<!--
Um ein grobes Gefühl für die Laufzeit dieser Methode zu erhalten, erstellen wir wieder eine Wertetabelle.

| $$n$$    | $$T_{\texttt{fib}}(n)$$  | $$2^{n-1}$$
|----------|-------------------------:|-----------------:|
| 0        | $$c$$                    | $$\frac{1}{2}$$  |
| 1        | $$c$$                    | 1                |
| 2        | $$c + c + c = 3c$$       | 2                |
| 3        | $$c + 3c + c = 5c$$      | 2,58             |
| 4        | $$c + 5c + 3c = 9c$$     | 3                |
| 5        | $$c + 9c + 5c = 15c$$    | 3,32             |
| 6        | $$c + 15c + 9c = 25c$$   | 3,58             |
| 7        | $$c + 25c + 15c = 41c$$  | 3,80             |
| 8        | $$c + 41c + 25c = 67c$$  | 4                |
| 9        | $$4 c_2 + c_1$$                  | 4,16             |
-->

<!--
Laufzeit mit dynamischer Programmierung
---------------------------------------

Der vorherige Abschnitt zeigt, dass wir jetzt eigentlich nur wissen, dass die Laufzeit der naiven Implementierung von `fib` zumindest nicht noch schlechter als exponentiell ist.
Über einen Zusammenhang zwischen der Fibonacci-Sequenz und dem goldenen Schnitt lässt sich zeigen, dass die Laufzeit von `fib` tatsächlich in $$\Theta(\phi^n)$$ liegt, wobei $$\phi = \frac{1 + \sqrt{5}}{2}$$.
An dieser Stelle soll noch erwähnt werden, dass im Gegensatz zu den Logarithmen die exponentiellen Funktionen nicht alle in der gleichen Größenordnung liegen.
Das heißt, dass $$\mathcal{O}(\phi^n)$$ zum Beispiel nicht die gleiche Menge von Funktionen beschreibt wie $$\mathcal{O}(2^n)$$.
Somit ist die Abschätzung, dass die Laufzeit von `fib` in $$\mathcal{O}(2^n)$$ liegt, tatsächlich eine ungenaue Abschätzung.


Nachdem wir gesehen haben, dass die Laufzeit der naiven Implementierung von `fib` exponentiell ist, wollen wir uns aber noch einmal Gedanken über die Laufzeit der Variante mit dynamischer Programmierung machen.
Um die Laufzeit eines Algorithmus mit dynamischer Programmierung zu analysieren, betrachtet man den Graph der Teilprobleme.
Dabei ist ein Graph eine Datenstruktur, die mit einem Baum verwandt ist.
Ein Graph besteht aus Knoten und Kanten.
Eine Kante verbindet dabei zwei Knoten.

<figure id="figure:fibDyn-subproblems" markdown="1">

![](/assets/graphics/fibDyn-subproblems.svg){: width="25%" .centered}

<figcaption>Abbildung 5: Teilprobleme für <code class="language-plaintext highlighter-rouge">fibDyn(5)</code></figcaption>
</figure>
-->

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="recursion.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"></li>
    </ul>
</div>
{% include bottom-nav.html previous="recurion.html" %}
