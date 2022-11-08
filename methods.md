---
layout: post
title: "Algorithmische Methoden"
---

In diesem Kapitel werden Methoden vorgestellt, die genutzt werden können, um Algorithmen zu formulieren.
Zu jeder Methode werden wir uns auch einen Beispielalgorithmus anschauen, der Gebrauch von der jeweiligen Methode macht.

Rekursion
---------

Bei der Verwendung von Rekursion zerlegt man ein Problem in ein kleineres Problem, welches man wiederum mit der gleichen Methode löst.
Ein klassisches Beispiel für die Verwendung von Rekursion ist die Definition der Fakultät.

$$\begin{aligned}
& !\colon \mathbb{N} \to \mathbb{N}\\\\
& n! = \begin{cases}
  1 & \mbox{falls}~n = 0\\\\
  n (n - 1)! & \mbox{sonst}
\end{cases}
\end{aligned}$$

Wir können diese mathematische Definition direkt in ein Java-Programm überführen.

``` java
static int fac(int n) {
    if (n <= 0) {
        return 1;
    } else {
        return n * fac(n - 1);
    }
}
```

Wenn man eine Implementierung in Form einer Schleife in einer rekursive Methode überführen möchte, muss man ggf. eine rekursive Hilfsmethode nutzen und ein Methodenargument einführen, welches dem Zähler der Schleife entspricht.
Wir betrachten die folgende artifizielle Methode, welche die Zahlen von `1` bis `100` aufsummiert.

```java
static int sum() {
    var result = 0;
    for (int i = 1; i <= 100; i++) {
        result += i;
    }
    return result;
}
```

Wenn wir diese Methode mit Hilfe von Rekursion implementieren möchten, müssen wir eine Hilfsmethode mit einem Argument einführen.
Dieses Argument wird genutzt, um zu speichern, an welcher Stelle sich die Rekursion aktuell befindet.
Die folgende rekursive Implementierung nutzt das Argument `start`, um den Zähler der Schleife zu modellieren.

```java
static int sumRec() {
    return sumRec(1);
}

private static int sumRec(int start) {
    if (start > 100) {
        return 0;
    } else {
        return start + sumRec(start + 1);
    }
}
```

Wir wollen uns an dieser Stelle auch einmal Gedanken über die Laufzeit der Methode `fac` machen. Um die Laufzeit einer Methode zu beschreiben, nutzt man ebenfalls häufig Rekursion. 
Genauer gesagt gibt man eine sogenannte Rekurrenz an, eine rekursive mathematische Funktion, welche die Laufzeit der Methode beschreibt. Dieses Verfahren wollen wir einmal an Hand der Methode `fac` illustrieren.
Die Größe des Problems ist im Fall der Berechnung der Fakultät die Größe der Zahl, für die wir die Fakultät berechnen.

In Abschnitt [Konkrete Laufzeiten](complexity.md#konkrete-laufzeiten) haben die Anzahl an Schritten, die eine Methode durchführt, zuerst genau gezählt.
Später haben wir aber gelernt, dass es auf die genaue Anzahl der Schritte gar nicht ankommt, wenn wir die Größenordnung einer Laufzeit bestimmen wollen.
Daher berechnen wir hier nicht mehr die genauen Laufzeiten.
Es ist unerheblich, ob die Methode, zum Beispiel, 3 oder 5 Schritte durchführt, so lange es sich um eine konstante Anzahl an Schritten handelt.
Daher nutzen wir hier für konstante Anzahlen an Schritten keine konkrete Zahl mehr, sondern führen einen Platzhalter ein, der für die konkrete Anzahl steht.
Wir wollen dieses Vorgehen einmal am Beispiel der Methode `fac` durchführen.
Die folgende Rekurrenz beschreibt die Anzahl an Schritten, welche die Methode `fac` durchführt.

$$
\begin{align}
T_{\texttt{fac}} & : \mathbb{N} \rightarrow \mathbb{R}\\
T_{\texttt{fac}} & (n)= \begin{cases}
  c_1                       & \text{falls}~n = 0\\\\
  c_2 + T_{\texttt{fac}}(n - 1) & \text{sonst}
\end{cases}
\end{align}
$$

Um dann zu bestimmen, welche Laufzeit eine Methode hat, müssen wir für die Rekurrenz eine geschlossene Form finden, das heißt, eine mathematische Funktion, die die gleiche Funktion beschreibt, aber keine Rekursion mehr verwendet.
Die Funktion $$T_{\texttt{fac}}$$ wird durch die folgende geschlossene Form beschrieben.

$$T_{\texttt{fac}}(n) = \sum_{i = 1}^n c_2 + c_1 = c_2 n + c_1$$

Um Summen wie die obige zu vereinfachen, gibt es eine Reihe von Regeln.
In diesem Fall verwenden wir zum Beispiel Regel $$(\ref{eqn:constant})$$ und Regel $$(\ref{eqn:shift})$$ an, um unsere Formel zu vereinfachen.
Klassischerweise beweist man mit Hilfe einer Induktion, dass die geschlossene Form die gleichen Ergebnisse liefert wie die Rekurrenz.
Auf diesen Schritt verzichten wir an dieser Stell aber.
Mit Hilfe des [vorherigen Kapitels](complexity.md) wissen wir, dass die Funktion $$T_{\texttt{fac}}$$ in $$\mathcal{O}(n)$$ ist. Das heißt, die Laufzeit der Methode `fac` ist linear.

<figure id="figure:rules">

$$\begin{align}
\sum_{i = 0}^{n - 1} c &= c n\tag{1}\label{eqn:constant}\\\\
\sum_{i = 1}^{n} x_i &= \sum_{i = 0}^{n - 1} x_{i + 1}\tag{2}\label{eqn:shift}\\\\
\sum_{i = 0}^{n - 1} c x_i &= c \sum_{i = 0}^{n - 1} x_i\tag{3}\label{eqn:distributivity}\\\\
\sum_{i = 0}^{n - 1} (x_i + y_i) &= \sum_{i = 0}^{n - 1} x_i + \sum_{i = 0}^{n - 1} y_i\tag{4}\label{eqn:associativity}\\\\
\sum_{i = 0}^{n - 1} i &= \frac{n (n - 1)}{2}\tag{5}\label{eqn:gauß}
\end{align}$$

<figcaption>Abbildung 1: Regeln zur Umformung von Gleichungen</figcaption>
</figure>

Einschub: Bestimmung der Laufzeit
---------------------------------

Wir wollen an dieser Stelle einen kurzen Einschub machen und die Technik, die wir gerade angewendet haben, noch an einem weiteren Beispiel illustrieren.
Wir können diese Technik nicht nur bei rekursiven Methoden anwenden, sondern auch bei Methoden, die Schleifen nutzen.
Um die Verwendung zu illustrieren, betrachten wir die Implementierung der folgenden Methode, die alle Einträge einer einfach verketteten Liste in ein Array kopiert.

``` java
static Integer[] toArray(SLList<Integer> list) {
    var array = new Integer[list.size()];
    for (int i = 0; i < array.length; i++) {
        array[i] = list.get(i);
    }
    return array;
}
```

Wir wollen einmal die Laufzeit von `toArray` analysieren.
Dazu betrachten wir die Implementierung der Methode `get` in einer einfach verketteten Liste.

``` java
private Node<T> nodeAt(int index) {
    var current = this.first;
    for (int i = 0; i < index; i++) {
        current = current.next;
    }
    return current;
}

public T get(int index) {
    return nodeAt(index).value;
}
```

Zuerst bestimmen wir die Laufzeit der Methode `nodeAt`.
In diesem Fall übergeben wir als Argument den Index, den wir suchen.

$$T_{\texttt{nodeAt}}(i) = \sum_{j = 0}^{i - 1} c_1 + c_2 \overset{\text{Regel}~(\ref{eqn:constant})}= c_1i + c_2$$

Die Variable *c*<sub>1</sub> steht für die Schritte, die vor und nach der Ausführung der Schleife durchgeführt werden müssen.
Wir wissen nicht genau, wie viele Schritte es sind, es handelt sich aber um eine konstante Anzahl.
Die Variable *c*<sub>2</sub> steht für die konstante Anzahl an Schritten, die in jedem Durchlauf der Schleife durchgeführt werden.

Mit Hilfe der Laufzeit für die Methode `nodeAt` können wir nun die
Laufzeit der Methode `get` bestimmen.

$$T_{\texttt{get}}(i) = T_{\texttt{nodeAt}}(i) + c_3 = c_1i + c_2 + c_3$$

Mit Hilfe dieser Vorarbeiten können wir nun die Laufzeit der Methode `toArray` bestimmen.
Das Argument der Funktion $$T_{\texttt{toArray}}$$ ist in diesem Fall die Länge der Liste.

$$\begin{align}
T_{\texttt{toArray}}(n) &= \sum_{i = 0}^{n - 1} (c_4 + T_{\texttt{get}}(i)) + c_5 \tag{Regel (\ref{eqn:associativity})}\\\\
& = \sum_{i = 0}^{n - 1} c_4 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_5 \tag{Regel (\ref{eqn:constant})}\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) \tag{Definition $T_{\texttt{get}}$} + c_5\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} (c_1 i + c_2 + c_3) \tag{Regel (\ref{eqn:associativity})} + c_5\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} i c_1 + \sum_{i = 0}^{n - 1} (c_2 + c_3) + c_5 \tag{Regel (\ref{eqn:constant})}\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} i c_1 + (c_2 + c_3)n + c_5\tag{Regel (\ref{eqn:distributivity})}\\\\
& = n c_4 + c_1 \sum_{i = 0}^{n - 1} i + (c_2 + c_3)n + c_5\tag{Regel (\ref{eqn:gauß})}\\\\
& = n c_4 + c_1 \frac{n(n - 1)}{2} + (c_1 + c_3)n + c_5\\\\
& = n c_4 + c_1 \left(\frac{1}{2} n^2 - \frac{1}{2} n\right) + (c_2 + c_3)n + c_5\\\\
& = n c_4 + c_1 \frac{1}{2} n^2 - c_1 \frac{1}{2} n + (c_2 + c_3)n + c_5\\\\
& = \frac{1}{2} c_1 n^2 + \left(- \frac{1}{2} c_1 + c_2 + c_3 + c_4\right) n + c_5
\end{align}$$

Analog zu den Beweisen aus dem Kapitel [Komplexität](complexity.md) können wir mit dieser Information zeigen, dass $$T_{\texttt{toArray}} \le_{as} q$$ gilt, wobei $$q : \mathbb{N} \rightarrow \mathbb{R}$$, $$q(x) = x^2$$.
Diese Argumentation zeigt etwas formaler als wir es zuvor durchgeführt haben, dass die Laufzeit von `toArray` in $$\mathcal{O}(n^2)$$ liegt, wobei $$n$$ die Länge der Liste ist.

<!--

Divide and Conquer
------------------

Bei der *Divide and Conquer*-Methode wird ein Problem in mehrere
kleinere Probleme zerlegt. Im Gegensatz zur Rekursion wird ein Problem
dabei mindestens in zwei Teilprobleme zerlegt. Auf diese Weise erhält
man sehr effiziente Algorithmen, wie wir im Folgenden sehen werden.

Wir wollen im Folgenden das Prinzip der binären Suche betrachten. Dazu
nehmen wir an, dass wir ein Array mit aufsteigend sortierten Zahlen
gegeben haben. Wir wollen testen, ob dieses Array eine gegebene Zahl
enthält. Wenn wir ein Array gegeben haben, dessen Einträge bereits
aufsteigend sortiert sind und wir suchen einen bestimmten Eintrag, so
können wir dieses Problem mit Hilfe einer binären Suche lösen. Bei der
binären Suche schaut man sich zuerst den Eintrag in der Mitte des Arrays
an. Falls dieser Eintrag dem Wert entspricht, den wir suchen, sind wir
fertig. Falls der Eintrag in der Mitte kleiner ist als der Wert, den wir
suchen, wissen wir, dass wir mit der ersten Hälfte des Arrays fortfahren
können. Sollte das Element in der Mitte des Arrays bereits größer sein
als der Wert, den wir suchen, so fahren wir mit der zweiten Hälfte des
Arrays fort. In der neubestimmten Hälfte des Arrays suchen wir wiederum
mit Hilfe einer binären Suchen nach dem gesuchten Wert. Auf diese Weise
können wir bei jedem Schritt im schlechtesten Fall die Hälfte der
Elemente ignorieren.

``` java
static boolean binarySearch(int[] array, int value) {
    boolean found = false;
    int start = 0;
    int end = array.length - 1;

    while (start <= end && !found) {
        int mid = start + (end - start) / 2;
        int midValue = array[mid];
        if (value < midValue) {
            end = mid - 1;
        } else if (value > midValue) {
            start = mid + 1;
        } else {
            found = true;
        }
    }
    return found;
}
```

Wir wollen uns jetzt einmal überlegen, in welcher Größenordnung die
Laufzeit der Methode `binarySearch` im *worst case* ist. Die Methode
nutzt zwar eine Schleife, es handelt sich aber nicht um eine einfache
Zählschleife. Aus diesem Grund können wir den Aufwand der Schleife auch
nicht einfach durch eine Summe beschreiben. Stattdessen nutzen wir zur
Beschreibung der Laufzeit auch hier eine Rekurrenz. Wir definieren dazu
eine rekursive Funktion $T_{\texttt{binarySearch}}$, welche
die Anzahl an Schritten beschreibt, welche die Methode `binarySearch` im
*worst case* durchführt. Das Argument der Funktion ist die Größe des
Arrayabschnitts, den die Methode noch bearbeiten muss.

$$T_{\texttt{binarySearch}}(n) = \begin{cases}
  c_1                                           & \text{falls}\~n = 0\\\\
  c_2 + T_{\texttt{binarySearch}}(\frac{n - 1}{2})  & \text{falls}\~n\~\text{ungerade}\\\\
  c_2 + T_{\texttt{binarySearch}}(\frac{n}{2})        & \text{sonst}
\end{cases}$$

Es sei *n* die Anzahl der Elemente, die wir noch durchsuchen müssen. Bei
einer ungeraden Anzahl von Elementen prüfen wir die Mitte und erhalten
dann noch eine gerade Anzahl von Elementen, nämlich *n* − 1 Elemente.
Diese gerade Anzahl teilen wir in zwei gleich große Teile. Bei einer
geraden Anzahl von Elementen prüfen wir ebenfalls die Mitte und erhalten
eine ungerade Anzahl von Elementen, nämlich *n* − 1 Elemente. Da wir den
schlechtesten Fall betrachten, gehen wir davon aus, dass wir jeweils im
größeren der beiden Teile weitersuchen. Wir müssen also noch
$\lceil \frac{n - 1}{2} \rceil$ Elemente durchsuchen. Dies entspricht
einfach der Zahl $\frac{n}{2}$.

In der folgenden Tabelle sind die Werte von
$T_{\texttt{binarySearch}}$ sowie die Werte der Funktion
log<sub>2</sub>*n* + 1 aufgelistet.
$$\begin{array}{lll}
n & T_{\texttt{binarySearch}}(n) & \log_2 n + 1\\\\
\toprule
0 & c_1         & -\\\\
1 & c_2 + c_1   & 1\\\\
2 & 2 c_2 + c_1 & 2\\\\
3 & 2 c_2 + c_1 & 2,58\\\\
4 & 3 c_2 + c_1 & 3\\\\
5 & 3 c_2 + c_1 & 3,32\\\\
6 & 3 c_2 + c_1 & 3,58\\\\
7 & 3 c_2 + c_1 & 3,80\\\\
8 & 4 c_2 + c_1 & 4\\\\
9 & 4 c_2 + c_1 & 4,16\\\\
\end{array}$$
Wir sehen hier, dass der Faktor vor der Konstanten *c*<sub>2</sub> durch
log<sub>2</sub>*n* + 1 jeweils überschätzt wird. Mit Hilfe einer
Induktion lässt sich die folgende Eigenschaft für alle *n* ≥ 1 zeigen.
$$T_{\texttt{binarySearch}}(n) \le (\log_2 n + 1) c_2 + c_1 = c_2 \log_2 n + c_2 + c_1$$
Das heißt, dass die *worst case*-Laufzeit der Methode `binarySearch` in
𝒪log<sub>2</sub>*n* liegt.

Alle Logarithmen sind in der gleichen Größenordnung. Dies lässt sich
einfach zeigen, wenn man sich überlegt, wie sich der Logarithmus einer
Basis mit Hilfe des Logarithmus einer anderen Basis ausdrücken lässt.
Für zwei Basen *b*<sub>1</sub> und *b*<sub>2</sub> gilt der folgende
Zusammenhang.
$$\log_{b_1} x = \frac{\log_{b_2} x}{\log_{b_2} b_1}.$$
Daher ist die Laufzeit der binären Suche sowohl in 𝒪log<sub>2</sub>*n*
als auch in 𝒪log *n*. Als kanonischen Repräsentanten wählt man für
Logarithmen den Logarithmus zur Basis 10, also log *n*.

Es gibt eine ganze Reihe von Algorithmen, die auf der Idee basieren, ein
Problem in zwei Teilprobleme gleicher Größe zu zerlegen. Man nennt
diesen Ansatz zur Lösung eines Problems *Teile & Herrsche (Divide &
Conquer)*. Diese Algorithmen haben meistens einen logarithmischen Faktor
in ihrer Laufzeit.

Dynamische Programmierung
-------------------------

Um die Methode der dynamischen Programmierung zu motivieren, die wir uns
im Folgenden anschauen, wollen wir uns noch ein weiteres einfaches
Beispiel für einen rekursiven Algorithmus anschauen. Die folgende
Funktion berechnet zu einem *n* ∈ ℕ die sogenannte Fibonacci-Zahl.

$$\begin{aligned}
& F\colon \ensuremath{\mathbb{N}} \to \ensuremath{\mathbb{N}}\\\\
& F(n) = \begin{cases}
  0 & \mbox{falls}\~n = 0\\\\
  1 & \mbox{falls}\~n = 1\\\\
  F(n-1) + F(n-2) & \mbox{sonst}
\end{cases}
\end{aligned}$$
Wir können diese Funktion ebenfalls rekursiv in Java implementieren.

``` java
static int fib(int n) {
    if (n <= 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}
```

Wir wollen uns einmal anschauen, welche Aufrufe der Methode `fib` für
den Aufruf `fib(5)` durchgeführt werden.

<a href="#figure:fib-calls" data-reference-type="autoref"
data-reference="figure:fib-calls">[figure:fib-calls]</a> zeigt, dass
viele Aufrufe der Methode `fib` mehrfach durchgeführt werden. Mit Hilfe
der dynamischen Programmierung können wir die mehrfache Berechnung
dieser Werte vermeiden.

Bei der dynamischen Programmierung ist die Idee, dass man bereits
berechnete Werte speichert und nachschlägt, wenn man die Werte ein
weiteres Mal benötigt. Wir können diese Methode nutzen, um die
Berechnung einer Fibonacci-Zahl effizienter durchzuführen. Um uns die
Mehrfachberechnungen zu sparen, merken wir uns einfach die bereits
berechneten Werte in einem Array.

``` java
static int fibDyn(int n) {
    Integer[] memo = new Integer[n + 1];
    return fibDyn(memo, n);
}

static int fibDyn(Integer[] memo, int n) {
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

Die folgende Abbildung zeigt die Aufrufstruktur mit Hilfe der
dynamischen Programmierung. Um zu verstehen, wie die Aufrufe im Array
`memo` nachgeschlagen werden, müssen wir wissen, dass Java die Argumente
einer Methode von links nach rechts auswertet. Das heißt, beim Aufruf
`fibDyn(memo, n - 1) + fibDyn(memo, n - 2)` wird der Aufruf
`fibDyn(memo, n - 1)` ausgeführt bevor der Aufruf `fibDyn(memo, n - 2)`
ausgeführt wird.

Da wir die ersten beiden Einträge des Arrays gar nicht verwenden, können
wir den Speicherverbrauch der Implementierung noch optimieren, indem wir
ein Array der Größe `n - 1` anlegen und jeweils `fibs[n - 2]` nutzen.
Diese Implementierung hat aber den Nachteil, dass sie schwieriger zu
verstehen ist.

Backtracking
------------

Wir wollen als nächstes eine algorithmische Methode anschauen, die ein
Problem löst, indem sie alle Möglichkeiten ausprobiert. Diese Methode
wird als *Backtracking* bezeichnet. Das Backtracking durchsucht einen
Raum von Lösungen systematisch. Dabei kann man sich das Vorgehen als
Baumstrukutur illustrieren. Häufig durchsucht man beim *Backtracking*
den Raum aller Lösungen nicht komplett sondern nutzt zusätzliche
Informationen über das Problem, um effizienter eine Lösung zu finden.

Als Beispiel für eine Anwendung von *Backtracking* wollen wir das
*subset sum*-Problem lösen. Bei diesem Problem ist eine Sequenz mit
Zahlen und eine weitere Zahl gegeben. Wir wollen jetzt herausfinden, ob
es eine Teilsequenz gibt, deren Summe genau der gegebenen Zahl
entspricht. Wir schauen erst einmal die Implementierung der Methode an
und diskutieren danach die einzelnen Komponenten.

``` java
public static boolean subsetsum(int[] array, int sum) {
    return subsetsum(array, sum, 0);
}

private static boolean subsetsum(int[] array, int sum, int index) {
    if (sum == 0) {
        return true;
    } else if (index >= array.length || sum < 0) {
        return false;
    } else {
        return subsetsum(array, sum - array[index], index + 1)
               || subsetsum(array, sum, index + 1);
    }
}
```

Diese Methode probiert alle Möglichkeiten mit Hilfe von Rekursion aus.
Dabei werden alle Möglichkeiten erzeugt, indem für jeden Eintrag des
Arrays immer zwei Möglichkeiten ausprobiert werden. Einmal wird das
Element zur Summe hinzugerechnet und einmal wird das Element nicht zur
Summe hinzugerechnet. Falls der erste Aufruf, also
`subsetsum(array, sum - array[index], index + 1)` als Ergebnis `false`
liefert, wird auch noch die Alternative, nämlich
`subsetsum(array, sum, index + 1)` ausprobiert.

<a href="#figure:subsetsum-calls" data-reference-type="ref"
data-reference="figure:subsetsum-calls">[figure:subsetsum-calls]</a>
zeigt die Aufruf der Methode `subsetsum` mit dem Array `[2, 1, 5, 4]`.
Die Argumente, die im Baum angegeben sind, sind die noch übrige Summe
und der aktuelle Index. -->

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="complexity.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"></li>
    </ul>
</div>