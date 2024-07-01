import React from "react"
import "./index.css"
import Home from "./pages/Home"
import { Routes, Route } from "react-router-dom"
import Mensa from "./pages/Mensa"
import Bahn from "./pages/Bahn"
import Event from "./pages/Event"

const App = () => (
  <Routes>
    <Route path="/" element={<Home />} />
    <Route path="/event/*" element={<Event />} />
    <Route path="/bahn" element={<Bahn />} />
    <Route path="/mensa" element={<Mensa />} />
  </Routes>
)

export default App
