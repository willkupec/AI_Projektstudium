import { map } from "lodash"
import Header from "../components/Header"
import ListEvent from "../components/ListEvent"
import { Grid, Paper, Typography } from "@mui/material"

const event1 = {
  id: 1,
  title: "Jazz Party",
  date: "10.02.2024",
  time: "14:30",
  src: "https://i.imgur.com/c9c4U2q.png",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event2 = {
  id: 2,
  title: "Quiz Night",
  date: "12.02.2024",
  time: "19:00",
  src: "https://i.imgur.com/vQ6q3Xq.jpg",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event3 = {
  id: 3,
  title: "Jazz Party",
  date: "10.02.2024",
  time: "14:30",
  src: "https://i.imgur.com/c9c4U2q.png",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event4 = {
  id: 4,
  title: "Quiz Night",
  date: "12.02.2024",
  time: "19:00",
  src: "https://i.imgur.com/vQ6q3Xq.jpg",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const events = [event1, event2, event3, event4, event1, event2]

const Home = () => {
  return (
    <>
      <Header />
      <Grid container padding={2} paddingBottom={0}>
        <Grid
          container
          item
          direction="column"
          rowSpacing={2}
          xs={3}
        >
          <Grid item>
            <Paper
              component="img"
              alt="htw_logo"
              src="https://i.imgur.com/K1Jc19l.png"
              width="400px"
              borderRadius="10px"
              elevation={5}
            ></Paper>
          </Grid>
          <Grid item>
            <Paper
              component="img"
              alt="campus_banner"
              src="https://i.imgur.com/omsunDN.jpg"
              width="400px"
              borderRadius="10px"
              elevation={5}
            ></Paper>
          </Grid>
        </Grid>
        <Grid
          item
          borderRadius="10px"
          xs={9}
          sx={{ backgroundColor: "#6FD95D" }}
        >
          <Paper
            elevation={10}
            sx={{ backgroundColor: "#15A46E", height: "150px", textAlign:"start", alignContent: "center", pl: "60px" }}
          >
            <Typography variant="h2" color="white">HTW Berlin Campus Events</Typography>
          </Paper>
          <Grid container direction="row" spacing={3} padding={3} sx={{overflowY: "scroll", height: "77vh"}}>
            {map(events, (event) => {
              return <ListEvent event={event} />
            })}
          </Grid>
        </Grid>
      </Grid>
    </>
  )
}

export default Home
