define ["backbone", "leaflet", 'lib/d3_geojson', 'views/area_details', 'views/legend'], (Backbone, L, d3_geoJSON, AreaDetails, Legend)->
  class Layer extends Backbone.Model
    defaults:
      "selected": false

    initialize: ->
      @on "change:selected", =>
        App = require("app")
        if @get("selected")
          App.map?.addLayer(@d3Layer())
          App.legend.show new Legend(model: @)
        else
          App.map?.removeLayer(@d3Layer())
          @hideAreaDetails()


      @d3Layer().on( "area_select", @showAreaDetails)
        .on( "area_unselect", @hideAreaDetails)

    hideAreaDetails: =>
      App = require("app")
      App.areaInfo.close()

    showAreaDetails: (properties)=>
      area = new Backbone.Model(properties)
      App = require("app")
      App.areaInfo.show new AreaDetails(model: area)

    d3Layer: ->
      @_d3_layer ||= new d3_geoJSON "http://tiles.mashblock.com/tiles.py/#{@get('slug')}/{z}/{x}/{y}.topojson",
        class:"poly"
        quantiles: @get("quantiles")
        attribution: "#{@get('name')} boundaries by <a href='http://stats.govt.nz' target='_blank'>Statistics New Zealand</a>."
