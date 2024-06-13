import { Box, Grid, Paper, Typography } from "@mui/material"

const ListEvent = ({ event }) => {
  const { title, date, time, src, details } = event

  return (
    <Grid item xs={12}>
      <Paper
        elevation={10}
        sx={{
          backgroundColor: "#93a397",
          display: "flex",
          alignItems: "center",
          overflow: "hidden",
          transition: "transform .2s",
          "&:hover": {
            transform: "scale(0.95)",
          },
          width: "80vw"
        }}
      >
        <Box
          component="img"
          src={src}
          alt={title}
          width={"520px"}
          sx={{
            width: "400px",
            height: "400px",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            overflow: "hidden",
          }}
        ></Box>
        <Typography variant="h6" align="center" color="#363333">
          {title}
        </Typography>
        <Typography variant="h6" align="center" color="#363333">
          {date}
        </Typography>
        <Typography variant="h6" align="center" color="#363333">
          {time}
        </Typography>
      </Paper>
    </Grid>
  )
}

export default ListEvent
