module ApplicationHelper

  def image_column
    image_tag url_for_file_column("entry", "image")
  end

end
