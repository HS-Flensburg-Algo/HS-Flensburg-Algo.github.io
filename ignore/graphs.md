---
layout: post
title: "Graphen"
---

In diesem Kapitel wollen wir uns mit Graphen, einer grundlegenden Datenstruktur der Informatik, sowie Algorithmen zur Verarbeitung dieser Datenstruktur beschäftigen.
Graphen werden in der Informatik zur Modellierung vieler Probleme genutzt, zum Beispiel für das Berechnen von Routen auf Karten, die Modellierung von Netzwerkstrukturen, die Analyse von Abhängigkeiten in Computerprogrammen oder für die Modellierung von sozialen Netzen.

Grundidee
---------

Zunächst wollen wir einmal anschaulich betrachten, was ein Graph ist.
Ein Graph besteht aus sogenannten Knoten und Kanten.
In der bildlichen Representation eines Graphen werden die Knoten dabei zumeinst als Kreise dargestellt und die Kanten als Linien, die diese Kreise verbinden.
Knoten haben dabei einen Namen und Kanten werden durch die Namen der Knoten identifiziert, die durch die Kante verbunden werden.

Es gibt zwei grundsätzliche Arten von Graphen: gerichtete und ungerichtete Graphen.
Bei gerichteten Graphen hat jede Kante eine Richtung, die durch einen Pfeil auf der Seite der Kante dargestellt wird, die das Ziel darstellt.
Die Kante kann dann nur in Richtung des Pfeils “genutzt” werden. Bei ungerichteten Graphen haben die Kanten keine Richtung, das bedeutet, sie können sowohl von einem Knoten zum anderen als auch in die andere Richtung “genutzt” werden.
Bei einem gerichteten Graphen kann eine Kante auch einen Knoten mit sich selbst verbinden.

Neben der Unterscheidung zwischen gerichteten und ungerichteten Graphen werden häufig noch gewichtete Graphen betrachtet. Dabei wird jeder Kante im Graphen ein Gewicht (meist eine Zahl) zugeordnet.
Dieses Gewicht kann zum Beispiel genutzt werden, um bestimmten Kanten in einem Graphen eine Wahrscheinlichkeit zuzuordnen. Auf diese Weise können zum Beispiel Ausfallwahrscheinlichkeiten in einem Computernetzwerk modelliert werden.

Formale Definition
------------------

Es ist sehr schwierig, über Eigenschaften eines Graphen zu “kommunizieren”, wenn man nur die bildliche Repräsentation zur Verfügung hat, die wir bisher kennengelernt haben.
Zum Beispiel ist es für die Performanz eines Spieles sehr wichtig, wie viele Knoten der Graph eines Navigation Mesh besitzt.
Bisher müssten wir zu diesem Zweck eine umgangssprachliche Bezeichnung wie “Die Anzahl der Knoten des Meshes in Abbildung X” verwenden. Ähnliches gilt für die Kanten in einem Graphen.

Um effizient (und genau) miteinander zu kommunizieren, nutzt die Informatik die formalen Methoden der Mathematik. Daher werden wir im Folgenden die formale Definition eines Graphen kennenlernen, die es uns erlaubt, sehr viel kompaktere und exaktere Aussagen über Graphen zu treffen als es umgangssprachlich möglich wäre. Um im Folgenden zu sehen, an welcher Stelle eine Definition oder ein Beispiel beendet ist, schließen wir diese immer mit dem Symbol “▫” ab.

<span id="definition:gerichteter-graph" label="definition:gerichteter-graph"></span> Ein gerichteter Graph ist ein Paar *G* = (*V*,*E*), wobei *V* eine endliche Menge von Knoten und
*E* ⊆ *V* × *V* — die Menge der Kanten — eine Relation auf *V* ist.

Ein ungerichteter Graph wird ganz ähnlich zu einem gerichteten Graphen
definiert. Der Unterschied der Definitionen besteht in der Darstellung
der Kanten.

Ein ungerichteter Graph ist ein Paar *G* = (*V*,*E*), wobei *V* eine
endliche Menge von Knoten und $E \subseteq \Power{V}$ — die Menge der
Kanten — eine Teilmenge der Potenzmenge von *V* ist. Dabei muss
zusätzlich \|*e*\| = 2 für alle *e* ∈ *E* gelten, das heißt, Kanten sind
zweielementige Mengen. <span id="definition:ungerichteter-graph"
label="definition:ungerichteter-graph"></span>

-   Für eine Kante (*u*,*v*) ∈ *E* in einem gerichteten Graphen sagt
    man, dass der Knoten *v* adjazent zum Knoten *u* ist. Für eine Kante
    {*u*, *v*} ∈ *E* in einem ungerichteten Graphen ist *u* adjazent zu
    *v* und *v* adjazent zu *u*.

-   Aus der
    <a href="#definition:ungerichteter-graph" data-reference-type="autoref"
    data-reference="definition:ungerichteter-graph">[definition:ungerichteter-graph]</a>
    ergibt sich, dass ungerichtete Graphen keine Schleifen enthalten.

Wir werden uns im Folgenden nur noch mit gerichteten Graphen
beschäftigen, da diese auch genutzt werden können, um ungerichtete
Graphen darzustellen. Um diesen Zusammenhang formal zu beschreiben,
benötigen wir eine formale Eigenschaft einer Relation, die als Symmetrie
bezeichnet wird.

Eine Relation *R* wird genau dann als symmetrisch bezeichnet, wenn die
folgende Aussage wahr ist.
∀(*x*,*y*) ∈ *R* : (*y*,*x*) ∈ *R*

Es gibt eine 1-zu-1-Abbildung (Bijektion) zwischen der Menge der
symmetrischen, schleifenlosen, gerichteten Graphen und der Menge der
ungerichteten Graphen.

Graph-Implementierung
---------------------

Nachdem wir uns bisher nur mit dem abstrakten mathematischen Modell
eines Graphen beschäftigt haben, wollen wir uns jetzt Gedanken über eine
konkrete Implementierung in der Programmiersprache Java machen.
<a href="#figure:graph-adt" data-reference-type="autoref"
data-reference="figure:graph-adt">[figure:graph-adt]</a> definiert einen
abstrakten Datentyp für eine Graph-Datenstruktur.

|                                                                                      |                                    |
|:-------------------------------------------------------------------------------------|:-----------------------------------|
| `int`                                                                                | `size()`                           |
| Liefert die Anzahl der Knoten zurück.                                                |                                    |
| `boolean`                                                                            | `hasEdge(int node1, int node2)`    |
| Testet, ob der Graph eine Kante zwischen den Knoten `node1` und `node2` aufweist.    |                                    |
| `void`                                                                               | `addEdge(int node1, int node2)`    |
| Fügt zum Graphen eine Kante zwischen Knoten `node1` und `node2` ein.                 |                                    |
| `void`                                                                               | `removeEdge(int node1, int node2)` |
| Entfernt die Kante zwischen den Knoten `node1` und `node2`, falls sie existiert.     |                                    |
| `List<Integer>`                                                                      | `adjacentNodes(int node)`          |
| Liefert eine Liste, die alle Knoten enthält, die zum gegebenen Knoten adjazent sind. |                                    |

Wenn wir den abstrakten Datentyp Graph mit der mathematischen Definition
eines Graphen vergleichen, fällt auf, dass einige Vereinfachungen
vorgenommen wurden. In der mathematischen Definition haben wir als
Knoten zum Beispiel einfach eine beliebige Menge zugelassen, der
abstrakte Datentyp verwendet aber Integer für die Knoten. In der
Implementierung hat die Verwendung von Zahlen den Vorteil, dass diese
effizient auf Gleichheit getestet werden können, was bei beliebigen
Objekten unter Umständen nicht der Fall ist. In der mathematischen
Definition möchten wir aber gern alle Freiheiten haben, um ein
anschauliches Modell definieren zu können. Dieser Unterschied bereitet
uns praktisch keine Probleme, da wir einfach eine 1-zu-1-Zuordnung
zwischen einer endlichen Menge von Objekten und einer Menge von
natürlichen Zahlen angeben können. Wir können die Elemente einer Menge
einfach durchnummerieren.

Bei der Implementierung eines Graphen gibt es zwei Vorgehensweisen. Beim
ersten Ansatz wird eine sogenannte Adjazenzmatrix verwendet. Bei der
Implementierung mittels Adjazenzmatrix wird für die Darstellung der
Kanten in einem Graphen *G* = (*V*,*E*) mit
$V = \set{ v_0, \dots, v\_{n-1} }$ eine *n* × *n*-Matrix verwendet. Eine
Matrix *m* zu einem Graphen ist dabei für alle
$i \in \set{ 0, \dots, n-1 }$ und $j \in \set{ 0, \dots, n-1 }$ wie
folgt definiert.
$$m\[i\]\[j\] : = \begin{cases}
  \mintinline{java}{true}, & \mbox{falls}\~(v_i, v_j) \in E \\\\
  \mintinline{java}{false}, & \mbox{sonst}
  \end{cases}$$
<a href="#figure:adjacency-matrix-ungerichtet"
data-reference-type="autoref"
data-reference="figure:adjacency-matrix-ungerichtet">[figure:adjacency-matrix-ungerichtet]</a>
und <a href="#figure:adjacency-matrix-gerichtet"
data-reference-type="autoref"
data-reference="figure:adjacency-matrix-gerichtet">[figure:adjacency-matrix-gerichtet]</a>
zeigen Graphen und die visuellen Representationen der Adjazenzmatrizen
dieser Graphen.

Wir implementieren einen gerichteten Graphen in Java wie folgt. Für die
Implementierung der Methode `adjacentNodes` verwenden wir die Klasse
`ArrayList`, die eine Implementierung des Interface `List<T>` darstellt.

``` java
import java.util.ArrayList;
import java.util.List;

public class DirectedGraph {
  private int size;
  private boolean[][] matrix;

  public DirectedGraph(int size) {
    this.size = size;
    this.matrix = new boolean[size][size];
  }

  public int size() {
    return this.size;
  }

  public boolean hasEdge(int node1, int node2) {
    return this.matrix[node1][node2];
  }

  public void addEdge(int node1, int node2) {
    this.matrix[node1][node2] = true;
  }

  public void removeEdge(int node1, int node2) {
    this.matrix[node1][node2] = false;
  }

  public List<Integer> adjacentNodes(int node) {
    List<Integer> nodes = new ArrayList<Integer>();
    for (int i = 0; i < matrix.length; i++) {
      if (hasEdge(node, i)) {
        nodes.add(i);
      }
    }
    return nodes;
  }
}
```

Alternativ zu einer Adjazenzmatrix können für die Implementierung eines
Graphen auch Adjazenzlisten genutzt werden. Bei dieser Art der
Implementierung speichern wir für jeden Knoten *v* ∈ *V* die Menge der
adjazenten Knoten in Form einer Liste ab. Das heißt, die Kanten eines
Graphen werden durch ein Array repräsentiert, dessen Einträge Listen
sind. <a href="#figure:adjacency-matrix-gerichtet"
data-reference-type="autoref"
data-reference="figure:adjacency-matrix-gerichtet">[figure:adjacency-matrix-gerichtet]</a>
zeigt einen Beispielgraphen und dessen Darstellung mit Hilfe von
Adjazenzlisten. Dabei wird die leere Liste durch das Zeichen
repräsentiert.

Breitensuche
------------

In diesem Kapitel wollen wir uns einen Algorithmus auf der Datenstruktur
Graph anschauen. Wir betrachten einen Algorithmus, der die kürzesten
Wege zwischen zwei Punkten in einem Graph bestimmen kann.

Wie in der Einleitung beschrieben ist ein Algorithmus ein Vorgehen zur
“Lösung eines Problems”. Die Lösung eines Problems beschreibt dabei,
dass aus einer gegebenen Menge von Eingaben eine Ausgabe berechnet wird.
Die *Breitensuche* — auch *breadth-first search* oder *BFS* genannt —
berechnet zu einem Knoten in einem Graphen alle kürzesten Pfade zu allen
anderen Knoten in dem Graphen.

Das Resultat einer Breitensuche ist nicht ein einzelner Pfad, sondern
alle kürzesten Pfade ausgehend von einem Startknoten zu allen anderen
Knoten. Eine solche Menge von Pfaden führt zum Begriff des Baumes, der
auch für viele andere Datenstrukturen von Bedeutung ist.

Das Ergebnis einer Breitensuche wird auch als Breitensuchbaum
bezeichnet.
<a href="#figure:breitensuchbaum" data-reference-type="autoref"
data-reference="figure:breitensuchbaum">[figure:breitensuchbaum]</a>
zeigt den Breitensuchbaum für den Knoten *A* im gerichteten Graphen aus
<a href="#picture:graphen" data-reference-type="autoref"
data-reference="picture:graphen">[picture:graphen]</a>.

<a href="#algorithm:bfs" data-reference-type="autoref"
data-reference="algorithm:bfs">[algorithm:bfs]</a> zeigt einen
Algorithmus, der die kürzesten Wege berechnet, gemessen in Anzahl der
durchlaufenen Knoten von einem gegebenen Anfangsknoten zu allen anderen
Knoten im Graphen. Die Idee des Algorithmus ist wie folgt. Der
Startkoten hat Abstand 0. Die Knoten, die adjazent zum Startknoten sind,
haben den Abstand 1. Knoten, die adjazent zu den Knoten sind, die den
Abstand 1 haben, selbst aber nicht Abstand 0 haben, haben den Abstand 2.
Diese Argumentation lässt sich so fortsetzen, bis wir keine Knoten mehr
finden, die wir betrachten müssen. Wir müssen dabei allerdings darauf
achten, dass wir einen Knoten, den wir bereits besucht haben, nicht ein
weiteres Mal besuchen. Würden wir den Knoten wieder besuchen, würde
unser Algorithmus niemals terminieren.

Wir wollen also die Knoten in der Reihenfolge abarbeiten, in der wir sie
entdecken. Diese Reihenfolge können wir mit Hilfe einer Queue erzeugen.
<a href="#algorithm:bfs" data-reference-type="autoref"
data-reference="algorithm:bfs">[algorithm:bfs]</a> setzt das soeben
skizzierte intuitive Vorgehen um. Dabei sorgt das Array *color* dafür,
dass wir einen Knoten nicht zweimal besuchen. Anstelle der zwei
Farbwerte *white* und *gray* kann man auch ein Array mit booleschen
Werten verwenden, das angibt, ob ein Knoten bereits besucht wurde. Der
dritte Farbwert *black* wird lediglich genutzt, um zu illustrieren, wann
ein Knoten komplett abgearbeitet ist. Das heißt, ein Knoten ist weiß,
falls wir ihn noch nicht besucht haben, der Knoten wird grau, wenn wir
ihn entdeckt und schwarz, wenn wir ihn schließlich abgearbeitet haben.

**Initialisierung:** *color* ← *newArray*\[*n*\]
*dist* ← *newArray*\[*n*\] *pred* ← *newArray*\[*n*\]

*q* ← *newQueue()* **Startknoten:** *color*\[*v*\] ← *g**r**a**y*
*dist*\[*v*\] ← 0 *q*.*enqueue*(*v*) **Hauptschleife:**

Tiefensuche
-----------

Im Folgenden werden wir den Algorithmus Tiefensuche auf einem Graphen
vorstellen. Dieser Algorithmus durchläuft einen Graphen ähnlich wie die
Breitensuche Knoten für Knoten, aber in einer anderen Reihenfolge.
Anstatt in einer Front vorzugehen und zuerst alle Nachbarn zu besuchen,
also in der Breite zu suchen wie es die Breitensuche macht, wählt die
Tiefensuche direkt einen Knoten aus und wählt danach direkt wieder einen
Nachbarn des gewählten Nachbarn. Finden wir für einen Knoten keinen
weiteren Nachbarn mehr, so fahren wir mit dem nächsten Nachbarn des
Knotens fort, von dem wir ursprünglich gekommen sind. Man kann den
Algorithmus Tiefensuche wie in
<a href="#algorithm:dfs" data-reference-type="autoref"
data-reference="algorithm:dfs">[algorithm:dfs]</a> zu sehen mit Hilfe
von Rekursion implementieren.

**Initialisierung:** *color* ← *newArray*\[*n*\]
*pred* ← *newArray*\[*n*\]

**Startknoten:** *color*\[*v*\] ← *gray*

**Hauptschleife:**

<span id="algorithm:dfs" label="algorithm:dfs"></span>

{% include bottom-nav.html previous="?" next="?" %}
