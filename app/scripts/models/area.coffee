define ["backbone", "underscore", "d3", "leaflet"], (Backbone, _, d3, L)->
  class Area extends Backbone.Model
    infowindow_template: _.template("<h1><%= name %></h1><a href='<%= path %>'>View Stats &raquo;</a>")

    setLayer: (layer)->
      @layer = layer
      @set("path", "/#{@layer.get('type')}/#{@get('slug')}")

    add_path: (path)->
      path.classed("selected", true) if @selected
      path.append("svg:title").text(@get("name")) if @get('name')?
      path.attr("data-area-id", @id)
      path.on "mouseover", =>
        @highlight()
      path.on "mouseout", =>
        @unhighlight()
      path.on "click", =>
        coords = [d3.event.layerX,d3.event.layerY]
        point = Maps.application.map.containerPointToLatLng(coords)
        @select(point)


    select: (point)->
      @selected = true
      Maps.application.current_selection?.unselect()
      Maps.application.current_selection = @
      d3.selectAll("path[data-area-id='#{@id}']").classed("selected", true)
      if point?
        @popup = new L.Popup({minWidth: 200}).setLatLng(point).setContent(@infowindow_template(@attributes))
        Maps.application.map.addLayer(@popup)

    unselect: ->
      @selected = false
      Maps.application.map.removeLayer(@popup) if @popup?
      d3.selectAll("path[data-area-id='#{@id}']").classed("selected", false)

    highlight: ->
      @highlighted = true
      d3.selectAll("path[data-area-id='#{@id}']").classed("highlight", true)

    unhighlight: ->
      @highlighted = false
      d3.selectAll("path[data-area-id='#{@id}']").classed("highlight", false)
