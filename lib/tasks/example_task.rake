namespace :example_task do
    desc "greeting_message_task"
    task greeting_message_task: :environment do
        puts "Hi this is my first task"
    end

    task printing_message: :environment do
        puts "printing first message"
    end
end
