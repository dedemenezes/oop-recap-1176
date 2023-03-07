require_relative './repository.rb'
require_relative './controller.rb'
require_relative './router.rb'

csv_file = File.join(__dir__, 'books.csv')
repo = Repository.new(csv_file)
controller = Controller.new(repo)

router = Router.new(controller)
router.run
