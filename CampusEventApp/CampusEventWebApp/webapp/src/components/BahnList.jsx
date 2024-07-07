import { Grid, Paper, Typography } from "@mui/material"
import { map } from "lodash"
import Bahn from "./Bahn"

const bahn1 = {
  _id: 1,
  nummer: 27,
  richtung: "Krankenhaus Köpenick",
  abfahrtszeit: "1:51",
  fahrradmitnahme: true,
  barrierefrei: false,
}

const bahn2 = {
  _id: 2,
  nummer: 296,
  richtung: "S + U Lichtenberg",
  abfahrtszeit: "1:53",
  fahrradmitnahme: false,
  barrierefrei: true,
}

const dummyBahns = [bahn1, bahn1, bahn2, bahn1, bahn1, bahn2, bahn1]

const BahnList = ({ name }) => {
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
            height: "70vh",
            scrollbarWidth: "none",
          }}
        >
          {map(dummyBahns, (bahn) => {
            return <Bahn bahn={bahn} />
          })}
        </Grid>
      </Paper>
    </Grid>
  )
}

export default BahnList
