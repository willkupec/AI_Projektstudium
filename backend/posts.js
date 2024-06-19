const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// Definiere das Kommentar-Schema
const commentSchema = new mongoose.Schema({
    eventID: { type: mongoose.Schema.Types.ObjectId, ref: 'Veranstaltungen' },
    posterUsername: { type: String, required: true },
    text: { type: String, required: true },
    createdAt: { type: Date, default: Date.now }
});

const Comment = mongoose.model('Comment', commentSchema, 'posts');

// Routen für Kommentare
router.post('/events/:id/comments', async (req, res) => {
    const { text, posterUsername } = req.body;
    const eventID = req.params.id;

    const newComment = new Comment({
        eventID,
        posterUsername,
        text
    });

    try {
        await newComment.save();
        res.status(201).send(newComment);
    } catch (error) {
        res.status(400).send(error);
    }
});

router.get('/events/:id/comments', async (req, res) => {
    try {
        const comments = await Comment.find({ eventID: req.params.id });
        res.send(comments);
    } catch (error) {
        res.status(500).send(error);
    }
});

module.exports = router;
