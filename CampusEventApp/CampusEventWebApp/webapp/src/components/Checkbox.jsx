import { Checkbox as MUICheckbox, FormControlLabel } from "@mui/material"

const Checkbox = ({ label, defaultChecked }) => (
  <FormControlLabel
    control={
      <MUICheckbox
        defaultChecked={defaultChecked}
        sx={{
          "&.Mui-checked": {
            color: "gray",
          },
        }}
      />
    }
    label={label}
  />
)

export default Checkbox
