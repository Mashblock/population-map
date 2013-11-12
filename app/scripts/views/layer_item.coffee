define ["backbone", "marionette"], (Backbone)->
  class LayerItem extends Backbone.Marionette.ItemView
    tagName: "li"
    template: _.template("<a href='#'><%= name %></a>")

    events:
      "click a": "onSelect"

    modelEvents:
      "change": "render"

    onRender: ->
      $(@el).toggleClass "active", @model.get("selected")


    onSelect: ->
      @model.collection?.findWhere("selected": true)?.set("selected", false)
      @model.set("selected", true)
      false

