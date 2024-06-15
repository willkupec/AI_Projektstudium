import { Box, Grid, IconButton, Paper, Typography } from "@mui/material"
import { useNavigate } from "react-router-dom"

const ListEvent = ({ event }) => {
  const { id, title, date, time, src, details } = event
  const navigate = useNavigate()

  return (
    <Grid item xs={12}>
      <IconButton>
        <Paper
          elevation={10}
          onClick={() => navigate(`/event/${id}`)}
          sx={{
            backgroundColor: "#93a397",
            display: "flex",
            alignItems: "center",
            overflow: "hidden",
            transition: "transform .2s",
            "&:hover": {
              transform: "scale(0.95)",
            },
            width: "80vw",
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
      </IconButton>
    </Grid>
  )
}

export default ListEvent
