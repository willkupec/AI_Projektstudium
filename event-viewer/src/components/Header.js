import React from 'react';
import './Header.css';

const Header = () => {
  return (
    <div className="header">
      <img src="../../public/htw.png" alt="Header" className="header-image" />
      <div className="header-text">Willkommen zu unserer App</div>
    </div>
  );
};

export default Header;
