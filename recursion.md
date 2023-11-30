---
layout: post
title: "Rekursion"
---

In diesem und den folgenden Kapiteln werden Methoden vorgestellt, die genutzt werden können, um Algorithmen zu formulieren.
Zu jeder Methode werden wir in den darauffolgenden Kapiteln auch einen Beispielalgorithmus sehen, der Gebrauch von der jeweiligen Methode macht.

Beispiele
---------

Bei der Verwendung von Rekursion zerlegt man ein Problem in ein kleineres Problem, welches man wiederum mit der gleichen Methode löst.
Ein klassisches Beispiel für die Verwendung von Rekursion ist die Definition der Fakultät.

$$\begin{align}
& !\colon \mathbb{N} \to \mathbb{N}\\\\
& n! = \begin{cases}
  1 & \mbox{falls}~n = 0\\\\
  n (n - 1)! & \mbox{sonst}
\end{cases}
\end{align}$$

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

Wenn wir diese Methode mithilfe von Rekursion implementieren möchten, müssen wir eine Hilfsmethode mit einem Argument einführen.
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

Die Verwendung von Rekursion ist erst einmal sehr ungewohnt, wenn man zuvor nur in Schleifen gedacht hat.
Bei der Entwicklung einer rekursiven Methode nimmt man im Grunde an, dass die Methode bereits für größere bzw. kleinere Argumente korrekt funktioniert.
Das heißt, wenn wir eine rekursive Methode `sumRec` schreiben wollen, gehen wir davon aus, dass es bereits eine rekursive Methode `sumRec` gibt, die für größere Argumente korrekt funktioniert.
Wir müssen uns dabei insbesondere klar werden, was es bedeutet, dass die Methode "korrekt funktioniert".
Im Fall der Methode `sumRec` gehen wir davon aus, dass es bereits eine Methode gibt, die startend mit dem Argument `start + 1` in der Lage ist, alle Zahlen bis einschließlich `100` aufzusummieren.
Nun überlegen wir uns, wie wir die Methode `sumRec` implementieren können, indem wir die Methode rekursiv verwenden.
Das heißt, wir überlegen uns, wie wir die Summe `start + (start + 1) + ... + 100` berechnen können.
Wir haben gesagt, wir gehen davon aus, dass die Methode `sumRec` für das Argument `start + 1` korrekt funktioniert.
Das heißt, wir wissen, dass der Aufruf `sumRec(start + 1)` die Summe `(start + 1) + ... + 100` berechnet.
Unser ursprünglicher Aufruf von `sumRec(int start)` soll aber die Summe `start + (start + 1) + ... + 100` berechnen.
Das heißt, wir müssen nur den Aufruf `sumRec(start + 1)` durchführen und auf das Ergebnis noch den Wert `start` hinzuaddieren.

Die Methoden `fac` und `sumRec` implementieren recht einfache Rekursionsmuster.
In beiden Methoden gibt es zum Beispiel nur einen rekursiven Aufruf.
Um zu illustrieren, dass es bei rekursiven Methoden auch mehrere rekursive Aufrufe geben kann, betrachten wird die Fibonacci-Sequenz.
Die Sequenz der Fibonacci-Zahlen kann durch die folgende Funktion definiert werden.

$$\begin{align}
& F\colon \mathbb{N} \to \mathbb{N}\\\\
& F(n) = \begin{cases}
  0 & \mbox{falls}~n = 0\\\\
  1 & \mbox{falls}~n = 1\\\\
  F(n-1) + F(n-2) & \mbox{sonst}
\end{cases}
\end{align}$$

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

Im Gegensatz zu den Methoden `fac` und `sumRec` wird die Methode `fib` zweimal rekursiv aufgerufen.


Rekurrenzen
-----------

Wir wollen uns an dieser Stelle auch einmal Gedanken über die Laufzeit unserer Methoden machen. Um die Laufzeit einer Methode zu beschreiben, nutzt man ebenfalls häufig Rekursion. 
Genauer gesagt gibt man eine sogenannte Rekurrenz an, eine rekursive mathematische Funktion, welche die Laufzeit der Methode beschreibt. Dieses Verfahren wollen wir einmal anhand der Methode `fac` illustrieren.
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

$$T_{\texttt{fac}}(n) = c_2 n + c_1$$

Wenn wir eine solche geschlossene Form gefunden haben, können wir mithilfe einer Induktion beweisen, dass die beiden Varianten die gleichen Werte berechnen.

Die klassische Induktion hat die folgende Form.

$$
\begin{align}
& \operatorname{A}(0) \wedge \forall n \in \mathbb{N} \colon \operatorname{A}(n)\Rightarrow \operatorname{A}(n+1)\\
& \Rightarrow\\
& \forall n \in \mathbb{N} \colon \operatorname{A}(n)
\end{align}
$$

Dabei ist $$\operatorname{A}$$ die Aussage, die wir beweisen wollen.
Die logische Formel $$\operatorname{A}(0)$$ bedeutet, dass die Aussage, die wir beweisen wollen, für den Wert $$0$$ gilt.
Das heißt, insgesamt wenden wir die Induktion an, indem wir zeigen, dass die Aussage für $$0$$ gilt.
Außerdem müssen wir zeigen, dass wir für jedes $$n \in \mathbb{N}$$ aus der Gültigkeit von $$\operatorname{A}(n)$$ die Gültigkeit von $$\operatorname{A}(n+1)$$ zeigen können.
Wenn wir diese beiden Tatsachen gezeigt haben, erhalten wir

$$\forall n \in \mathbb{N} \colon \operatorname{A}(n),$$

also, dass die Aussage für alle natürlichen Zahlen gilt.

Wir wollen mithilfe der klassischen Induktion jetzt die oben angegebene geschlossene Form der Laufzeit von `fac` beweisen.

**Behauptung:** $$\forall n \in \mathbb{N}: T_{\texttt{fac}}(n) = c_2 n + c_1$$.

**Beweis:**

Wir beweisen die Aussage per Induktion.

Induktionsstart:

Es gilt

$$
T_{\texttt{fac}}(0) = c_1 = c_2 \cdot 0 + c_1
$$

Induktionsschritt:

Sei $$n \in \mathbb{N}$$ und es gelte $$T_{\texttt{fac}}(n) = c_2 n + c_1$$.
Dann gilt

$$
\begin{align*}
T_{\texttt{fac}}(n + 1) & = c_2 + T_{\texttt{fac}}(n)\\\\
                        & = c_2 + n c_ 2 + c_1\\\\
                        & = (n + 1) c_2 + c_1
\end{align*}
$$

Dieser Schritt zeigt die Behauptung.

Mithilfe des [vorherigen Kapitels](complexity.md) wissen wir, dass die Funktion $$T_{\texttt{fac}}$$ in $$\mathcal{O}(n)$$ ist. Das heißt, die Laufzeit der Methode `fac` ist linear.


Bestimmung von Laufzeiten
-------------------------

Nachdem wir gesehen haben, wie wir die Laufzeiten von rekursiven Methoden etwas formaler bestimmen können, wollen wir uns Methoden anschauen, die klassisch mit einer Schleife implementiert sind.
Wir führen auch bei Methoden, die mit einer Schleife implementiert sind, Konstanten ein, um davon zu abstrahieren, wie viele konstante Schritte ein Stück Code genau ausführt.
Die Laufzeit einer rekursiven Methode haben wir durch eine rekursive Funktion modelliert.
Die Laufzeit einer einfachen Zählschleife werden wir durch eine mathematische Summe modellieren.
Dadurch erhalten wir als Laufzeit für eine Methode mit Schleife eine Funktion, die mehrere mathematische Summen nutzt.
Wir müssen diese Funktion dann in den meisten Fällen noch in die Form eines Polynoms bringen, um zu bestimmen, in welcher Größenordnung die Laufzeit einer Methode ist.
Um Summen zu vereinfachen verwenden wir eine Reihe von Regeln, die in [Abbildung 1](#figure:rules) zu sehen sind.
Um die Regeln nicht unnötig unübersichtlich zu machen, verzichten wir an dieser Stelle darauf, die Quantifizierung der Variablen anzugeben.
In den Regeln in [Abbildung 1](#figure:rules) sind alle freien Variablen allquantifiziert.

<figure id="figure:rules">

$$\begin{align}
\sum_{i = k}^{n} c &= c (n - k + 1) \tag{1}\label{eqn:constant}\\\\
\sum_{i = k}^{n} c x_i &= c \sum_{i = k}^{n} x_i\tag{2}\label{eqn:distributivity}\\\\
\sum_{i = k}^{n} (x_i + y_i) &= \sum_{i = k}^{n} x_i + \sum_{i = k}^{n} y_i\tag{3}\label{eqn:associativity}\\\\
\sum_{i = 0}^{n} i &= \frac{1}{2} n (n + 1)\tag{4}\label{eqn:gauß}
\end{align}$$

<figcaption>Abbildung 1: Regeln zur Umformung von Gleichungen</figcaption>
</figure>

Um die Verwendung dieser Regeln zu illustrieren, betrachten wir die Implementierung der folgenden Methode, die alle Einträge einer einfach verketteten Liste in ein Array kopiert.

``` java
static Integer[] toArray(SLList<Integer> list) {
    var array = new Integer[list.size()];
    for (int i = 0; i < list.size(); i++) {
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
        current = current.next();
    }
    return current;
}

public T get(int index) {
    return nodeAt(index).value();
}
```

Zuerst bestimmen wir die Laufzeit der Methode `nodeAt`.
In diesem Fall übergeben wir als Argument den Index, den wir suchen.

$$T_{\texttt{nodeAt}}(i) = \sum_{j = 0}^{i - 1} c_1 + c_2 \overset{\text{Regel}~(\ref{eqn:constant})}= c_1(i - 1 - 0 + 1) + c_2 = c_1i + c_2$$

Die Variable $$c_2$$ steht für die Schritte, die vor und nach der Ausführung der Schleife durchgeführt werden müssen.
Wir wissen nicht genau, wie viele Schritte es sind, es handelt sich aber um eine konstante Anzahl.
Die Variable $$c_1$$ steht für die konstante Anzahl an Schritten, die in jedem Durchlauf der Schleife durchgeführt werden.

Mithilfe der Laufzeit für die Methode `nodeAt` können wir nun die Laufzeit der Methode `get` bestimmen.

$$T_{\texttt{get}}(i) = T_{\texttt{nodeAt}}(i) + c_3 = c_1i + c_2 + c_3$$

Mithilfe dieser Vorarbeiten können wir nun die Laufzeit der Methode `toArray` bestimmen.
Das Argument der Funktion $$T_{\texttt{toArray}}$$ ist in diesem Fall die Länge der Liste.
Die Initialisierung eines Arrays hat in Java eine lineare Laufzeit in der Größe des Arrays.
An dieser Stelle soll der Fokus aber auf dem Aufwand sein, die durch die Verwendung der Schleife entsteht.
Daher ignorieren wir im Folgenden die Laufzeit der Initialisierung des Arrays, obwohl wir damit die Laufzeit der Methode `toArray` eigentlich nicht korrekt berechnen.
Das heißt, aus didaktischen Gründen verzichten wir auf die korrekte Berechnung der Laufzeit.

Wir nutzen nun die Vorarbeiten, um die Laufzeit der Methode `toArray` zu bestimmen.

$$\begin{align}
T_{\texttt{toArray}}(n) &= \sum_{i = 0}^{n - 1} (c_4 + T_{\texttt{get}}(i)) + c_5 & \text{Regel (\ref{eqn:associativity})}\\\\
& = \sum_{i = 0}^{n - 1} c_4 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_5 & \text{Regel (\ref{eqn:constant})}\\\\
& = (n - 1 - 0 + 1) c_4 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_5\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_5 & \text{Definition $T_{\texttt{get}}$}\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} (c_1 i + c_2 + c_3) + c_5 & \text{Regel (\ref{eqn:associativity})}\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} c_1 i + \sum_{i = 0}^{n - 1} (c_2 + c_3) + c_5 & \text{Regel (\ref{eqn:constant})}\\\\
& = n c_4 + \sum_{i = 0}^{n - 1} c_1 i + (c_2 + c_3)n + c_5 & \text{Regel (\ref{eqn:distributivity})}\\\\
& = n c_4 + c_1 \sum_{i = 0}^{n - 1} i + (c_2 + c_3)n + c_5 & \text{Regel (\ref{eqn:gauß})}\\\\
& = n c_4 + c_1 \frac{1}{2} (n - 1)(n - 1 + 1) + (c_2 + c_3)n + c_5\\\\
& = n c_4 + c_1 \frac{1}{2} (n - 1)n + (c_2 + c_3)n + c_5\\\\
& = n c_4 + c_1 \frac{1}{2} (n^2 - n) + (c_2 + c_3)n + c_5\\\\
& = n c_4 + c_1 \frac{1}{2} n^2 - c_1 \frac{1}{2} n + (c_2 + c_3)n + c_5\\\\
& = \frac{1}{2} c_1 n^2 + \left(- \frac{1}{2} c_1 + c_2 + c_3 + c_4 \right) n + c_5
\end{align}$$

Analog zu den Beweisen aus dem Kapitel [Komplexität](complexity.md) können wir mit dieser Information zeigen, dass $$T_{\texttt{toArray}} \le_{as} q$$ gilt, wobei $$q : \mathbb{N} \rightarrow \mathbb{R}$$, $$q(x) = x^2$$.
Diese Argumentation zeigt etwas formaler als wir es zuvor durchgeführt haben, dass die Laufzeit von `toArray` in $$\mathcal{O}(n^2)$$ liegt, wobei $$n$$ die Länge der Liste ist.

Als weiteres Beispiel wollen wir uns die folgende Methode anschauen, die das Einmaleins in Form eines zweidimensionalen Arrays erzeugt.

```java
static int[][] multiplicationTable(int max) {
    var table = new int[max][max];
    for (int i = 1; i <= max; i++) {
        for (int j = 1; j <= max; j++){
            table[i][j] = i * j;
        }
    }
    return table;
}
```

Auch für diese Methode wolle wir einmal die Laufzeit bestimmen.
Auch in diesem Beispiel ignorieren wir die Laufzeit der Initialisierung des Arrays `table` aus didaktischen Gründen.

$$\begin{align}
T_{\texttt{multiplicationTable}}(n) &= \sum_{i = 1}^{n} \left( \sum_{j = 1}^{n} c_1 + c_2 \right) + c_3 & \text{Regel (\ref{eqn:constant})}\\\\
&= \sum_{i = 1}^{n} (c_1 (n - 1 + 1) + c_2) + c_3\\\\
&= \sum_{i = 1}^{n} (c_1 n + c_2) + c_3 & \text{Regel (\ref{eqn:constant})}\\\\
&= (c_1 n + c_2)n + c_3\\\\
&= c_1 n^2 + c_2 n + c_3
\end{align}$$

<!-- Als finales Beispiel wollen wir uns eine Methode anschauen, die zwar zwei ineinander geschachtelte Schleifen verwendet, deren Laufzeit aber dennoch linear ist.
Wir betrachten dazu eine leicht vereinfachte Variante der Methode `expandArray` aus der Klasse `Arrays`.

```java
static int[] expandArray(int[] array) {
    var newArray = new int[2 * array.length];
    for (int i = 0; i < array.length; i++) {
        newArray[i] = array[i];
    }
    return newArray;
}
```

Im Folgenden wollen wir simulieren, wie die Methode `expandArray` aufgerufen wird, wenn wir zu einer `ArrayList` wiederholt Elemente mithilfe der Methode `add` hinzufügen.
In der Methode `growArray` gibt das Argument `minSize`
Beim wiederholten Hinzufügen starten wir mit einem Array mit nur einem Eintrag.
Wir rufen dann immer wieder die Methode `expandArray` auf, bis die gewünschte Größe für das Array erreicht ist.
Wenn wir ein Array der Größe `4` erhalten möchten, müssen wir zweimal die Methode `expandArray` aufrufen.
Um ein Array der Größe `8` zu erhalten, müssen wir die Methode `expandArray` dreimal aufrufen.
Insgesamt ergibt sich die Anzahl der Aufrufe als Zweier-Logarithmus der Zahl `minSize`.
Im Folgenden stellt die Methode `log2` ist eine Methode, die den Logarithmus zur Basis zwei berechnet.
Bei Werten für `minSize`, die kein Zweierpotenz sind, müssen wir etwas aufpassen.
Wenn wir zum Beispiel ein Array der Größe `5` erhalten möchten, müssen wir die Methode `expandArray` dreimal aufrufen, da das erzeugte Array erst dann eine Größe hat, die mindestens `5` beträgt.
Daher wird in der folgenden Methoden auf das Ergebnis der Methode `log2` noch die Methode `Math.ceil` aufgerufen.
Diese Methode liefert uns die nächstgrößere ganze Zahl.

```java
static int[] growArray(int minSize) {
    var array = new int[1];
    for (int i = 1; i <= Math.ceil(log2(minSize)); i++) {
        array = expandArray(array);
    }
    return array;
}
```

<figure id="figure:rules">

$$\begin{align}
\sum_{i = 0}^{n}q^{i} = \frac{1 - q^{n+1}}{1 - q}\tag{5}\label{eqn:geometric}
\end{align}$$

<figcaption>Abbildung 1: Regeln zur Umformung von Gleichungen</figcaption>
</figure>

$$\begin{align}
T_{\texttt{expandArray}}(n) &= \sum_{i = 0}^{n - 1} c_1 + c_2\text{Regel (\ref{eqn:constant})}\\\\
&= c_1 n + c_2
\end{align}$$

$$\begin{align}
T_{\texttt{resizeArray}}(n) &= \sum_{i = 1}^{\log_2(n)} T_{\texttt{expandArray}}(2^{i - 1})\\
&= \sum_{i = 1}^{\log_2(n)} (c_1 2^{i - 1} + c_2)\\
&= \sum_{i = 1}^{\log_2(n)} c_1 2^{i - 1} + \sum_{i = 1}^{\log_2(n)} c_2\\
&= \sum_{i = 1}^{\log_2(n)} c_1 2^{i - 1} + c_2 \log_2(n)\\
&= c_1 \sum_{i = 1}^{\log_2(n)} 2^{i - 1} + c_2 \log_2(n)\\
&= c_1 \cdot (2^{\log_2(n) + 1} - 1) + c_2 \log_2(n)
\end{align}$$ -->

<!-- 
_Arm's length_-Rekursion
--------------------------

Bei rekursiven Implementierungen kann häufig die konkret Laufzeit verringert werden, indem man rekursive Aufrufe vermeidet.
Das heißt, der Algorithmus bleibt in der gleichen Größenordnung, man spart aber etwa die Hälfte der konkreten Laufzeit.
Um dies zu erreichen, wird die Abbruchbedingung vor dem rekursiven Aufruf geprüft, um den Aufruf einzusparen.
Wir betrachten etwa die folgende alternative Implementierung der rekursiven Fakultät.

``` java
static int fac(int n) {
    if (n <= 0) {
        return 1;
    } else {
        return n * fac(n - 1);
    }
}

private static int facRec(int n) {
    if (n <= 1) {
        return 1;
    } else {
        return facRec(n);
    }
}
``` -->

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="complexity.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"><a href="divide-and-conquer.html">weiter</a></li>
    </ul>
</div>
