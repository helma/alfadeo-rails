# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def image_column(record)
    image_tag(url_for_file_column(record, "image"), :height => "50") if record.image
  end

  def formatted_duration(length)
    min = (length.to_i/60000)
    sec = sprintf("%02d", length.to_f/1000 - 60*min.to_f)
    "#{min}'#{sec}\""
  end
end
