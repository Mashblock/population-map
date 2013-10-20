`/*global define */`
define ['jquery', 'leaflet', 'lib/d3_geojson', 'leaflet_providers', 'bing'], ($, L, d3_geoJSON)->
  'use strict';



  quantiles =
    area_units:
      2013: [0, 576.0, 1482.0, 2508.0, 3622.2, 11700.0]


  $(document).ready ->
    map = L.map('map').setView([-36.85, 174.8], 10)
    map._initPathRoot()
    aerial_layer = new L.BingLayer("AioX_SQM_XDp5BfH1I-OCboEHatcZYoa1XizAOcmUORnnFQr1jAzTF8sQIAfZBzy",{type:"Aerial"})
    maptypes =
      "Map": new L.tileLayer.provider('Stamen.TonerLite')
      "Hybrid" : L.layerGroup [
          aerial_layer
          new L.tileLayer.provider('Stamen.TonerHybrid')
        ]
    map.addLayer(maptypes["Map"])
    map.addControl(new L.Control.Layers(maptypes,{}))
    geojson = new d3_geoJSON "http://tiles.mashblock.com/tiles.py/area_unit_vector/{z}/{x}/{y}.topojson",
      class:"poly"
      attribution: "Area Unit boundaries by <a href='http://stats.govt.nz' target='_blank'>Statistics New Zealand</a>."
    geojson.on "path_added", (e)-> console.log(e)
    map.addLayer(geojson)

    $("#year_toggles a").click ->
      $("#year_toggles li").removeClass("active")
      geojson.showYear $(this).data("year")
      $(this).parents("li").addClass("active")
      false
