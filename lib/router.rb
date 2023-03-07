class Router
  def initialize(controller)
    @controller = controller
    @running = false
  end

  def run
    @running = true
    while @running
      display_options
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.add
    when 3 then @controller.remove
    when 4 then @controller.scrape_from_the_web
    when 9 then stop!
    else
      puts "Please press 1, 2, 3, 4 or 9"
    end
  end

  def stop!
    @running = false
  end

  def display_options
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all books"
    puts "2 - Add a new book"
    puts "3 - Remove a book"
    puts "4 - Scrape book from the web"
    puts "9 - Stop and exit the program"
  end
end
