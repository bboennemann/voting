json.array!(@web_parsers) do |web_parser|
  json.extract! web_parser, :id
  json.url web_parser_url(web_parser, format: :json)
end
