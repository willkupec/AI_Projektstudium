# Was bisher geschah

Zugangsdaten angefragt

Zugangsdaten bekommen
<details>
<summary>Startpunkt email</summary>

![image](https://github.com/user-attachments/assets/2264ac3d-80c6-479b-81e4-a37271dc4c36)

  
</details>

### Wie kommt man an die Haltestellendaten?
1. Erstmal schauen was kommt denn da für Info bei dem Endpoint<br>
GET https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32<br>
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

```
SUCCESS: curl gib pls alle Stationen die "HTW enthalten"
curl -G 'https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/location.name' \
     --data-urlencode 'accessID=der Schlüssel' \
     --data-urlencode 'input=HTW' \
     --data-urlencode 'format=json'
```

Ergebnis: Alle Stationen, die HTW enthalten<br>
Treskowallee/HTW (Berlin): 900162004<br>
Rathenaustr./HTW (Berlin): 900181503<br>

```
SUCCESS: PLS GIB ALLE ABFAHRTEN für Treskowallee. Rathenaustr ersetze ID mit der der Rathenaustr
curl -G 'https://vbb.demo.hafas.de/fahrinfo/restproxy/2.32/departureBoard' \
     --data-urlencode 'accessId=htw-6e3e-4a39-86ac-1c6222a26f0b' \
     --data-urlencode 'id=900162004' \
     --data-urlencode 'type=DEP' \
     --data-urlencode 'format=json'

```

Das können wir nun verwenden


<details>
<summary>Beispiel</summary>
Nicht überschrteiben nur kopieren.
</details>
