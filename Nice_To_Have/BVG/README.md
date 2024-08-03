# Nice to have Idee: BVG

## Idee für unsere App:
Ein Abfahrplan für die Stationen an den jeweiligen HTW Campusen kann in unseren "Homescreen" AKA THE GRID.
Mit einer freundlichen Anfrage und einer kurzen Beschreibung unseres Kurses und Projektes haben wir dankenswerter Weise einen Zugang bekommen. 

Am 17.05. haben die Verantwortlichen für die VBB API uns einen Zugang gegeben

### SOLVED: Wie man JQ in Git Bash installiert


Git Bash als Administrator ausführen<br>
curl -L -o /usr/bin/jq.exe https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe<br>
in git bash rein pasten<br>
jq --version<br>
Beispiel für die Benutzung:<br>
{Valid CURL here please} | jq 


# BVG-API

Zugangsdaten angefragt

### Zugangsdaten bekommen
<details>
<summary>Startpunkt email</summary>

![image](https://github.com/user-attachments/assets/2264ac3d-80c6-479b-81e4-a37271dc4c36)

  
</details>

### Wie kommt man an die Haltestellendaten?
1. Erstmal schauen was kommt denn da für Info bei dem Endpoint<br>
GET https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32<br>

oder
```
curl https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32
```
<details>
<summary>Sieht so aus</summary>
<body><ul><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/arrivalBoard?wadl" target="_blank">Arrival Board</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/departureBoard?wadl" target="_blank">Departure Board</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/gisroute?wadl" target="_blank">GIS Route by Context</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/himsearch?wadl" target="_blank">HIM Search</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/journeyDetail?wadl" target="_blank">Journey detail</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/journeypos?wadl" target="_blank">Journey Position</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/location.nearbystops?wadl" target="_blank">Location Search by Coordinate</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/location.name?wadl" target="_blank">Location Search by Name</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/recon?wadl" target="_blank">Reconstruction</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/trip?wadl" target="_blank">Trip Search</a></li><li><a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/xsd" target="_blank">XSD</a></li></ul><a id="mycustomimage" href="#" download=""></a></body>

  
</details>
2. Wir wollen ja haltestelleninfos. Also klick departure board
<a href="https://vbb.demo.hafas.de//fahrinfo/restproxy/2.32/departureBoard?wadl" target="_blank">Departure Board</a>

<details>
<summary>Beispiel</summary>
  
```
BROKEN CURL
curl -G 'https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/location.name' \
     --data-urlencode 'der Schlüssel' \
     --data-urlencode 'input=HTW' \
     --data-urlencode 'format=json'
```
</details>

### Bitte alle Stationen durchsuchen die HTW enthalten
für bash die chevrons mit \ ersetzen!!
```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/location.name" ^
     --data-urlencode "accessId=REDACTED" ^
     --data-urlencode "input=HTW" ^
     --data-urlencode "format=json" > output.json

```
erinnerung: dieser curl holt ALLE Stationen die mit HTW beginnen! 


Randnotiz: es kommt ein xml zurück wenn man mit quatsch als accessId ancurlt:
```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/location.name" ^
     --data-urlencode "accessId=der Schlüssel" ^
     --data-urlencode "input=HTW" ^
     --data-urlencode "format=json" > output.json

```
Ergebnis:
![image](https://github.com/user-attachments/assets/82d608f8-9f1e-4935-a682-0e5dd92e796b)


Ergebnis: Alle Stationen, die HTW enthalten<br>
Treskowallee/HTW (Berlin): 900162004<br>
Rathenaustr./HTW (Berlin): 900181503<br>



```
SUCCESS: PLS GIB ALLE ABFAHRTEN für Treskowallee. Rathenaustr ersetze ID mit der der Rathenaustr
curl -G 'https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard' \
     --data-urlencode 'accessId=REDACTED' \
     --data-urlencode 'id=900162004' \
     --data-urlencode 'type=DEP' \
     --data-urlencode 'format=json'

```
jetzt nochmal cmd gerecht:
```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard" ^
     --data-urlencode "accessId=REDACTED" ^
     --data-urlencode "id=900162004" ^
     --data-urlencode "type=DEP" ^
     --data-urlencode "format=json" > departures.json

```
```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard" ^
     --data-urlencode "accessId=REDACTED" ^
     --data-urlencode "id=900181503" ^
     --data-urlencode "duration=10" ^
     --data-urlencode "type=DEP" ^
     --data-urlencode "format=json" > departures.json
```

diesen Curl in git bash ausführen für die aktuelle Zeit:
```

curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard" \
     --data-urlencode "accessId=REDACTED" \
     --data-urlencode "id=900181503" \
     --data-urlencode "date=2024-07-31" \
     --data-urlencode "time=13:45" \
     --data-urlencode "duration=20" \
     --data-urlencode "type=DEP" \
     --data-urlencode "format=json" > departures.json
```

```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard" ^
     --data-urlencode "accessId=REDACTED" ^
     --data-urlencode "id=900181503" ^
     --data-urlencode "date=2024-07-31" ^  
     --data-urlencode "time=13:30" ^
     --data-urlencode "duration=10" ^
     --data-urlencode "type=DEP" ^
     --data-urlencode "format=json" > departures.json

```

finde den Fehler:
```
curl -G "https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard" ^
     --data-urlencode "accessID=REDACTED" ^
     --data-urlencode "id=900181503" ^
     --data-urlencode "duration=10" ^
     --data-urlencode "type=DEP" ^
     --data-urlencode "format=json" > departures.json
```

Das können wir nun verwenden


<details>
<summary>Beispiel</summary>
Nicht überschrteiben nur kopieren.
</details>
