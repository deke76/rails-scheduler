import { application } from "./application"
import applicationController from "./application_controller"
import StimulusReflex from "stimulus_reflex"

import controllers from "./**/*_controller.js"

controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

StimulusReflex.initialize(application, { applicationController, isolate: true })

// consider removing these options in production
StimulusReflex.debug = true
// end remove
