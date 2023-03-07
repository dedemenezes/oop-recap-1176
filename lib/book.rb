## book is defined by it's Title, author name, read and rating
class Book
  attr_reader :title, :author_name, :rating, :description

  def initialize(title, author_name, rating, description)
    @title = title
    @author_name = author_name
    @rating = rating
    @description = description
  end
end
