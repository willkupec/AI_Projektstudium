import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';

const Comments = () => {
  const { id } = useParams();
  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");

  useEffect(() => {
    const fetchComments = async () => {
      try {
        const response = await axios.get(`http://malina.f4.htw-berlin.de/events/${id}/comments`);
        setComments(response.data);
      } catch (error) {
        console.error('Error fetching comments:', error);
      }
    };

    fetchComments();
  }, [id]);

  const postComment = async () => {
    if (newComment.trim() !== "") {
      try {
        let username = "this.username";
        const response = await axios.post(`http://malina.f4.htw-berlin.de/events/${id}/comments`, {
          text: newComment,
          posterUsername: username, // Hier solltest du die Logik für die Identifikation des Benutzernamens einfügen
        });
        setComments([...comments, response.data]);
        setNewComment("");
      } catch (error) {
        console.error('Error posting comment:', error);
      }
    }
  };

  return (
    <div className="comments-container">
        <h2 className="comments-header">Chat</h2>
        <div>
            {comments.map(comment => (
                <div key={comment._id} className="comment">
                    <p><strong>{comment.posterUsername}:</strong> {comment.text}</p>
                </div>
            ))}
        </div>
        <div className="new-comment">
            <textarea
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
                placeholder="Schreibe einen Kommentar..."
            />
            <button onClick={postComment}>Kommentar absenden</button>
        </div>
    </div>
);
};

export default Comments;
