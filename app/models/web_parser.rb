class WebParser
	include Mongoid::Document
	require 'open-uri'

	field :website_url, type: String

	def get_images url
		uri = URI.parse(url)
		base_url = "#{uri.scheme}://#{uri.host}" 

		doc = Nokogiri::HTML(open(url))
		images = doc.xpath("//img")

		image_array = []

		images.each do |image|
			unless image['src'].nil?
				unless image['src'].include?('http://') or image['src'].include?('//www.')
					# TODO: implement separate solution for services like flickr, picasa.
					# if base url is added to flickr locations, this won'ty work properly anymore. 
					# maybe related to responsive design? Images are probably loaded from other than base url using media queries.
					# pretty clever these m**f**s :)
					# either locate media url or analyze flickr using API like prototype did.
					unless uri.host.include? 'flickr' or uri.host.include? 'picasa'
						image['src'] = base_url + image['src']
					end
				end
				image_array << image['src']
			end
		end
		return image_array.uniq
	end
end
