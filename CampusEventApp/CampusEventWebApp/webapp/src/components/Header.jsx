import * as React from "react"
import AppBar from "@mui/material/AppBar"
import Toolbar from "@mui/material/Toolbar"
import { Link } from "react-router-dom"
import { Avatar, Stack } from "@mui/material"

const Header = () => {
  return (
    <AppBar position="static" sx={{ backgroundColor: "#6FD95D" }}>
      <Toolbar disableGutters alignItems="center" justifyContent="flex-end" sx={{right: "25px"}}>
        <Stack direction="row" spacing={2}>
          <Avatar
            alt="Mensa"
            src="https://i.imgur.com/JLW4tyw.png"
            component={Link}
            to="/mensa"
          />
          <Avatar
            alt="Bahn"
            src="https://i.imgur.com/nCDqp66.png"
            component={Link}
            to="/bahn"
          />
          <Avatar
            alt="Events"
            src="https://i.imgur.com/66iKABg.png"
            component={Link}
            to="/"
          />
        </Stack>
      </Toolbar>
    </AppBar>
  )
}
export default Header
