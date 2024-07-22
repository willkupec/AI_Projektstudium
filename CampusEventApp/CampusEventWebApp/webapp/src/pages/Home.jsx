import { filter, map } from "lodash"
import Header from "../components/Header"
import { Container, Grid, Paper, TextField, Typography } from "@mui/material"
import { useEffect, useState } from "react"
import Event from "../components/Event"

const event1 = {
  _id: 1,
  titel: "Jazz Party",
  tag: "10.02.2024",
  start: "14:30",
  ende: "20:00",
  foto: "https://i.imgur.com/c9c4U2q.png",
  beschreibung:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}
const event2 = {
  _id: 2,
  titel: "Quiz Night",
  tag: "12.02.2024",
  start: "19:00",
  ende: "20:00",
  foto: "https://i.imgur.com/vQ6q3Xq.jpg",
  beschreibung:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event3 = {
  _id: 3,
  titel: "Jazz Party",
  tag: "10.02.2024",
  start: "14:30",
  ende: "20:00",
  foto: "https://i.imgur.com/c9c4U2q.png",
  beschreibung:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event4 = {
  _id: 4,
  titel: "Quiz Night",
  tag: "12.02.2024",
  start: "19:00",
  ende: "20:00",
  foto: "https://i.imgur.com/vQ6q3Xq.jpg",
  beschreibung:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const dummyEvents = [event1, event2, event3, event4, event4, event4, event4]

/* const getEvents = async (setEvents) => {
  return fetch("http://malina.f4.htw-berlin.de:8080/events", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => setEvents(data))
} */

const Home = () => {
  const [filteredEvents, setFilteredEvents] = useState([])
  const [searchText, setSearchText] = useState("")

  /*
  useEffect(() => {
    getEvents(setEvents)
  }, []) */

  const handleSearch = (e) => {
    const lowerCase = e.target.value.toLowerCase()
    setSearchText(lowerCase)
  }

  useEffect(() => {
    setFilteredEvents(
      filter(dummyEvents, (event) =>
        event.titel.toLowerCase().includes(searchText)
      )
    )
  }, [searchText])

  return (
    <>
      <Header />
      <Container
        maxWidth="false"
        disableGutters
        sx={{ height: "100%", position: "fixed" }}
      >
        <Grid container padding={2} columnSpacing={2} sx={{ bgcolor: "black" }}>
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
              xs={6}
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                overflow: "hidden",
              }}
            >
              <Paper
                component="img"
                alt="htw_logo"
                src="https://i.imgur.com/K1Jc19l.png"
                borderRadius="10px"
                elevation={5}
                sx={{ width: "100%", height: "auto" }}
              ></Paper>
            </Grid>
            <Grid
              item
              xs={6}
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                overflow: "hidden",
              }}
            >
              <Paper
                component="img"
                alt="campus_banner"
                src="https://i.imgur.com/omsunDN.jpg"
                borderRadius="10px"
                elevation={5}
                sx={{ width: "100%", height: "auto" }}
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
                  display: "flex",
                  pl: "60px",
                }}
              >
                <Grid
                  container
                  sx={{
                    textAlign: "start",
                    alignContent: "center",
                    alignItems: "center",
                    justifyContent: "space-between",
                  }}
                >
                  <Grid item>
                    <Typography variant="h2" color="white" fontWeight="bold">
                      HTW Berlin Campus Events
                    </Typography>
                  </Grid>
                  <Grid item sx={{ mr: 8, mt: 1, width: "400px" }}>
                    <TextField
                      variant="outlined"
                      label="Search"
                      fullWidth
                      onChange={handleSearch}
                    />
                  </Grid>
                </Grid>
              </Paper>
              <Grid
                container
                direction="row"
                spacing={2}
                paddingX={3}
                mt={1}
                sx={{
                  overflowY: "scroll",
                  height: "70vh",
                  scrollbarWidth: "none",
                }}
              >
                {map(filteredEvents, (event) => (
                  <Event event={event} />
                ))}
              </Grid>
            </Paper>
          </Grid>
        </Grid>
      </Container>
    </>
  )
}

export default Home
