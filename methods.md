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

Die Methoden `fac` und `sumRec` implementieren recht einfache Rekursionsmuster.
In beiden Methoden gibt es zum Beispiel nur einen rekursiven Aufruf.
Um zu illustrieren, dass es bei rekursiven Methoden auf mehrere rekursive Aufrufe geben kann, betrachten wird die Fibonacci-Sequenz.
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


Einschub: Rekurrenzen
---------------------

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

also dass die Aussage für alle natürlichen Zahlen gilt.

Wir wollen mithilfe der klassischen Induktion jetzt die oben angegebene geschlossene Form der Laufzeit von `fac` beweisen.

**Beh.:** $$\forall n \in \mathbb{N}: T_{\texttt{fac}}(n) = c_2 n + c_1$$.

**Bew.:**

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

Mit Hilfe des [vorherigen Kapitels](complexity.md) wissen wir, dass die Funktion $$T_{\texttt{fac}}$$ in $$\mathcal{O}(n)$$ ist. Das heißt, die Laufzeit der Methode `fac` ist linear.


Einschub: Bestimmung von Laufzeiten
-----------------------------------

Nachdem wir gesehen haben, wie wir die Laufzeiten von rekursiven Methoden etwas formaler bestimmen können, wollen wir uns Methoden anschauen, die klassisch mit einer Schleife implementiert sind.
Wir führen auch bei Methoden, die mit einer Schleifen implementiert sind, Konstanten ein, um davon zu abstrahieren, wie viele konstante Schritte ein Stück Code genau ausführt.
Die Laufzeit einer rekursiven Methode haben wir durch eine rekursive Funktion modelliert.
Die Laufzeit einer einfachen Zählschleife werden wir durch eine mathematische Summe modellieren.
Dadurch erhalten wir als Laufzeit für eine Methode mit Schleife eine Funktion, die mehrere mathematische Summen nutzt.
Wir müssen diese Funktion dann in den meisten Fällen noch in die Form eines Polynoms bringen, um zu bestimmen, in welcher Größenordnung die Laufzeit einer Methode ist.
Um Summen zu vereinfachen verwenden wir eine Reihe von Regeln, die in [Abbildung 1](#figure:rules) zu sehen sind.

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

Die Variable *c*<sub>2</sub> steht für die Schritte, die vor und nach der Ausführung der Schleife durchgeführt werden müssen.
Wir wissen nicht genau, wie viele Schritte es sind, es handelt sich aber um eine konstante Anzahl.
Die Variable *c*<sub>1</sub> steht für die konstante Anzahl an Schritten, die in jedem Durchlauf der Schleife durchgeführt werden.

Mit Hilfe der Laufzeit für die Methode `nodeAt` können wir nun die Laufzeit der Methode `get` bestimmen.

$$T_{\texttt{get}}(i) = T_{\texttt{nodeAt}}(i) + c_3 = c_1i + c_2 + c_3$$

Mit Hilfe dieser Vorarbeiten können wir nun die Laufzeit der Methode `toArray` bestimmen.
Das Argument der Funktion $$T_{\texttt{toArray}}$$ ist in diesem Fall die Länge der Liste.
Die Initialisierung eines Arrays hat eine lineare Laufzeit in der Größe des Arrays.
Wir nutzen dafür im folgenden die Funktion.

$$T_{\texttt{new_Integer[]}}(n) = c_4 n$$

Das heißt, ein Array der Größe $$n$$ zu erzeugen, benötigt $$c_4 n$$ Schritte.
Wir nutzen diese Vorarbeiten nun, um die Laufzeit der Methode `toArray` zu bestimmen.

$$\begin{align}
T_{\texttt{toArray}}(n) &= T_{\texttt{new_Integer[]}}(n) + \sum_{i = 0}^{n - 1} (c_5 + T_{\texttt{get}}(i)) + c_6 & \text{Definition $T_{\texttt{new_Integer[]}}$}\\\\
&= c_4 n + \sum_{i = 0}^{n - 1} (c_5 + T_{\texttt{get}}(i)) + c_6 & \text{Regel (\ref{eqn:associativity}}\\\\
& = c_4 n + \sum_{i = 0}^{n - 1} c_5 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_6 & \text{Regel (\ref{eqn:constant})}\\\\
& = c_4 n + n c_5 + \sum_{i = 0}^{n - 1} T_{\texttt{get}}(i) + c_6 & \text{Definition $T_{\texttt{get}}$}\\\\
& = c_4 n + n c_5 + \sum_{i = 0}^{n - 1} (c_1 i + c_2 + c_3) + c_6 & \text{Regel (\ref{eqn:associativity})}\\\\
& = c_4 n + n c_5 + \sum_{i = 0}^{n - 1} c_1 i + \sum_{i = 0}^{n - 1} (c_2 + c_3) + c_6 & \text{Regel (\ref{eqn:constant})}\\\\
& = c_4 n + n c_5 + \sum_{i = 0}^{n - 1} c_1 i + (c_2 + c_3)n + c_6 & \text{Regel (\ref{eqn:distributivity})}\\\\
& = c_4 n + n c_5 + c_1 \sum_{i = 0}^{n - 1} i + (c_2 + c_3)n + c_6 & \text{Regel (\ref{eqn:gauß})}\\\\
& = c_4 n + n c_5 + c_1 \frac{n(n - 1)}{2} + (c_2 + c_3)n + c_6\\\\
& = c_4 n + n c_5 + c_1 \left(\frac{1}{2} n^2 - \frac{1}{2} n\right) + (c_2 + c_3)n + c_6\\\\
& = c_4 n + n c_5 + c_1 \frac{1}{2} n^2 - c_1 \frac{1}{2} n + (c_2 + c_3)n + c_6\\\\
& = \frac{1}{2} c_1 n^2 + \left(- \frac{1}{2} c_1 + c_2 + c_3 + c_4 + c_5\right) n + c_6
\end{align}$$

Analog zu den Beweisen aus dem Kapitel [Komplexität](complexity.md) können wir mit dieser Information zeigen, dass $$T_{\texttt{toArray}} \le_{as} q$$ gilt, wobei $$q : \mathbb{N} \rightarrow \mathbb{R}$$, $$q(x) = x^2$$.
Diese Argumentation zeigt etwas formaler als wir es zuvor durchgeführt haben, dass die Laufzeit von `toArray` in $$\mathcal{O}(n^2)$$ liegt, wobei $$n$$ die Länge der Liste ist.

Divide and Conquer
------------------

Bei der Rekursion zerlegen wir ein Problem in eines oder mehrere kleinere Probleme.
Bei der Implementierung der Fakultät, konnten wir bei der rekursiven Lösung zum Beispiel das Problem in ein kleineres Problem zerlegen, indem wir eine Multiplikation abgespalten haben und die Berechnung einer kleineren Fakultät übrig geblieben ist.
Im Gegensatz dazu wird bei _Divide and Conquer_ ein Problem in mehrere Teilprobleme zerlegt.
Wenn wir zum Beispiel mithilfe von _Divide and Conquer_ die Berechung der Faktultät implementieren wollten, müssten wir die Berechnung der Fakultät in zwei kleinere Berechnungen der Fakultät zerlegen.
Auf diese Weise erhält man sehr effiziente Algorithmen, wie wir im Folgenden sehen werden.

Wir wollen im Folgenden das Prinzip der binären Suche betrachten.
Dazu nehmen wir an, dass wir ein Array mit aufsteigend sortierten Zahlen gegeben haben.
Wir wollen testen, ob dieses Array eine gegebene Zahl enthält.
Wenn wir ein Array gegeben haben, dessen Einträge bereits aufsteigend sortiert sind und wir suchen einen bestimmten Eintrag, so können wir dieses Problem mit Hilfe einer binären Suche lösen.
Bei der binären Suche schaut man sich zuerst den Eintrag in der Mitte des Arrays an.
Falls dieser Eintrag dem Wert entspricht, den wir suchen, sind wir fertig.
Falls der Eintrag in der Mitte kleiner ist als der Wert, den wir suchen, wissen wir, dass wir mit der ersten Hälfte des Arrays fortfahren können.
Sollte das Element in der Mitte des Arrays bereits größer sein als der Wert, den wir suchen, so fahren wir mit der zweiten Hälfte des Arrays fort.
In der neu bestimmten Hälfte des Arrays suchen wir wiederum mit Hilfe einer binären Suchen nach dem gesuchten Wert.
Auf diese Weise können wir bei jedem Schritt im schlechtesten Fall die Hälfte der Elemente ignorieren.

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

Wir wollen uns jetzt einmal überlegen, in welcher Größenordnung die Laufzeit der Methode `binarySearch` im *worst case* ist.
Die Methode nutzt zwar eine Schleife, es handelt sich aber nicht um eine einfache Zählschleife.
Aus diesem Grund können wir den Aufwand der Schleife auch nicht einfach durch eine Summe beschreiben.
Stattdessen nutzen wir zur Beschreibung der Laufzeit auch hier eine Rekurrenz.
Wir definieren dazu eine rekursive Funktion $$T_{\texttt{binarySearch}}$$, welche die Anzahl an Schritten beschreibt, welche die Methode `binarySearch` im *worst case* durchführt.
Das Argument der Funktion ist die Größe des Arrayabschnitts, den die Methode noch bearbeiten muss.

$$T_{\texttt{binarySearch}}(n) = \begin{cases}
  c_1                                               & \text{falls}~n = 0\\\\
  c_2 + T_{\texttt{binarySearch}}(\frac{n - 1}{2})  & \text{falls}~n~\text{ungerade}\\\\
  c_2 + T_{\texttt{binarySearch}}(\frac{n}{2})      & \text{sonst}
\end{cases}$$

Es sei *n* die Anzahl der Elemente, die wir noch durchsuchen müssen.
Bei einer ungeraden Anzahl von Elementen prüfen wir die Mitte und erhalten dann noch eine gerade Anzahl von Elementen, nämlich *n* − 1 Elemente.
Diese gerade Anzahl teilen wir in zwei gleich große Teile.
Bei einer geraden Anzahl von Elementen prüfen wir ebenfalls die Mitte und erhalten eine ungerade Anzahl von Elementen, nämlich *n* − 1 Elemente.
Da wir den schlechtesten Fall betrachten, gehen wir davon aus, dass wir jeweils im größeren der beiden Teile weitersuchen.
Wir müssen also noch $$\left\lceil\frac{n - 1}{2}\right\rceil$$ Elemente durchsuchen.
Dies entspricht einfach der Zahl $$\frac{n}{2}$$.

In der folgenden Tabelle sind die Werte von $$T_{\texttt{binarySearch}}$$ sowie die Werte der Funktion
$$f(n) = \log_2 n + 1$$ aufgelistet.

| $$n$$    | $$T_{\texttt{binarySearch}}(n)$$ | $$\log_2 n + 1$$
|----------|---------------------------------:|-----------------:|
| 0        | $$c_1$$                          | --               |
| 1        | $$c_2 + c_1$$                    | 1                |
| 2        | $$2 c_2 + c_1$$                  | 2                |
| 3        | $$2 c_2 + c_1$$                  | 2,58             |
| 4        | $$3 c_2 + c_1$$                  | 3                |
| 5        | $$3 c_2 + c_1$$                  | 3,32             |
| 6        | $$3 c_2 + c_1$$                  | 3,58             |
| 7        | $$3 c_2 + c_1$$                  | 3,80             |
| 8        | $$4 c_2 + c_1$$                  | 4                |
| 9        | $$4 c_2 + c_1$$                  | 4,16             |

Wir sehen hier, dass der Faktor vor der Konstante *c*<sub>2</sub> durch $$\log_2 n + 1$$ jeweils überschätzt wird.
Mithilfe einer Induktion lässt sich die folgende Eigenschaft für alle $$n \ge 1$$ zeigen.

$$T_{\texttt{binarySearch}}(n) \le (\log_2 n + 1) c_2 + c_1 = c_2 \log_2 n + c_2 + c_1$$

Das heißt, dass die *worst case*-Laufzeit der Methode `binarySearch` in $$\mathcal{O}(\log_2 n)$$ liegt.

Alle Logarithmen sind in der gleichen Größenordnung.
Dies lässt sich einfach zeigen, wenn man sich überlegt, wie sich der Logarithmus einer Basis mit Hilfe des Logarithmus einer anderen Basis ausdrücken lässt.
Für zwei Basen *b*<sub>1</sub> und *b*<sub>2</sub> gilt der folgende Zusammenhang.

$$\log_{b_1} x = \frac{\log_{b_2} x}{\log_{b_2} b_1}.$$

Daher ist die Laufzeit der binären Suche sowohl in $$\mathcal{O}(\log_2 n)$$ als auch in $$\mathcal{O}(\log n)$$.
Als kanonischen Repräsentanten wählt man für Logarithmen den Logarithmus zur Basis 10, also $$\log$$.

Es gibt eine ganze Reihe von Algorithmen, die auf der Idee basieren, ein Problem in zwei Teilprobleme gleicher Größe zu zerlegen.
Man nennt diesen Ansatz zur Lösung eines Problems *Teile & Herrsche (Divide &
Conquer)*.
Diese Algorithmen haben meistens einen logarithmischen Faktor in ihrer Laufzeit.


Einschub: Beweis mittels starker Induktion
------------------------------------------

Wir haben bei der Implementierung der Fakultät gesehen, dass wir mithilfe einer Induktion die Laufzeit einer rekursiven Methode beweisen können.
Wir wollen nun eine Induktion nutzen, um für die Laufzeit der binären Suche zu zeigen, dass sie höchstens logarithmisch wächst.
Für unseren Beweis reicht die klassische Form der Induktion nicht aus.
Die Rekurrenz $$T_{\texttt{binarySearch}}$$ ruft sich selbst rekursiv nicht nur mit einem $$n-1$$ auf, sondern mit $$\frac{n - 1}{2}$$ und $$\frac{n}{2}$$.
Wenn wir die Induktionsvoraussetzung nicht nur für $$n - 1$$ benötigen, sondern noch für andere Werte, kann man eine Form der Induktion nutzen, die manchmal auch als starke Induktion bezeichnet wird.
Bei der starken Induktion unterscheidet sich der Induktionsschritt.

Bei der klassischen Induktion kann der Induktionsschritt durch die folgende Aussage beschrieben werden.

$$
\forall n \in \mathbb{N} \colon \operatorname{A}(n)\Rightarrow \operatorname{A}(n+1) 
$$

Bei der starken Induktion kann der Induktionsschritt dagegen durch die folgende Aussage beschrieben werden.

$$
\forall n \in \mathbb{N} \colon (\forall m \in \mathbb{N} \colon m < n \Rightarrow \operatorname{A}(m)) \Rightarrow \operatorname{A}(n)
$$

Das heißt, um den Induktionsschritt zu zeigen, haben wir in diesem Fall nicht nur zur Verfügung, dass die Aussage $$\operatorname{A}$$ für den jeweiligen Vorgänger gilt, sondern, dass die Aussage für alle Vorgänger gilt.
Durch diese Formulierung erübrigt sich der Induktionsanfang.
Wenn wir den Induktionsschritt zum Beispiel für $$n = 0$$ betrachten, erhalten wir die folgende Formel.

$$
(\forall m \in \mathbb{N} \colon m < 0 \Rightarrow \operatorname{A}(m)) \Rightarrow \operatorname{A}(0)
$$

Es gibt keine natürlichen Zahlen, die kleiner als $$0$$ sind, daher müssen wir für den Fall $$n = 0$$ die $$\operatorname{A}(0)$$ ohne Voraussetzung zeigen.
Das heißt, in der Formel für den Induktionsschritt versteckt sich auch ein Induktionsanfang.

Wir nutzen im Folgenden außerdem eine Variante der Induktion, bei der man nicht mit dem Startwert `0` startet, sondern mit einer frei gewählten natürlichen Zahl.
Diese Form der Induktion kann durch die folgende Formel beschrieben werden.

$$
\begin{align}
& \forall n \in \mathbb{N} \colon n \ge n_0 \wedge (\forall m \in \mathbb{N} \colon m \ge n_0 \wedge m < n \Rightarrow \operatorname{A}(m)) \Rightarrow \operatorname{A}(n)\\
& \Rightarrow\\
& \forall n \in \mathbb{N} \colon n \ge n_0 \Rightarrow \operatorname{A}(n)
\end{align}
$$

Mithilfe der starken Induktion wollen wir nun zeigen, dass $$T_{\texttt{binarySearch}}(n) \in \mathcal{O}(\log_2 n)$$ gilt.
Dazu müssen wir zeigen, dass ein $$c \in \mathbb{R}$$ mit $$c > 0$$ und ein $$n_0 \in \mathbb{N}$$ existieren, so dass $$T_{\texttt{binarySearch}}(n) \le c \cdot \log_2 n$$ für alle $$n \in \mathbb{N}$$ mit $$n \ge n_0$$ gilt.
Wir zeigen zunächst eine Hilfsaussage.
Wir verwenden im folgenden Beweis wieder die Regeln für $$\le$$ aus dem Kapitel <a href="complexity.html#figure:le-rules">Komplexität</a>.
Wir nutzen außerdem die folgende Regel für die $$\log$$-Funktion.
Wir werden in einem späteren Beweis die zweite Eigenschaft nutzen und führen sie daher hier schon einmal auf.

<figure id="figure:le-rules" markdown="1">

$$
\begin{align}
& \forall m, n \in \mathbb{R}: & m \le n & \Rightarrow \log_2 m \le \log_2 n\tag{3}\\
& \forall m, n \in \mathbb{R} \colon & m \le n & \Rightarrow 2^m \le 2^n\tag{4}
\end{align}
$$

  <figcaption>Abbildung 2: Weitere Regeln für <span class="mo" id="MathJax-Span-286" style="font-family: STIXGeneral-Regular; padding-left: 0.313em;">≤</span></figcaption>
</figure>

**Beh.:** $$\forall n \in \mathbb{N} \colon n \ge 1 \Rightarrow T_{\texttt{binarySearch}}(n) \le c_2 (\log_2 n + 1) + c_1$$

**Bew.:**

Zur Lesbarkeit nennen wir die Funktion $$T_{\texttt{binarySearch}}$$ im Folgenden $$T$$.

Wir zeigen die Aussage per starker Induktion mit $$n_0 = 1$$.

Induktionsschritt:

Sei $$n \in \mathbb{N}$$ mit $$n \ge 1$$ und es gelte $$\forall m \in \mathbb{N} \colon m \ge n_0 \wedge m < n \Rightarrow T(m) \le c_2 \log_2 m + c_2 + c_1$$.
Dann gilt

1\. Fall: $$n = 1$$

$$
\begin{align*}
T(1) & = c_2 + T(0)\\
     & = c_2 + c_1\\
     & = c_2 (0 + 1) + c_1\\
     & = c_2 (\log_2 1 + 1) + c_1
\end{align*}
$$

2\. Fall: $$n > 1$$ und $$n$$ ist gerade

$$
\begin{align*}
T(n) & = c_2 + T\left(\frac{n}{2}\right) & \text{Regel (2): Induktionshypothese}\\
     & \le c_2 + c_2 (\log_2 \left(\frac{n}{2}\right) + 1) + c_1 & \text{$\log_2 \left(\frac{n}{m}\right) = \log_2 n - \log_2 m$}\\
     & = c_2 + c_2 (\log_2 n - \log_2 2 + 1) + c_1\\
     & = c_2 + c_2 (\log_2 n - 1 + 1) + c_1\\
     & = c_2 + c_2 \log_2 n + c_1\\
     & = c_2 (\log_2 n + 1) + c_1
\end{align*}
$$

3\. Fall: $$n > 1$$ und $$n$$ ist ungerade

$$
\begin{align*}
T(n) & = c_2 + T\left(\frac{n - 1}{2}\right) & \text{Regel (2): Induktionshypothese}\\
     & \le c_2 + c_2 (\log_2 \left( \frac{n - 1}{2} \right) + 1) + c_1 & \text{$\log_2 \left(\frac{n}{m}\right) = \log_2 n - \log_2 m$}\\
     & = c_2 + c_2 (\log_2 (n - 1) - \log_2 2 + 1) + c_1\\
     & = c_2 + c_2 (\log_2 (n - 1) - 1 + 1) + c_1\\
     & = c_2 + c_2 \log_2 (n - 1) + c_1\\
     & = c_2 + c_2 \log_2 (n - 1) + c_1 & \text{Regel (3): $n - 1 \le n$, Regel (1): $0 \le c_2$, Regel (2)}\\
     & \le c_2 + c_2 \log_2 n + c_1\\
     & = c_2 (\log_2 n + 1) + c_1
\end{align*}
$$

Damit ist die Behauptung gezeigt.

Wir erhalten mit der zuvor gezeigten Aussage, dass $$T_{\texttt{binarySearch}} \in \mathcal{O}(\log n)$$ gilt.


Dynamische Programmierung
-------------------------

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
     & = n^2 + 0\\
     & \leq n^2 + \frac{3}{2}n && \text{Regel (1): $0 \le \frac{3}{2}n$}\\
     & = \frac{1}{2} \cdot (2 n^2 + 3 n)\\
     & = c \cdot p(n).
\end{align}
$$

Für diese Ungleichung benötigen wir noch $$0 \le \frac{3}{2}n$$.
Da $$0 = \frac{3}{2} \cdot 0$$ folgt dies aus Regel (2), da $$0 \le n$$ gilt.

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

Backtracking
------------

Wir wollen als nächstes eine algorithmische Methode anschauen, die ein Problem löst, indem sie alle Möglichkeiten ausprobiert.
Diese Methode wird als *Backtracking* bezeichnet.
Das Backtracking durchsucht einen Raum von Lösungen systematisch.
Dabei kann man sich das Vorgehen als Baumstrukutur illustrieren.
Häufig durchsucht man beim *Backtracking* den Raum aller Lösungen nicht komplett sondern nutzt zusätzliche Informationen über das Problem, um effizienter eine Lösung zu finden.

Als Beispiel für eine Anwendung von *Backtracking* wollen wir das *subset sum*-Problem lösen.
Bei diesem Problem ist eine Sequenz mit Zahlen und eine weitere Zahl gegeben.
Wir wollen jetzt herausfinden, ob es eine Teilsequenz gibt, deren Summe genau der gegebenen Zahl entspricht.
Wir schauen erst einmal die Implementierung der Methode an und diskutieren danach die einzelnen Komponenten.

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
Dabei werden alle Möglichkeiten erzeugt, indem für jeden Eintrag des Arrays immer zwei Möglichkeiten ausprobiert werden.
Einmal wird das Element zur Summe hinzugerechnet und einmal wird das Element nicht zur Summe hinzugerechnet.
Falls der erste Aufruf, also `subsetsum(array, sum - array[index], index + 1)` als Ergebnis `false` liefert, wird auch noch die Alternative, nämlich `subsetsum(array, sum, index + 1)` ausprobiert.

<figure id="figure:subsetsum-calls" markdown="1">

![](/assets/graphics/subsetsum-calls.svg){: width="100%" .centered}

<figcaption>Abbildung 4: Der Rekursionsbaum für <code class="language-plaintext highlighter-rouge">subsetsum(array, 7)</code>, wobei <code class="language-plaintext highlighter-rouge">int[] array = {2, 1, 5, 4}</code></figcaption>

<a href="#figure:subsetsum-calls">Abbildung 4</a> zeigt den Rekursionsbaum der Methode `subsetsum` mit dem Array `{2, 1, 5, 4}` und der Summe `7`.
Die Argumente, die in den Knoten angegeben sind, sind die noch übrige Summe und der aktuelle Index.

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="complexity.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"></li>
    </ul>
</div>