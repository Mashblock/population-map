define ["underscore", "marionette"], (_, Marionette)->
  class AreaDetails extends Marionette.ItemView
    template: _.template """
      <h4 class='text-center'><%= name %></h4>
      <div class='col-sm-4 pop_count'><%= pop_2001 %></div>
      <div class='col-sm-4 pop_count'><%= pop_2006 %></div>
      <div class='col-sm-4 pop_count'><%= pop_2013 %></div>
      <hr>
    """
