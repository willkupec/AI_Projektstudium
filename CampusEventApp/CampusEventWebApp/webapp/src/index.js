import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import Home from "./pages/Home"
import { BrowserRouter as Router, Routes, Route } from "react-router-dom"
import Events from "./pages/Events"
import Bahn from "./pages/Bahn"

const root = ReactDOM.createRoot(document.getElementById("root"))
root.render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/events" element={<Events />} />
        <Route path="/bahn" element={<Bahn />} />
      </Routes>
    </Router>
  </React.StrictMode>
)
