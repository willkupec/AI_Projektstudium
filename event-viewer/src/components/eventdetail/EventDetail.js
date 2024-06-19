import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';
import './EventDetail.css';

const EventDetail = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [event, setEvent] = useState(null);

  useEffect(() => {
    const fetchEvent = async () => {
      try {
        const response = await axios.get(`http://malina.f4.htw-berlin.de/events/${id}`);
        setEvent(response.data);
      } catch (error) {
        console.error('Error fetching event:', error);
      }
    };

    fetchEvent();
  }, [id]);

  const navigateToComments = () => {
    navigate(`/events/${id}/comments`);
  };

  if (!event) {
    return <div>Loading...</div>;
  }

  return (
    <div className="event-detail">
      <img src={event.foto} alt={event.titel} className="event-detail-image" />
      <h1>{event.titel}</h1>
      <p><strong>Veranstalter:</strong> {event.veranstalter}</p>
      <p><strong>Beschreibung:</strong> {event.beschreibung}</p>
      <p><strong>Datum:</strong> {new Date(event.tag).toLocaleDateString()}</p>
      <p><strong>Uhrzeit:</strong> {event.start} - {event.ende}</p>
      <p><strong>Ort:</strong> {event.ort}</p>
      <p><strong>Typ:</strong> {event.typ}</p>
      <button onClick={navigateToComments}>Zum Chat</button>
    </div>
  );
};


export default EventDetail;
