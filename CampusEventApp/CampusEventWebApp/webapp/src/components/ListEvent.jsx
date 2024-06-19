import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Grid,
  Typography,
} from "@mui/material"
import ExpandMoreIcon from "@mui/icons-material/ExpandMore"

const ListEvent = ({ event }) => {
  const { id, title, date, time, src, details } = event

  return (
    <Grid item xs={12} sx={{}}>
      <Accordion
        disableGutters
        sx={{
          alignContent: "center",
          pl: "60px",
          borderRadius: "10px",
        }}
      >
        <AccordionSummary expandIcon={<ExpandMoreIcon />} id={id}>
          <Grid container columnSpacing={8} sx={{alignItems: "center"}}>
            <Grid item>
              <Typography variant="h3">{title}</Typography>
            </Grid>
            <Grid item>
              <Typography variant="h3">{date}</Typography>
            </Grid>
            <Grid item>
              <Typography variant="h3">{time}</Typography>
            </Grid>
            <Grid item>
              <Box
                component="img"
                src={src}
                alt={title}
                sx={{
                  width: "450px",
                  height: "125px",
                }}
              ></Box>
            </Grid>
          </Grid>
        </AccordionSummary>
        <AccordionDetails>
          <Typography variant="body1">{details}</Typography>
        </AccordionDetails>
      </Accordion>
    </Grid>
  )
}

export default ListEvent
