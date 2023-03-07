require 'csv'
require_relative './book'
class Repository
  def initialize(csv_file)
    @csv_file = csv_file
    @books = []
    load_csv
  end

  def all
    @books
  end

  def create(book)
    @books << book
    save_csv
  end
  private

  def load_csv
    CSV.foreach(@csv_file) do |row|
      @books << Book.new(row[0], row[1], row[2].to_f, row[3])
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @books.each do |book|
        csv << [book.title, book.author_name, book.rating, book.description]
      end
    end
  end
end
