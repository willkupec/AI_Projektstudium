import { Box, Grid, Paper, Typography } from "@mui/material"

const Bahn = () => {
  return (
    <Grid item xs={12}>
      <Paper
        borderRadius="10px"
        sx={{ backgroundColor: "#fff", height: "100%" }}
      >
        <Grid container columnSpacing={8} sx={{ alignItems: "center" }}>
          <Grid item xs={6}>
            <Box sx={{ width: "50px", height: "50px", bgcolor: "black" }}></Box>
          </Grid>
        </Grid>
      </Paper> 
    </Grid>
  )
}

export default Bahn
