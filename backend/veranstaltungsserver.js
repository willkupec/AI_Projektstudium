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
    veranstalterId: { type: String, default: "" },
    veranstalterName: { type: String, default: ""},
    titel: { type: String, default: "" },
    beschreibung: { type: String, default: "" },
    tag: { type: Date, default: Date.now }, 
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

// POSTS

const postSchema = new mongoose.Schema({
    eventId: { type: String, required: true },
    authorId: { type: String, required: true },
    authorName: { type: String, required: true },
    title: { type: String, required: true },
    content: { type: String, required: true },
    createdAt: { type: Date, default: Date.now },
    isOnceEdited: { type: Boolean, default: false },
});

const Post = mongoose.model('Post', postSchema, 'Posts');

// Route to fetch posts by eventID
app.get('/events/:eventID/posts', async (req, res) => {
    try {
        const posts = await Post.find({ eventId: req.params.eventID });
        res.send(posts);
    } catch (error) {
        res.status(500).send(error);
    }
});

app.post('/events/:eventID/posts', async (req, res) => {
    const { eventID } = req.params;
    const { authorId, authorName, title, content } = req.body;
    
    const newPost = new Post({
        eventId: eventID,
        authorId,
        authorName,
        title,
        content
    });
    
    try {
        await newPost.save();
        res.status(201).send(newPost);
    } catch (error) {
        res.status(400).send(error);
    }
});

app.put('/events/:eventID/posts/:postID', async (req, res) => {
    const { postID } = req.params;
    
    try {
        const post = await Post.findByIdAndUpdate(postID, req.body, { new: true, runValidators: true });
        if (!post) {
            return res.status(404).send();
        }
        res.status(204).send();
    } catch (error) {
        res.status(400).send(error);
    }
});

app.delete('/events/:eventID/posts/:postID', async (req, res) => {
    const { postID } = req.params;
    
    try {
        const post = await Post.findByIdAndDelete(postID);
        if (!post) {
            return res.status(404).send();
        }
        res.status(204).send();
    } catch (error) {
        res.status(500).send(error);
    }
});

// UPDATE AUTHOR INFO for posts and events when user updates name

app.put('/users/:userID/update-posts', async (req, res) => {
    const { userID } = req.params;
    const { newAuthorName } = req.body;

    try {
        const result = await Post.updateMany({ authorId: userID }, { authorName: newAuthorName, isOnceEdited: true });
        res.send(result);
    } catch (error) {
        res.status(500).send(error);
    }
});

app.put('/users/:userID/update-events', async (req, res) => {
    const { userID } = req.params;
    const { newOrganizerName } = req.body;

    try {
        const result = await Veranstaltung.updateMany({ veranstalterId: userID }, { veranstalterName: newOrganizerName });
        res.send(result);
    } catch (error) {
        res.status(500).send(error);
    }
});




const PORT = 80;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
