const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Body-parser Middleware
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('public'));

let mongooseStuff = "mongodb+srv://canwrob:mopsmopsmops@cluster0.tv4rxwp.mongodb.net/Projektstudium"

mongoose.connect(mongooseStuff, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => console.log('MongoDB Connected'))
.catch(err => console.log(err));

const veranstaltungSchema = new mongoose.Schema({
    veranstalter: { type: String, default: "" },
    titel: { type: String, default: "" },
    beschreibung: { type: String, default: "" },
    tag: { type: Date, default: Date.now },  // Hier als Beispiel das aktuelle Datum als Default-Wert
    start: { type: String, default: "" },
    ende: { type: String, default: "" },
    typ: { type: String, default: "" },
    foto: { type: String, default: "" },
    ort: { type: String, default: "" }
});

const Veranstaltung = mongoose.model('Veranstaltung', veranstaltungSchema, 'Veranstaltungen');

// CRUD operations for Veranstaltung
app.post('/events', async (req, res) => {
    const newEvent = new Veranstaltung(req.body);
    try {
        await newEvent.save();
        res.status(201).send(newEvent);
    } catch (error) {
        res.status(400).send(error);
    }
});

app.get('/events', async (req, res) => {
    try {
        const events = await Veranstaltung.find({});
        res.send(events);
    } catch (error) {
        res.status(500).send(error);
    }
});

app.get('/events/:id', async (req, res) => {
    try {
        const event = await Veranstaltung.findById(req.params.id);
        if (!event) {
            return res.status(404).send('Event nicht gefunden');
        }
        res.send(event);
    } catch (error) {
       // res.status(500.send(error);
    }
});

app.put('/events/:id', async (req, res) => {
    try {
        const event = await Veranstaltung.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!event) {
            return res.status(404).send();
        }
        res.status(204).send();
    } catch (error) {
        res.status(400).send(error);
    }
});

app.delete('/events/:id', async (req, res) => {
    try {
        const event = await Veranstaltung.findByIdAndDelete(req.params.id);
        if (!event) {
            return res.status(404).send();
        }
        res.status(204).send();
    } catch (error) {
        res.status(500).send(error);
    }
});

const User = mongoose.model('User', new mongoose.Schema({
    username: String,
    password: String, // Ekelhaft, der sollte gehasht werden
    role: String
}), 'usr'); // Collection name

app.post('/users', async (req, res) => {
    const { username, password } = req.body;
    const user = await User.findOne({ username, password });

    if (!user) {
        return res.status(401).send('Unauthorized');
    }

    // Sendet Benutzerdaten ohne Passwort zurück
    const { password: _, ...userWithoutPassword } = user.toObject();
    res.send(userWithoutPassword);
});

const PORT = 80;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
