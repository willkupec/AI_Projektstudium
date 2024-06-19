import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const CreateEvent = () => {
  const [eventData, setEventData] = useState({
    titel: '',
    veranstalter: '',
    beschreibung: '',
    tag: '',
    start: '',
    ende: '',
    ort: '',
    typ: '',
    foto: ''
  });
  const navigate = useNavigate();

  const handleChange = (e) => {
    setEventData({ ...eventData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://malina.f4.htw-berlin.de/events/', eventData);
      alert('Veranstaltung erfolgreich erstellt!');
      navigate(`/events/${response.data._id}`);
    } catch (error) {
      console.error('Fehler beim Erstellen der Veranstaltung:', error);
      alert('Fehler beim Erstellen der Veranstaltung');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Titel:
        <input type="text" name="titel" value={eventData.titel} onChange={handleChange} required />
      </label>
      <label>
        Veranstalter:
        <input type="text" name="veranstalter" value={eventData.veranstalter} onChange={handleChange} required />
      </label>
      <label>
        Beschreibung:
        <textarea name="beschreibung" value={eventData.beschreibung} onChange={handleChange} required />
      </label>
      <label>
        Datum:
        <input type="date" name="tag" value={eventData.tag} onChange={handleChange} required />
      </label>
      <label>
        Startzeit:
        <input type="time" name="start" value={eventData.start} onChange={handleChange} required />
      </label>
      <label>
        Endzeit:
        <input type="time" name="ende" value={eventData.ende} onChange={handleChange} required />
      </label>
      <label>
        Ort:
        <input type="text" name="ort" value={eventData.ort} onChange={handleChange} required />
      </label>
      <label>
        Typ:
        <input type="text" name="typ" value={eventData.typ} onChange={handleChange} required />
      </label>
      <label>
        Foto URL:
        <input type="url" name="foto" value={eventData.foto} onChange={handleChange} />
      </label>
      <button type="submit">Veranstaltung erstellen</button>
    </form>
  );
};

export default CreateEvent;
