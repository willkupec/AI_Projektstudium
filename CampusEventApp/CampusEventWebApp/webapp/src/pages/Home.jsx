import { map } from "lodash"
import Header from "../components/Header"
import ListEvent from "../components/ListEvent"
import { Grid } from "@mui/material"

const event1 = {
  title: "Jazz Party",
  date: "10.02.2024",
  time: "14:30",
  src: "https://i.imgur.com/c9c4U2q.png",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const event2 = {
  title: "Quiz Night",
  date: "12.02.2024",
  time: "19:00",
  src: "https://i.imgur.com/vQ6q3Xq.jpg",
  details:
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores totam est facilis quod impedit perferendis mollitia consequuntur nemo sit eligendi odio consectetur, qui expedita. Laboriosam quae voluptates esse eligendi expedita!",
}

const events = [event1, event2]

const Home = () => {
  return (
    <>
      <Header />
      <Grid
        container
        direction="column"
        rowSpacing={6}
        alignItems="center"
        justifyContent="center"
        //sx={{ minHeight: '100vh' }}
      >
        {map(events, (event) => {
          return <ListEvent event={event} />
        })}
      </Grid>
    </>
  )
}

export default Home
