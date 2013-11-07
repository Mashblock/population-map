`/*global define */`
define ['jquery', 'leaflet', "marionette", 'collections/layer_collection', "views/layer_menu", 'leaflet_providers', 'bing'], ($, L, Backbone, LayerCollection, LayerMenu)->
  'use strict';

  nz_bounds = [[-47.54687159892238, 164.9267578125],[-34.34343606848293, 182.50488281249997]]

  App = new Backbone.Marionette.Application()

  App.layers = new LayerCollection [
    {slug: "area_unit_vector", name: "Area Unit", quantiles: [0, 210, 576, 1074.375, 1747.5, 2427, 3087, 3972, 11700]}
    {slug: "local_board_vector", name: "Local Board", quantiles: [894, 40529.25, 48877.5, 53972.25, 65322, 70720.5, 77163, 87575.25, 127125]}
    {slug: "territorial_authority_vector", name: "Territorial Authority", quantiles: [51,8454,12371.25,17925,28330.5,41541,48685.5,74103.75,1415550]}
    {slug: "regional_council_vector", name: "Regional Council", quantiles: [600, 40008.75, 43813.5, 90970.5, 142950, 195969.75, 262560, 465726, 1415550]}
  ]


  App.addRegions
    layerMenu: $("#layer_menu")
    areaInfo: $("#area-info")

  App.addInitializer ->
    @map = L.map('map').fitBounds(nz_bounds)
    @map._initPathRoot()
    maptypes =
      "Map": new L.tileLayer.provider('Stamen.TonerLite',{detectRetina: true})
      "Hybrid" : L.layerGroup [
          new L.BingLayer("AioX_SQM_XDp5BfH1I-OCboEHatcZYoa1XizAOcmUORnnFQr1jAzTF8sQIAfZBzy",{type:"Aerial"})
          new L.tileLayer.provider('Stamen.TonerHybrid',{detectRetina: true})
        ]
    @map.addLayer(maptypes["Map"])
    @map.addControl(new L.Control.Layers(maptypes,{}))


  App.addInitializer ->
    @layerMenu.show new LayerMenu(collection: @layers)
    @layers.findWhere(name: "Regional Council").set("selected", true)

  App.addInitializer ->
    $("#year_toggles a").click (e)=>
      $("#year_toggles li").removeClass("active")
      current_overlay = @layers.findWhere(selected: true)?.d3Layer()
      current_overlay.showYear $(e.target).data("year")
      $(e.target).parents("li").addClass("active")
      false

  return App
