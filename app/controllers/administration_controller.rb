class AdministrationController < ApplicationController

  active_scaffold :release do |config|
    config.actions << :sortable
    columns[:publish].form_ui = :checkbox
    columns[:description].form_ui = :textarea
    config.columns = ['publish', 'name', 'description', 'image', 'tracks', 'date']
  end
end
