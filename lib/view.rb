class View

  def ask_for(something)
    puts "#{something.capitalize}?"
    gets.chomp
  end

  def display(books)
    books.each_with_index do |book, index|
      puts "#{index + 1} - #{book.title}\nAuthor: #{book.author_name}\nRating: #{book.rating}"
    end
  end

  def display_scraped_books(array_of_hashes)
    array_of_hashes.each_with_index do |hash, index|
      puts "#{index + 1} - #{hash[:title]}"
    end
  end
end
