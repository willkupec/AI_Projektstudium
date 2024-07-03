import Header from "../components/Header"
import { Grid, Paper } from "@mui/material"

const getSrc = async () => {
  const res = await fetch(
    "https://www.stw.berlin/mensen/einrichtungen/hochschule-für-technik-und-wirtschaft-berlin/mensa-htw-treskowallee.html",
    {
      method: "GET",
      headers: {},
    }
  )
  const blob = await res.blob()
  const urlObject = URL.createObjectURL(blob)

  return urlObject
}

const Mensa = () => {
  const src = getSrc()

  return (
    <>
      <Header />
      <Grid container padding={2} paddingBottom={0}>
        <Grid container item direction="column" rowSpacing={2} xs={3}>
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
          <Grid item>
            <iframe src={src} title="mensa" height="200" width="300"></iframe>
          </Grid>
        </Grid>
      </Grid>
    </>
  )
}

export default Mensa
