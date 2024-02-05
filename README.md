# README

Beispiel Kundendatenbank mit Duplettenprüfung

## Dublettenprüfung
Es werden folgende Rüfungen durchgeführt

### Vergleich von Vorname, Nachname, Geburtsdatum, Hausnummer, PLZ und Stadt
Bei Vor- und Nachname wird die Postgres-Funktion SIMILARITY mti dem Mindestwert 0.7 verwendet. 
Somit wird z.B. bei einem Doppelnamen auch verschiedene Schreibweisen gefunden (Schmidt-Müeller, SchmidtMüeller, Schmidt Müller).
Das Geburtsdatum, die Hausnummer, die PLZ und die Stadt müssen exakt gleich sein. Stadt ist zwar derzeit ein Freitextfeld, sollte aber
in einer Produktivanwendung aus einem Dropdown ausgewählt werden.

### Vergleich der Adresse
Falls es bei den persönlichen Daten einen Treffer gibt, wird zusätzlich noch die Straße verglichen.
Vor dem Vergleich der Straße werden die Straßennamen standardisiert: Die Substrings 'straße', 'strasse' und 'strase' 
werden in 'str' umgewandelt, bevor sie verglichen werden. Außerdem werden jegliche andere Zeichen vom Straßennamen vor dem Vergleich entfernt (z.B. '.').
Somit würden z.B. Schillerstr. und Schillerstraße als gleich betrachtet werden. 