import { filter, map } from "lodash"
import Header from "../components/Header"
import { Container, Grid, Paper, TextField, Typography } from "@mui/material"
import { useEffect, useState } from "react"
import Event from "../components/Event"

const getEvents = async (setEvents) => {
  try {
    const response = await fetch("http://canwrobel.de:8090/events", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    })
    const data = await response.json()
    setEvents(data)
  } catch (error) {
    console.error("Error fetching events:", error)
  }
}

const Home = () => {
  const [events, setEvents] = useState([])
  const [filteredEvents, setFilteredEvents] = useState([])
  const [searchText, setSearchText] = useState("")

  useEffect(() => {
    getEvents(setEvents)
  }, [])

  const handleSearch = (e) => {
    const lowerCase = e.target.value.toLowerCase()
    setSearchText(lowerCase)
  }

  useEffect(() => {
    setFilteredEvents(
      filter(events, (event) => event.titel.toLowerCase().includes(searchText))
    )
  }, [events, searchText])

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
                  <Grid item sx={{ mr: 8, width: "400px" }}>
                    <TextField
                      variant="outlined"
                      placeholder="Search"
                      fullWidth
                      onChange={handleSearch}
                      sx={{
                        color: "white",
                        bgcolor: "white",
                        borderRadius: "10px",
                        "& .MuiOutlinedInput-root": {
                          "& fieldset": {
                            borderColor: "transparent",
                          },
                          "&:hover fieldset": {
                            borderColor: "transparent",
                          },
                          "&.Mui-focused fieldset": {
                            borderColor: "transparent",
                          },
                        },
                      }}
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
