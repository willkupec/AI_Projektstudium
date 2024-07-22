import { Checkbox as MUICheckbox, FormControlLabel } from "@mui/material"

const Checkbox = ({ label, checked, onChange }) => (
  <FormControlLabel
    control={
      <MUICheckbox
        checked={checked}
        onChange={onChange}
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
