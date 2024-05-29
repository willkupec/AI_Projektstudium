BEISPIEL FÜR ADD Event:


curl -X POST http://malina.f4.htw-berlin.de/events \
-H "Content-Type: application/json" \
-d '{
    "veranstalter": "Beispielveranstalter",
    "titel": "Beispieltitel",
    "beschreibung": "Das ist eine Beispielbeschreibung für ein Event.",
    "tag": "2024-05-29T00:00:00Z",
    "start": "10:00",
    "ende": "14:00",
    "typ": "Vorlesung",
    "foto": "http://example.com/foto.jpg",
    "ort": "Berlin"
}'
