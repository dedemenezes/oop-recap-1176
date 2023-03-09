require 'open-uri'
require 'nokogiri'

require_relative 'lib/book'

# RESPONSIBLE TO COMUNICATE WITH THE USER (puts/gets)
puts "Which book?"
book_name = gets.chomp
### VIEWWWWWW VIEW VIEW VIEW###


url = "https://www.goodreads.com/search?utf8=%E2%9C%93&q=#{book_name}&search_type=books"
# 1. Make an HTTP Request to the website and get the HTML => Open URI
html_file = URI.open(url).read
# p html_file
# 2. PArse this HTML into an Object that we can work => Nokogiri
html_doc = Nokogiri::HTML.parse(html_file)
# 3. Find the right information
html_doc.search('.bookTitle').first(5).each do |element|
  title = element.text.strip
  # scrape the url for this anchor tag
  book_path = element.attribute('href').value

  # To scrape the description we need to do a new HTTP Request
  # to the page for the specific book
  html_file = URI.open("https://www.goodreads.com#{book_path}").read
  html_doc = Nokogiri::HTML.parse(html_file)
  description = html_doc.search('.DetailsLayoutRightParagraph__widthConstrained')[0].text.strip
  rating = html_doc.search('.RatingStatistics__rating')[0].text.strip.to_f
  author_name = html_doc.search('.ContributorLink__name')[0].text.strip
  # Our goal at the end is to create a new Book
  p Book.new(title, author_name, rating, description)
  # Add it to the books array => to our collection
end
# 4. Do whatever you want with the scraped info

## CSS_SELECTORS
# . -> represnets a class
# -> represents an ID
# a -> represents the anchor HTML tag
