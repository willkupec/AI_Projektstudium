import React from 'react';
import './App.css';
import Header from './components/Header';
import Navbar from './components/navbar/Navbar';
import MainMenu from './components/MainMenu';
import Events from './components/events/Events';
import EventDetail from './components/eventdetail/EventDetail';
import { BrowserRouter as Router, Route, Routes, useNavigate } from 'react-router-dom';

function App() {
  return (
    <Router>
      <div className="App">
        <Header />
        <Routes>
          <Route exact path="/" element={<MainMenuWrapper />} />
          <Route path="/BVG" element={<div>BVG Component</div>} />
          <Route path="/Events" element={<Events />} />
          <Route path="/events/:id" element={<EventDetail />} />
          <Route path="/Lehrveranstaltungen" element={<div>Lehrveranstaltungen Component</div>} />
        </Routes>
        <Navbar />
      </div>
    </Router>
  );
}

const MainMenuWrapper = () => {
  const navigate = useNavigate();

  const handleNavigation = (path) => {
    navigate(`/${path}`);
  };

  return <MainMenu navigate={handleNavigation} />;
};

export default App;
