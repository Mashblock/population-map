`/*global define */`
define ['jquery', 'leaflet', 'collections/layer_collection', 'leaflet_providers', 'bing'], ($, L, LayerCollection)->
  'use strict';

  nz_bounds = [[-47.54687159892238, 164.9267578125],[-34.34343606848293, 182.50488281249997]]

  layers = new LayerCollection [
    {slug: "area_unit_vector", name: "Area Unit", quantiles: [0,429,1209,2310,3402,11700]}
    {slug: "local_board_vector", name: "Local Board", quantiles: [894.0,  45552.0,  55351.8,  69743.4,  80929.2, 127125.0]}
    {slug: "territorial_authority_vector", name: "Territorial Authority", quantiles: [51.0, 9499.2, 21075.0, 38331.0, 55509.0, 1415550.0]}
    {slug: "regional_council_vector", name: "Regional Council", quantiles: [600,42888,93339,181542,380823,1415550]}
  ]

  $(document).ready ->
    window.map = L.map('map').fitBounds(nz_bounds)
    map._initPathRoot()
    aerial_layer = new L.BingLayer("AioX_SQM_XDp5BfH1I-OCboEHatcZYoa1XizAOcmUORnnFQr1jAzTF8sQIAfZBzy",{type:"Aerial"})
    maptypes =
      "Map": new L.tileLayer.provider('Stamen.TonerLite',{detectRetina: true})
      "Hybrid" : L.layerGroup [
          aerial_layer
          new L.tileLayer.provider('Stamen.TonerHybrid',{detectRetina: true})
        ]
    map.addLayer(maptypes["Map"])
    map.addControl(new L.Control.Layers(maptypes,{}))

    current_layer = layers.findWhere(name: "Territorial Authority").d3Layer()
    map.addLayer(current_layer)

    $("#year_toggles a").click ->
      $("#year_toggles li").removeClass("active")
      current_layer.showYear $(this).data("year")
      $(this).parents("li").addClass("active")
      false
