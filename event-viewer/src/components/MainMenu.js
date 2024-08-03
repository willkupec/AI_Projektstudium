import React from 'react';
import './MainMenu.css';

const MainMenu = ({ navigate }) => {
  return (
    <div className="main-menu">
      <h1>Willkommen zur Event-App</h1>
      <div className="menu-grid">
        <div className="menu-item bvg" onClick={() => navigate('BVG')}>
          BVG
        </div>
        <div className="menu-item events" onClick={() => navigate('Events')}>
          Events
        </div>
        <div className="menu-item lehrveranstaltungen" onClick={() => navigate('Lehrveranstaltungen')}>
          Lehrveranstaltungen
        </div>
      </div>
    </div>
  );
};

export default MainMenu;
