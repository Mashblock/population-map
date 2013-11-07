define ["backbone", "marionette", "views/layer_item"], (Backbone, Marionette, LayerItem)->
  class LayerMenu extends Marionette.CollectionView
    itemView: LayerItem
    tagName: "ul"
    className: "nav navbar-nav navbar-right"
