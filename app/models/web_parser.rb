class WebParser
	require 'open-uri'

	def get_images url
		doc = Nokogiri::HTML(open(url))
		images = doc.xpath("//img")
	end
end
