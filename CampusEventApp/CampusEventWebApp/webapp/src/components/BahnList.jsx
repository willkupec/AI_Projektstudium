import { Box, FormGroup, Grid, Paper, Typography } from "@mui/material"
import { filter, get, map } from "lodash"
import Bahn from "./Bahn"
import { useEffect, useState } from "react"
import Checkbox from "./Checkbox"

const bahn1 = {
  _id: 1,
  art: "tram",
  nummer: "27",
  richtung: "Krankenhaus Köpenick",
  abfahrtszeit: "1:51",
  fahrradmitnahme: true,
  barrierefrei: false,
}

const bahn2 = {
  _id: 2,
  art: "bus",
  nummer: "296",
  richtung: "S + U Lichtenberg",
  abfahrtszeit: "1:53",
  fahrradmitnahme: false,
  barrierefrei: true,
}

const bahn3 = {
  _id: 3,
  art: "tram",
  nummer: "M17",
  richtung: "Karlshorst",
  abfahrtszeit: "1:53",
  fahrradmitnahme: false,
  barrierefrei: true,
}

const dummyBahns = [bahn1, bahn1, bahn2, bahn3, bahn3, bahn2, bahn1]

const BahnList = ({ name }) => {
  const [filteredBahns, setFilteredBahns] = useState(dummyBahns)
  const [numberFilter, setNumberFilter] = useState({
    21: true,
    27: true,
    37: true,
    60: true,
    67: true,
    M17: true,
    296: true,
  })
  const [transportTypeFilter, setTransportTypeFilter] = useState({
    tram: true,
    bus: true,
  })

  const changeNumberFilter = (number) =>
    setNumberFilter((prev) => ({
      ...prev,
      [number]: !get(numberFilter, number),
    }))

  const changeTransportTypeFilter = (transportType) =>
    setTransportTypeFilter((prev) => ({
      ...prev,
      [transportType]: !get(transportTypeFilter, transportType),
    }))

  useEffect(() => {
    setFilteredBahns(
      filter(dummyBahns, (bahn) => numberFilter[bahn.nummer] === true)
    )
  }, [numberFilter])

  useEffect(() => {
    setFilteredBahns(
      filter(dummyBahns, (bahn) => transportTypeFilter[bahn.art] === true)
    )
  }, [transportTypeFilter])

  console.log("filteredBahns:", filteredBahns)

  return (
    <Grid item xs={4.5}>
      <Paper
        borderRadius="10px"
        sx={{ backgroundColor: "#6FD95D", height: "100%" }}
      >
        <Paper
          elevation={10}
          sx={{
            backgroundColor: "#15A46E",
            height: "150px",
            textAlign: "center",
            alignContent: "center",
          }}
        >
          <Typography variant="h2" color="white">
            {name}
          </Typography>
        </Paper>
        <Grid
          container
          direction="row"
          spacing={2}
          paddingX={3}
          mt={1}
          sx={{
            overflowY: "scroll",
            height: "72vh",
            scrollbarWidth: "none",
          }}
        >
          {map(filteredBahns, (bahn) => {
            return <Bahn bahn={bahn} />
          })}
        </Grid>
        <Box
          sx={{
            position: "relative",
            width: "220px",
            height: "40px",
            bgcolor: "white",
            bottom: 170,
            left: 460,
            opacity: "20%",
            borderRadius: "15px",
            transition: "opacity 0.3s ease",
            ":hover": {
              opacity: 1,
            },
          }}
        >
          <FormGroup
            row="false"
            sx={{ display: "flex", justifyContent: "space-around" }}
          >
            <Checkbox
              label="Tram"
              checked={get(transportTypeFilter, "tram")}
              onChange={() => changeTransportTypeFilter("tram")}
            />
            <Checkbox
              label="Bus"
              checked={get(transportTypeFilter, "bus")}
              onChange={() => changeTransportTypeFilter("bus")}
            />
          </FormGroup>
        </Box>
        <Box
          sx={{
            position: "relative",
            width: "220px",
            height: "124px",
            bgcolor: "white",
            bottom: 160,
            left: 460,
            opacity: "20%",
            borderRadius: "15px",
            transition: "opacity 0.3s ease",
            ":hover": {
              opacity: 1,
            },
          }}
        >
          <FormGroup row="false" sx={{ ml: 2 }}>
            <Checkbox
              label="21"
              checked={get(numberFilter, "21")}
              onChange={() => changeNumberFilter("21")}
            />
            <Checkbox
              label="27"
              checked={get(numberFilter, "27")}
              onChange={() => changeNumberFilter("27")}
            />
            <Checkbox
              label="37"
              checked={get(numberFilter, "37")}
              onChange={() => changeNumberFilter("37")}
            />
            <Checkbox
              label="60"
              checked={get(numberFilter, "60")}
              onChange={() => changeNumberFilter("60")}
            />
            <Checkbox
              label="67"
              checked={get(numberFilter, "67")}
              onChange={() => changeNumberFilter("67")}
            />
            <Checkbox
              label="M17"
              checked={get(numberFilter, "M17")}
              onChange={() => changeNumberFilter("M17")}
            />
            <Checkbox
              label="296"
              checked={get(numberFilter, "296")}
              onChange={() => changeNumberFilter("296")}
            />
          </FormGroup>
        </Box>
      </Paper>
    </Grid>
  )
}

export default BahnList
