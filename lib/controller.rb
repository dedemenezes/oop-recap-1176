require_relative './view'
require_relative './scrape'

class Controller
  def initialize(repository)
    @repository = repository
    @view = View.new
    @scraper = Scrape.new
  end

  def list
    @view.display @repository.all
  end

  def scrape_from_the_web
    query = @view.ask_for(:query_string)
    top_five = @scraper.top_five(query)
    @view.display_scraped_books(top_five)
    index = @view.ask_for(:index).to_i - 1
    attributes = top_five[index]
    attributes[:description] = @scraper.choosen_one(attributes[:url])
    book = Book.new(attributes[:title], attributes[:author], attributes[:rating], attributes[:description])
    @repository.create(book)
  end
end
