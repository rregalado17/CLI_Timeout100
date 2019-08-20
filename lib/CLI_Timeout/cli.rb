class CLITimeout::CLI 

    def call
        scraped_data
        list_restaurants
        menu
        adios
    end


    def scraped_data
        puts "Welcome! Looking to try some new authentic cuisines or just trying to impress your Tinder date?"
        CLITimeout::Scraper.scrape_timeout
    end


    def list_restaurants
        puts "Here's a list of best restaurants in New York City from our friends over at Timeout New York:"
        @restaurants = CLITimeout::Restaurant
        @restaurants.all.each.with_index(1) do |restaurant, i|
            puts "#{i}. #{restaurant.name} - #{restaurant.location}"
        end
    end

    def menu
        input = nil
            while input != "exit" 
                puts "Please select the number of the restaurant you would like to see or type exit to exit the program:"
                input = gets.strip.downcase

                if input.to_i < 101 && input.to_i > 0
                    restaurant = CLITimeout::Restaurant.all[input.to_i - 1]
                    CLITimeout::Scraper.scrape_more_info(restaurant)
                    puts "#{restaurant.name} - #{restaurant.type} - #{restaurant.description}"
                elsif input == "list" 
                    list_restaurants
                else                    
                    puts "Please enter the corresponding number of the restaurant you would like to see. To see the list of restaurants again, please type enter 'list'"
                end
            end

        end

    def adios
        puts "We hope you enjoy your meal!"
    end

end

