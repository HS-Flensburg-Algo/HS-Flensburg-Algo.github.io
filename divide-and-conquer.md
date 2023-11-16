---
layout: post
title: "Divide and Conquer"
---


Bei der Rekursion zerlegen wir ein Problem in eines oder mehrere kleinere Probleme.
Bei der Implementierung der Fakultät, konnten wir bei der rekursiven Lösung zum Beispiel das Problem in ein kleineres Problem zerlegen, indem wir eine Multiplikation abgespalten haben und die Berechnung einer kleineren Fakultät übrig geblieben ist.
Im Gegensatz dazu wird bei _Divide and Conquer_ ein Problem in mehrere Teilprobleme zerlegt.
Wenn wir zum Beispiel mithilfe von _Divide and Conquer_ die Berechung der Faktultät implementieren wollten, müssten wir die Berechnung der Fakultät in zwei kleinere Berechnungen der Fakultät zerlegen.
Auf diese Weise erhält man sehr effiziente Algorithmen, wie wir im Folgenden sehen werden.


Binäre Suche
------------

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
    var found = false;
    var start = 0;
    var end = array.length - 1;

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


Beweis mittels starker Induktion
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

<div class="nav">
    <ul class="nav-row">
        <li class="nav-item nav-left"><a href="recursion.html">zurück</a></li>
        <li class="nav-item nav-center"><a href="index.html">Inhaltsverzeichnis</a></li>
        <li class="nav-item nav-right"></li>
    </ul>
</div>
