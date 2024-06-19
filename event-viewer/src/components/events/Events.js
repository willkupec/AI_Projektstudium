import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import './Events.css';

const Events = () => {
  const [events, setEvents] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchEvents = async () => {
      try {
        const response = await axios.get('http://malina.f4.htw-berlin.de/events/');
        setEvents(response.data);
      } catch (error) {
        console.error('Error fetching events:', error);
      }
    };

    fetchEvents();
  }, []);

  const handleEventClick = (id) => {
    navigate(`/events/${id}`);
  };

  return (
    <div className="events-container">
      {events.map(event => (
        <div className="event-row" key={event._id} onClick={() => handleEventClick(event._id)}>
          <img src={event.foto} alt={event.titel} className="event-image" />
          <div className="event-details">
            <h2 className="event-title">{event.titel}</h2>
            <p className="event-dates">
              <strong>Start:</strong> {event.start}
              <br />
              <strong>Ende:</strong> {event.ende}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
};

export default Events;
