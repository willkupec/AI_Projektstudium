import Header from "../components/Header";
import { Grid, Paper, Typography } from "@mui/material";

const Mensa = () => {
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
            <iframe
              src="https://www.stw.berlin/mensen/einrichtungen/hochschule-für-technik-und-wirtschaft-berlin/mensa-htw-treskowallee.html"
              title="mensa"
              height="200"
              width="300"
            ></iframe>
          </Grid>
        </Grid>
      </Grid>
    </>
  );
};

export default Mensa;
