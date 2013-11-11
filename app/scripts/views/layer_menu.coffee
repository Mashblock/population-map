define ["marionette", "views/layer_item"], (Backbone, LayerItem)->
  class LayerMenu extends Backbone.Marionette.CollectionView
    itemView: LayerItem
    tagName: "ul"
    className: "nav navbar-nav"
