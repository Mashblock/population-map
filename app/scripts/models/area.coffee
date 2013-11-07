define ["backbone", "views/area_details"], (Backbone, AreaDetails)->
  class Area extends Backbone.Model

    showDetails:->
      App = require("app")
      App.areaInfo.show new AreaDetails(model: @)
