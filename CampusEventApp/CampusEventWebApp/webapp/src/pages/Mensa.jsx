import Header from "../components/Header"
import { Container, Grid, Paper, Typography } from "@mui/material"

const Mensa = () => {
  return (
    <div>
      <Header />
      <Container
        maxWidth="false"
        disableGutters
        sx={{ height: "100%", position: "fixed" }}
      >
        <Grid container paddingY={2} paddingRight={2} sx={{ height: "93%", bgcolor: "white" }}>
          <Grid
            container
            item
            direction="column"
            rowGap={2}
            xs={2}
            sx={{ alignContent: "center", height: "100%" }}
          >
            <Paper
              item
              component="img"
              alt="htw_logo"
              src="https://i.imgur.com/K1Jc19l.png"
              elevation={20}
              sx={{ borderRadius: "15px", width: "90%", height: "true" }}
            ></Paper>

            <Paper
              item
              component="img"
              alt="campus_banner"
              src="https://i.imgur.com/omsunDN.jpg"
              elevation={20}
              sx={{ borderRadius: "15px", width: "90%", height: "fill" }}
            ></Paper>

          </Grid>

          <Grid
            container
            item
            direction="row"
            columnSpacing={2}
            xs={true}
            sx={true}
          >
            <Grid item xs={true}>
              <Paper
                elevation={20}
                sx={{ borderRadius: "15px", backgroundColor: "#6FD95D", height: "98%" }}
              >
                <Paper
                  elevation={10}
                  sx={{
                    borderRadius: "15px",
                    backgroundColor: "#15A46E",
                    height: "100px",
                    textAlign: "center",
                    alignContent: "center",
                  }}
                >
                  <Typography fontFamily="sans-serif" fontWeight="bold" variant="h3" color="white">
                    Mensaplan Treskowallee
                  </Typography>
                </Paper>
                <Grid
                  container
                  padding={2}
                  sx={{
                    height: "88%"
                  }}
                >
                  <iframe
                    id="inlineFrameExample"
                    title="Inline Frame Example"
                    width="100%"
                    height="true"
                    //src="https://www.stw.berlin/mensen/einrichtungen/hochschule-f%C3%BCr-technik-und-wirtschaft-berlin/mensa-htw-treskowallee.html"
                    src="https://www.youtube.com/embed/JrSFc_KeNzc"
                  //https://requestly.com/blog/bypass-iframe-busting-header/ 
                  >
                  </iframe>

                </Grid>
              </Paper>
            </Grid>

            <Grid item xs={true}>
              <Paper
                elevation={20}
                sx={{ borderRadius: "15px", backgroundColor: "#6FD95D", height: "98%" }}
              >
                <Paper
                  elevation={10}
                  sx={{
                    borderRadius: "15px",
                    backgroundColor: "#15A46E",
                    height: "100px",
                    textAlign: "center",
                    alignContent: "center",
                  }}
                >
                  <Typography fontFamily="sans-serif" fontWeight="bold" variant="h3" color="white">
                    Mensaplan Wilhelminenhof
                  </Typography>
                </Paper>
                <Grid
                  container
                  padding={2}
                  sx={{
                    height: "88%"
                  }}
                >
                  <iframe
                    id="inlineFrameExample"
                    title="Inline Frame Example"
                    width="100%"
                    height="true"
                    src="https://www.google.com/search?igu=1">
                  </iframe>
                </Grid>
              </Paper>
            </Grid>
          </Grid>
        </Grid>
      </Container>
    </div>
  )
}

export default Mensa
