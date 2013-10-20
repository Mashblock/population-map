define ["leaflet", "d3", "topojson"], (L, d3, topojson)->
  class d3_geoJSON extends L.TileLayer
    onAdd: (map)->
      super(map)
      @year = "pop_2013"
      @svg = d3.select(map._container).select("svg")
      @g = @svg.append("g")
        .attr("fill-rule","evenodd")

      @scale = d3.scale.quantile().domain([0, 576.0, 1482.0, 2508.0, 3622.2, 11700.0])
        .range(["quan_1","quan_2","quan_3","quan_4","quan_5"])

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
            .on("mouseover", (d)=> @svg.selectAll("path[data-code='#{d.properties.code}']").classed("hover",true))
            .on("mouseout", (d)=> @svg.selectAll("path[data-code='#{d.properties.code}']").classed("hover",false))
            .append("title")
              .text((d)=> "#{d.properties.name} - #{d.properties[@year]}")

    showYear:(year)->
      @year = "pop_#{year}"
      paths = @g.selectAll("path")
      paths.attr("class", (d)=> "#{@options.class} #{@scale(d.properties[@year])}")
      paths.select("title")
        .text((d)=> "#{d.properties.name} - #{d.properties[@year]}")


