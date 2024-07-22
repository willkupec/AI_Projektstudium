import { Container, Grid, Paper } from "@mui/material"
import Header from "../components/Header"
import BahnList from "../components/BahnList"

const Home = () => {
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
                alt="tram"
                src="https://i.imgur.com/i6Untg3.jpg"
                borderRadius="10px"
                elevation={5}
                sx={{ width: "100%", height: "auto" }}
              ></Paper>
            </Grid>
          </Grid>
          <BahnList name="Nahverkehrsanbindung Treskoallee" />
          <BahnList name="Nahverkehrsanbindung Wilhelminenhof" />
        </Grid>
      </Container>
    </>
  )
}

export default Home
