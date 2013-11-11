define ["leaflet", "d3", "topojson"], (L, d3, topojson)->
  class d3_geoJSON extends L.TileLayer
    onAdd: (map)->
      super(map)
      @year = "pop_2013"
      @svg = d3.select(map._container).select("svg")
      @g = @svg.append("g")
        .attr("fill-rule","evenodd")

      range = ("quan_#{i}" for i in [1..8])

      @scale = d3.scale.quantile().domain(@options.quantiles)
        .range(range)

      @g.append("svg:clipPath")
        .attr("id","tilemask")
        .append("svg:rect")
        .attr("x",0)
        .attr("y",0)
        .attr("width",256)
        .attr("height",256)
      @on "tileunload", (d)=>
        d.tile.xhr?.abort()
        d.tile.nodes?.remove()
        d.tile.nodes = null
        d.tile.xhr = null

    onRemove: (map)->
      @g.remove()
      super

    _tile2long: (x)->
      z = @_map.getZoom()
      (x/Math.pow(2,z)*360-180)

    _tile2lat: (y)->
      z = @_map.getZoom()
      n = Math.PI-2 * Math.PI * y / Math.pow(2,z)
      180 / Math.PI * Math.atan( 0.5*( Math.exp(n)-Math.exp(-n) ))

    _loadTile: (tile, tilePoint)->
      @_adjustTilePoint(tilePoint)

      unless tile.nodes && tile.xhr
        offset_latlng = new L.LatLng(@_tile2lat(tilePoint.y), @_tile2long(tilePoint.x))
        tile.offset = @_map.latLngToLayerPoint(offset_latlng)
        tile.xhr = d3.json @getTileUrl(tilePoint), (d)=>
          tile.xhr = null;
          tile.nodes = @g.append("g")
            .attr("clip-path","url(#tilemask)")
            .attr("transform","translate(#{tile.offset.x},#{tile.offset.y})")

          tile.path = d3.geo.path().projection (d)=>
            point = @_map.latLngToLayerPoint(new L.LatLng(d[1],d[0]))
            [point.x - tile.offset.x, point.y - tile.offset.y]

          tile.nodes.selectAll("path").data(topojson.feature(d, d.objects.vectile).features)
            .enter().append("path")
            .attr("d", tile.path)
            .attr("class", (d)=> "#{@options.class} #{@scale(d.properties[@year])}")
            .attr("data-code",(d)-> d.properties.code)
            .classed("highlighted", (d)=> d.properties.code == @current_code)
            .on("mouseover", (d)=> @svg.selectAll("path[data-code='#{d.properties.code}']").classed("hover",true))
            .on("mouseout", (d)=> @svg.selectAll("path[data-code='#{d.properties.code}']").classed("hover",false))
            .on("click", (d)=> @highlight(d.properties))
            .append("title")
              .text((d)=> "#{d.properties.name} - #{d.properties[@year]}")

    highlight: (properties)->
      @g.selectAll("path").classed("highlighted",false)
      if properties.code != @current_code
        @current_code = properties.code
        @g.selectAll("path[data-code='#{@current_code}']").classed("highlighted", true)
        @fire("area_select", properties)
      else
        @current_code = null
        @fire("area_unselect", properties)



    showYear:(year)->
      @year = "pop_#{year}"
      paths = @g.selectAll("path")
      paths.attr("class", (d)=> "#{@options.class} #{@scale(d.properties[@year])}")
        .classed("highlighted", (d)=> d.properties.code == @current_code)
      paths.select("title")
        .text((d)=> "#{d.properties.name} - #{d.properties[@year]}")


