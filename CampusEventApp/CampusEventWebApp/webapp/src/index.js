import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import Home from "./pages/Home"
import { BrowserRouter as Router, Switch, Route } from "react-router-dom"

const root = ReactDOM.createRoot(document.getElementById("root"))
root.render(
  <React.StrictMode>
    <Router>
      <Switch>
        <Route>
          <Home path="/"/>
        </Route>
      </Switch>
    </Router>
  </React.StrictMode>
)
