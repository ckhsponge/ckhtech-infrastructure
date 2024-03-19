module HelpersMain
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def hattr(text)
    Rack::Utils.escape_path(text)
  end

  def host_base
    HOST_BASE
  end

  def private_image_tag(path, options = {})
    src = "https://#{DEFAULT_DOMAIN}/files/#{path}"
    tag :img, options.merge(src: src)
  end

  # def page_host(subdomain)
  #   "#{subdomain}.#{HOST_BASE}"
  # end
  #
  # def page_url(subdomain, path = nil)
  #   base_url = ["#{PROTOCOL}://#{subdomain}.#{HOST_BASE}",PORT_OVERRIDE].compact.join(":")
  #   [base_url,path].compact.join("/")
  # end
  #
  # def home_url
  #   page_url(DEFAULT_SUBDOMAIN)
  # end
  #
  # def default_url
  #   page_url(DEFAULT_SUBDOMAIN)
  # end
  #
  # def resizer_image_url(uuid, size = 'medium')
  #   path = "#{ENV['RESIZER_DESTINATION_DIRECTORY']}/#{uuid}/#{size}.#{IMAGE_FORMAT}"
  #   "https://#{RESIZER_DOMAIN}/#{path}"
  # end
  #
  # def resizer_image_tag(uuid, size = 'medium', options = {})
  #   src = resizer_image_url(uuid, size)
  #   tag :img, options.merge(src: src)
  # end
  #
  # def titleize(word)
  #   (word || "").gsub('-',' ').gsub(/\b('?[a-z])/) { $1.capitalize }
  # end

end
