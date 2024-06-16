import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Grid,
  IconButton,
  Paper,
  Typography,
} from "@mui/material"
import ExpandMoreIcon from "@mui/icons-material/ExpandMore"

const ListEvent = ({ event }) => {
  const { id, title, date, time, src, details } = event

  return (
    <Grid item xs={12}>
      {/*       <IconButton>
        <Paper
          elevation={10}
          sx={{
            backgroundColor: "#93a397",
            display: "flex",
            alignItems: "center",
            overflow: "hidden",
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
      </IconButton> */}
      <Accordion sx={{height: "150px", textAlign:"start", alignContent: "center", pl: "60px", borderRadius: "10px"}}>
        <AccordionSummary
          expandIcon={<ExpandMoreIcon />}
          id={id}
        >
          <Typography variant="h3">{title}</Typography>
        </AccordionSummary>
        <AccordionDetails>
          {details}
        </AccordionDetails>
      </Accordion>
    </Grid>
  )
}

export default ListEvent
