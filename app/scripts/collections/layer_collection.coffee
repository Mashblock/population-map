define ["backbone", "models/layer"], (Backbone, Layer)->
  class LayerCollection extends Backbone.Collection
    model: Layer
