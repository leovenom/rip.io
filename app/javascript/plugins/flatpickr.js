import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

require("flatpickr/dist/themes/dark.css");

const flat = () => {
  flatpickr(".datepicker", {
      mode: "range"
  })
}

export { flat };
