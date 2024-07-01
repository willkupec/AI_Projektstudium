import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Grid,
  Typography,
} from "@mui/material"
import ExpandMoreIcon from "@mui/icons-material/ExpandMore"
import moment from "moment"

const ListEvent = ({ event }) => {
  const { _id, titel, tag, start, ende, foto, beschreibung } = event
  const tagMoment = moment(tag)
  const formattedDate = tagMoment.utc().format("DD.MM.YYYY")

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
        <AccordionSummary expandIcon={<ExpandMoreIcon />} id={_id}>
          <Grid container columnSpacing={8} sx={{ alignItems: "center" }}>
            <Grid item>
              <Typography variant="h4">{titel}</Typography>
            </Grid>
            <Grid item>
            </Grid>
              <Typography variant="h4">{formattedDate}</Typography>
            <Grid item>
              <Typography variant="h4">{`${start} - ${ende}`}</Typography>
            </Grid>
            <Grid item>
              <Box
                component="img"
                src={foto}
                alt={titel}
                sx={{
                  width: "200px",
                  height: "125px",
                }}
              ></Box>
            </Grid>
          </Grid>
        </AccordionSummary>
        <AccordionDetails>
          <Typography variant="body1">{beschreibung}</Typography>
        </AccordionDetails>
      </Accordion>
    </Grid>
  )
}

export default ListEvent
