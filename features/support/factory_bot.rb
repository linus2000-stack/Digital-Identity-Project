# features/support/factory_bot.rb
require 'factory_bot'

World(FactoryBot::Syntax::Methods)

Before do
  FactoryBot.find_definitions
end
