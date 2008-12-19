# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def image_column(record)
    image_tag(url_for_file_column(record, "image"), :height => "50") if record.image
  end
end
