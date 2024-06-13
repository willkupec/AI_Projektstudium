import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import Home from "./pages/Home"
import { BrowserRouter as Router, Routes, Route } from "react-router-dom"
import Mensa from "./pages/Mensa"
import Bahn from "./pages/Bahn"

const root = ReactDOM.createRoot(document.getElementById("root"))
root.render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/bahn" element={<Bahn />} />
        <Route path="/mensa" element={<Mensa />} />
      </Routes>
    </Router>
  </React.StrictMode>
)
