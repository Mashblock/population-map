define ["backbone", "leaflet", 'lib/d3_geojson'], (Backbone, L, d3_geoJSON)->
  class Layer extends Backbone.Model
    d3Layer: ->
      new d3_geoJSON "http://tiles.mashblock.com/tiles.py/#{@get('slug')}/{z}/{x}/{y}.topojson",
        class:"poly"
        quantiles: @get("quantiles")
        attribution: "#{@get('name')} boundaries by <a href='http://stats.govt.nz' target='_blank'>Statistics New Zealand</a>."
