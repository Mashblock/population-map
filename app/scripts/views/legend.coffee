define ["underscore", "marionette"], (_, Backbone)->
  class Legend extends Backbone.Marionette.ItemView
    tagName: "ul"
    className: "legend"
    template: _.template """
      <% for(var i = 1; i <= 8; i++){ %>
      <li class='quan_<%= i %>'><%= Math.ceil(quantiles[i-1]) %> - <%= Math.floor(quantiles[i]) %></li>
      <% } %>
    """
