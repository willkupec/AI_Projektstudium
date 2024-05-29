import React from 'react';
import './App.css';
import MainMenu from './components/MainMenu';
import { BrowserRouter as Router, Route, Routes, useNavigate } from 'react-router-dom';

const BVG = () => <div>BVG Component</div>;
const Events = () => <div>Events Component</div>;
const Lehrveranstaltungen = () => <div>Lehrveranstaltungen Component</div>;

const App = () => {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route exact path="/" element={<MainMenuWrapper />} />
          <Route path="/BVG" element={<BVG />} />
          <Route path="/Events" element={<Events />} />
          <Route path="/Lehrveranstaltungen" element={<Lehrveranstaltungen />} />
        </Routes>
      </div>
    </Router>
  );
};

const MainMenuWrapper = () => {
  const navigate = useNavigate();

  const handleNavigation = (path) => {
    navigate(`/${path}`);
  };

  return <MainMenu navigate={handleNavigation} />;
};

export default App;
