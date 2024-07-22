import { Grid, Paper, Typography } from "@mui/material"

const Bahn = ({ bahn }) => {
  const { art, nummer, richtung, abfahrtszeit, fahrradmitnahme, barrierefrei } =
    bahn
  const iconColor = art === "bus" ? "#a5027d" : "#d92120"
  return (
    <Grid item xs={12}>
      <Paper
        sx={{
          backgroundColor: "white",
          height: "120px",
          display: "flex",
          alignItems: "center",
          borderRadius: "10px",
        }}
      >
        <Grid container columnSpacing={0} sx={{ alignItems: "center" }}>
          <Grid item xs={3}>
            <Paper
              elevation={5}
              sx={{
                width: "100px",
                height: "100px",
                bgcolor: iconColor,
                ml: 2,
                alignItems: "center",
                justifyContent: "center",
                display: "flex",
              }}
            >
              <Typography variant="h3" color="white" fontWeight={900}>
                {nummer}
              </Typography>
            </Paper>
          </Grid>
          <Grid container item xs={8} rowSpacing="4px" sx={{ ml: 1 }}>
            <Grid item xs={12}>
              <Paper
                sx={{
                  width: "100%",
                  height: "30px",
                  backgroundColor: "white",
                  borderRadius: "20px",
                  textAlign: "center",
                }}
              >
                <Grid
                  container
                  xs={11}
                  sx={{ justifyContent: "space-between", ml: 2.5 }}
                >
                  <Grid item>
                    <Typography variant="h6" color="black">
                      Richtung
                    </Typography>
                  </Grid>
                  <Grid item>
                    <Typography variant="h6" color="black">
                      {richtung}
                    </Typography>
                  </Grid>
                </Grid>
              </Paper>
            </Grid>
            <Grid item xs={12}>
              <Paper
                sx={{
                  width: "100%",
                  height: "30px",
                  backgroundColor: "white",
                  borderRadius: "20px",
                  textAlign: "center",
                }}
              >
                <Grid
                  container
                  xs={11}
                  sx={{ justifyContent: "space-between", ml: 2.5 }}
                >
                  <Grid item>
                    <Typography variant="h6" color="black">
                      Abfahrtszeit
                    </Typography>
                  </Grid>
                  <Grid item>
                    <Typography variant="h6" color="black">
                      {abfahrtszeit}
                    </Typography>
                  </Grid>
                </Grid>
              </Paper>
            </Grid>
            <Grid container item xs={12}>
              <Grid item xs={6}>
                <Paper
                  sx={{
                    width: "100%",
                    height: "30px",
                    backgroundColor: "white",
                    borderRadius: "20px",
                    textAlign: "center",
                  }}
                >
                  <Grid
                    container
                    xs={11}
                    sx={{ justifyContent: "space-between", ml: 2.5, pr: 1 }}
                  >
                    <Grid item>
                      <Typography variant="h6" color="black">
                        Fahrradmitnahme
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography variant="h6" color="black">
                        {fahrradmitnahme ? "true" : "false"}
                      </Typography>
                    </Grid>
                  </Grid>
                </Paper>
              </Grid>
              <Grid item xs={6}>
                <Paper
                  sx={{
                    width: "100%",
                    height: "30px",
                    backgroundColor: "white",
                    borderRadius: "20px",
                    textAlign: "center",
                  }}
                >
                  <Grid
                    container
                    xs={11}
                    sx={{ justifyContent: "space-between", ml: 2.5, pr: 1 }}
                  >
                    <Grid item>
                      <Typography variant="h6" color="black">
                        Barrierefrei
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography variant="h6" color="black">
                        {barrierefrei ? "true" : "false"}
                      </Typography>
                    </Grid>
                  </Grid>
                </Paper>
              </Grid>
            </Grid>
          </Grid>
        </Grid>
      </Paper>
    </Grid>
  )
}

export default Bahn
