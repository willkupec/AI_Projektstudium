import { Grid, Paper, Typography } from "@mui/material"

const BahnList = ({name}) => {

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
        </Grid>
      </Paper>
      </Grid>
    )
}

export default BahnList