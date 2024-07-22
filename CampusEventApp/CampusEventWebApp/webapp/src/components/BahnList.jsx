import {
  Box,
  FormControlLabel,
  FormGroup,
  Grid,
  Paper,
  Typography,
} from "@mui/material"
import { map } from "lodash"
import Bahn from "./Bahn"
import { useState } from "react"
import Checkbox from "./Checkbox"

const bahn1 = {
  _id: 1,
  nummer: "27",
  richtung: "Krankenhaus Köpenick",
  abfahrtszeit: "1:51",
  fahrradmitnahme: true,
  barrierefrei: false,
}

const bahn2 = {
  _id: 2,
  nummer: "296",
  richtung: "S + U Lichtenberg",
  abfahrtszeit: "1:53",
  fahrradmitnahme: false,
  barrierefrei: true,
}

const bahn3 = {
  _id: 3,
  nummer: "M17",
  richtung: "Karlshorst",
  abfahrtszeit: "1:53",
  fahrradmitnahme: false,
  barrierefrei: true,
}

const dummyBahns = [bahn1, bahn1, bahn2, bahn3, bahn3, bahn2, bahn1]

const BahnList = ({ name }) => {
  const [currFilters, setCurrFilters] = useState([])
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
          {map(dummyBahns, (bahn) => {
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
            <Checkbox label="Tram" defaultChecked />
            <Checkbox label="Bus" defaultChecked />
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
            <Checkbox label="21" />
            <Checkbox label="27" />
            <Checkbox label="37" />
            <Checkbox label="60" />
            <Checkbox label="67" />
            <Checkbox label="M17" />
            <Checkbox label="296" />
          </FormGroup>
        </Box>
      </Paper>
    </Grid>
  )
}

export default BahnList
