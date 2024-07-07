# lib/tasks/generate_unique_ids.rake
namespace :user_particulars do
    desc "Generate and assign unique 6-digit IDs to user_particulars"
    task generate_unique_ids: :environment do
      UserParticular.find_each do |user_particular|
        user_particular.update(unique_id: rand(100000..999999))
      end
      puts "Unique IDs generated and assigned successfully."
    end
  end
  