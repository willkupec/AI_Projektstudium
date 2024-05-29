import React from 'react';
import './Navbar.css';

const Navbar = () => {
  return (
    <div className="navbar">
      <div className="nav-item">
        <img src="/icon1.png" alt="Icon 1" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="/icon2.png" alt="Icon 2" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="/icon3.png" alt="Icon 3" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="/icon4.png" alt="Icon 4" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="/icon5.png" alt="Icon 5" className="nav-icon" />
      </div>
    </div>
  );
};

export default Navbar;
