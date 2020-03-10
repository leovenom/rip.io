import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

require("flatpickr/dist/themes/dark.css");

const flat = () => {
  flatpickr(".datepicker", {
      mode: "range"
  })
  flatpickr(".deathpicker", {
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
  })
}

export { flat };
