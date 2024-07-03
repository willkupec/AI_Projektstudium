import { map } from "lodash"
import Header from "../components/Header"
import ListEvent from "../components/ListEvent"
import { Box, Container, Grid, Paper, Typography } from "@mui/material"
import { useEffect, useState } from "react"

const getEvents = async (setEvents) => {
  return fetch("http://malina.f4.htw-berlin.de/events", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => setEvents(data))
}

const Home = () => {
  const [events, setEvents] = useState([])

  useEffect(() => {
    getEvents(setEvents)
  }, [])

  return (
    <Container
      maxWidth="false"
      maxHeight="false"
      disableGutters
      sx={{ height: "100vh", position: "absolute" }}
    >
      <Header />
      <Grid container padding={2} sx={{ bgcolor: "black" }}>
        <Grid
          container
          item
          direction="column"
          rowSpacing={2}
          xs={3}
          sx={{ height: "100%" }}
        >
          <Grid
            item
            sx={{
              width: "96.5%",
              height: "100%",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <Paper
              component="img"
              alt="htw_logo"
              src="https://i.imgur.com/K1Jc19l.png"
              borderRadius="10px"
              elevation={5}
              sx={{ overflow: "hidden" }}
            ></Paper>
          </Grid>
          <Grid
            item
            sx={{
              width: "96.5%",
              height: "100%",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <Paper
              component="img"
              alt="campus_banner"
              src="https://i.imgur.com/omsunDN.jpg"
              borderRadius="10px"
              elevation={5}
              sx={{ overflow: "hidden" }}
            ></Paper>
          </Grid>
        </Grid>
        <Grid item xs={9}>
          <Paper
            borderRadius="10px"
            sx={{ backgroundColor: "#6FD95D", height: "100%" }}
          >
            <Paper
              elevation={10}
              sx={{
                backgroundColor: "#15A46E",
                height: "150px",
                textAlign: "start",
                alignContent: "center",
                pl: "60px",
              }}
            >
              <Typography variant="h2" color="white">
                HTW Berlin Campus Events
              </Typography>
            </Paper>
            <Grid
              container
              direction="row"
              spacing={2}
              padding={3}
              sx={{ overflowY: "hidden" }}
            >
              {map(events, (event) => {
                return <ListEvent event={event} />
              })}
            </Grid>
          </Paper>
        </Grid>
      </Grid>
    </Container>
  )
}

export default Home
