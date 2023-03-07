require 'pry-byebug'
require 'open-uri'
require 'nokogiri'

class Scrape
  BASE_URL = "https://www.goodreads.com"

  def top_five(query_string)
    url = "#{BASE_URL}/search?utf8=%E2%9C%93&q=#{query_string}&search_type=books"
    doc = set_nokogiri_doc(url)

    attributes_for_books = []
    doc.search('.tableList tr').first(5).each do |e|
      attributes_for_book = {}
      e.search('.bookTitle').each do |el|
      attributes_for_book[:title] = el.text.strip
      attributes_for_book[:url] = el.attribute('href').value
      end
      attributes_for_book[:author] = e.search('.authorName').text.strip
      attributes_for_book[:rating] = e.search('.minirating').text.strip.match(/\d\.\d\d/)[0]
      attributes_for_books << attributes_for_book
    end
    attributes_for_books
  end

  def choosen_one(url)
    doc = set_nokogiri_doc("#{BASE_URL}#{url}")
    doc.search('.BookPageMetadataSection__description .Formatted').text.strip
  end

  def set_nokogiri_doc(url)
    html_file = URI.open(url).read
    Nokogiri::HTML.parse(html_file)
  end
end
