---
layout: post
title: "Versionskontrolle"
---

1. [Installation von Git unter Windows](#installation-von-git-unter-windows)
2. [Konfiguration des Nutzers](#konfiguration-des-nutzers)
3. [Git über die Konsole bedienen](#git-über-die-konsole-bedienen)
4. [Commit-Nachrichten schreiben](#commit-nachrichten-schreiben)


## Installation von Git unter Windows

Zuerst <https://git-scm.com/download/win> den _Installer_ herunterladen.
Der Download sollte automatisch starten.
Im Installationsprozess sollte eine Konfiguration geändert werden.
Im ersten Schritt `Select Components` sollte die `Windows Explorer integration` mit `Git Bash Here` ausgewählt sein. Dies ist standardmäßig der Fall.
Im zweiten Schritt `Choosing the default editor used by Git` sollte ein anderer Editor als Vim verwendet werden.
Sie können entweder Ihren Lieblingseditor aus der Liste auswählen oder den Punkt `Select other editor as Git's default editor`.
Als `Location of editor` tragen Sie dann Ihren Editor ein oder einfach `C:\Windows\notepad.exe` für den Editor von Windows.
Ab diesem Punkt können die Standardeinstellungen genutzt werden, am Ende auf `Install` klicken.
Nach der erfolgreichen Installation nur noch kurz das Häkchen bei `View Release Notes` entfernen und mit `Next` den _Installer_ beenden.

Um git zu verwenden, öffnen Sie mit dem Windows Explorer den Ordner, in dem Sie die Bearbeitung der Aufgaben vornehmen wollen.
Mit einem Rechtsklick in dem Ordner können Sie nun im Kontextmenü `Git Bash Here` auswählen, es öffnet sich ein Konsolenfenster.

**Hinweise:**
- Die `Git Bash` nutzt die Tastenkombination `Strg + Einfg` für Kopieren und `Umschalt + Einfg` für Einfügen statt der üblichen `Strg + C` für Kopieren und `Strg + V` für Einfügen.
- Die `Git Bash` unterstützt Autovervollständigung für Dateien, das heißt, statt den gesamten Pfad anzugeben, können Sie den Pfad starten und dann `Tab` drücken, damit der Pfad vervollständigt wird.


## Konfiguration des Nutzers

Damit GitHub Ihnen die Commits, die Sie durchführen, zuordnen kann, sollten Sie einmal Ihren Namen und Ihre Mail-Adresse setzen.
Dazu müssen Sie in der Konsole die folgenden beiden Befehle eingeben und jeweils mit der _Eingabe_-Taste bestätigen.
Sie müssen dabei meinen Namen und meine E-Mail-Adresse natürlich durch Ihre jeweiligen Informationen ersetzen.
Sie sollten eine E-Mail-Adresse nutzen, die Sie auch bei GitHub eingetragen haben.
Bitte beachten Sie, dass die E-Mail-Adresse von Personen eingesehen werden kann, die Zugriff auf das Repository haben.

```console
$ git config --global user.name "Jan Christiansen"
```

```console
$ git config --global user.email "jan.christiansen@hs-flensburg.de"
```

Unter [diesem Link](https://docs.github.com/en/free-pro-team@latest/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address#setting-your-commit-email-address-in-git) findet ihr bei Interesse noch eine alternative Erklärung und zusätzliche Informationen zu dieser Konfiguration und GitHub.


## Git über die Konsole bedienen

Zum Bearbeiten und zur Abgabe der Aufgaben müssen Sie den über GitHub bereitgestellten Source-Code über die Konsole verwalten.  

### Repository klonen

Damit Sie den Code lokal bearbeiten können, müssen Sie das Repo klonen.
Sie benötigen dafür zunächst einen _SSH Key_.
Diesen müssen Sie zu Ihrem GitHub-Account hinzufügen.
Eine ausführliche Erklärung zur Generierung eines _SSH Keys_ und dem Hinzufügen des _SSH Keys_ zu Ihrem GitHub-Account finden Sie [hier](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh).

Anschließend benötigen Sie die URL Ihres Repositories.
Diese erhalten Sie auf der GitHub-Webseite:

![](images/git/step1.jpg)

Mithilfe der URL können Sie das Repository über Ihre Konsole mit `git clone <url>` herunterladen.
Sofern Sie der Generierung des _SSH Keys_ eine _Passphrase_ festgelegt habt, müssen Sie diese nun eingeben.

```console
$ git clone git@github.com:HS-Flensburg-Algo/laboraufgabe00-jan-christiansen.git
```

Anschließend wechseln Sie in das heruntergeladene Repository mit `cd <repo-name>`.

```console
$ cd laboraufgabe00-jan-christiansen
```

### Bearbeitete Dateien hochladen

Nachdem Sie die Aufgabe bearbeitet haben, können Sie mit `git status` alle editierten Dateien sehen.

```console
$ git status
On branch master
Your branch is up to data with `origin/master`.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

       modified:   src/main/java/de/fuas/algorithms/HelloWorld.java

no changes added to commit (use "git add" and/or "git commit -a")
```

Die Dateien, die Sie abgeben wollen, müssen nun jeweils mit `git add <filepath>` hinzugefügt werden.

```console
$ git add src/main/java/de/fuas/algorithms/HelloWorld.java
```

**Hinweis:**
- Sie können auch mehrere Dateien auf einmal hinzufügen, indem Sie die Dateipfade durch Leerzeichen getrennt auflistet, also zum Beispiel `git add <filepath1> <filepath2>`.

Zum Überprüfen, ob alle abzugebenden Dateien ausgewählt/hinzugefügt wurden, kann erneut `git status` aufgerufen werden.
Alle in grün geschriebenen Dateien wurden zur Abgabe selektiert.
Die Ausgabe sieht dann zum Beispiel wie folgt aus.

```console
$ git status
On branch master
Your branch is up to data with `origin/master`.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

       modified:    src/main/java/de/fuas/algorithms/HelloWorld.java
```

Vor dem Hochladen in das Repository müssen die Dateien "committet" werden.
Einen _Commit_ führt man mit dem Kommando `git commit -m "<commit-message>"` durch.
Der Text `<commit-message>` ist dabei eine Beschreibung der Arbeiten, die Sie durchgeführt haben und die Sie mit dem _Commit_ bei GitHub hochladen wollen.

```console
$ git commit -m "Change ..."
[master 7d612e] Change ...
 1 file changed, 1 deletion(-)
```

Das Hochladen der Bearbeitung erfolgt zu guter Letzt mit `git push`.
Mit dem Befehl `git push` werden alle _Commits_, die Sie seit dem letzten `git push` durchgeführt haben, hochgeladen.

```console
$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compresiosn using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 366 bytes | 366.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com:HS-Flensburg-Algo/laboraufgabe00-jan-christiansen.git
   f82bb14..d079b90  main -> main
```

### Mögliche Probleme

Es kann vorkommen, dass der Befehl `git push` nicht erfolgreich ist und ihr zum Beispiel eine Fehlermeldung der folgenden Art erhaltet.

```console
To github.com:HS-Flensburg-Algo/laboraufgabe00-jan-christiansen.git
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'git@github.com:HS-Flensburg-Algo/laboraufgabe00-jan-christiansen.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Dies passiert zum Beispiel, wenn Sie parallel mithilfe des Web-Interface von GitHub Dateien hochgeladen oder Dateien verändert haben.
Um dieses Problem zu beheben, müssen Sie einmal die Änderungen, die im Repo passiert sind, zu Ihnen auf den Rechner holen.
Dazu müssen Sie den Befehl `git pull` ausführen.
Nach Ausführung des Befehls sollte sich ein Editor öffnen.
Den Editor können Sie einfach schließen und die Datei speichern.
Danach sollte eine Nachricht der folgenden Art erscheinen.

```console
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 10 (delta 3), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (10/10), done.
From github.com:HS-Flensburg-Algo/laboraufgabe00-jan-christiansen
   a7a5355..e6dd480  master     -> origin/master
Merge made by the 'recursive' strategy.
 .github/classroom/autograding.json | 14 ++++++++++++++
 .github/workflows/classroom.yml    | 11 +++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 .github/classroom/autograding.json
 create mode 100644 .github/workflows/classroom.yml
```

Jetzt sollten Sie ganz normal mit dem Befehl `git push` fortfahren können.


## Commit-Nachrichten schreiben

Wenn man professionell Software entwickelt, sollte man sich etwas Mühe mit den _Commit_-Nachrichten geben.
Wie in vielen anderen Bereichen der Informatik sollten die Nachrichten zumindest erst einmal einheitlich sein.
Sie sollten sich im Zuge der Veranstaltung gern so gut es geht an die Vorschläge unter [How to Write a Git Commit Message](https://cbea.ms/git-commit/) halten.
Aufgrund der recht kleinen Projekte, die im Rahmen der Vorlesung programmiert werden, reicht es, wenn Ihre _Commit_-Nachrichten nur aus einem _Subject_ bestehen.
Das heißt, mögliche Nachrichten wären zum Beispiel `Add first implementation of ArrayList`, `Fix size method` oder `Rename class to ArrayList`. 
