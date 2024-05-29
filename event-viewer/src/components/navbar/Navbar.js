import React from 'react';
import './Navbar.css';

const Navbar = () => {
  return (
    <div className="navbar">
      <div className="nav-item">
        <img src="https://cdn-icons-png.freepik.com/256/1077/1077063.png" alt="Icon 1" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="https://cdn-icons-png.freepik.com/256/1077/1077035.png" alt="Icon 2" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="https://cdn-icons-png.freepik.com/256/1077/1077042.png" alt="Icon 3" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="https://cdn-icons-png.freepik.com/256/1151/1151429.png" alt="Icon 4" className="nav-icon" />
      </div>
      <div className="nav-item">
        <img src="https://cdn-icons-png.freepik.com/256/739/739260.png" alt="Icon 5" className="nav-icon" />
      </div>
    </div>
  );
};

export default Navbar;
