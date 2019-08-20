class CLITimeout::Scraper

    TIMEOUT_URL = "https://www.timeout.com"

    def self.scrape_timeout
        
        html = open("https://www.timeout.com/newyork/restaurants/100-best-new-york-restaurants")

        doc = Nokogiri::HTML(html)

        top_restaurant = doc.css(".clearfix").collect {|names|
            names.css("h3").map(&:text)}
        restaurants_array = top_restaurant[0].map { |restaurant| 
            restaurant.gsub(/\n/," ").strip}

        locations_array = doc.css("span.bold")[1..100].collect {|neighborhood|
            neighborhood.text.gsub(/\n/," ").strip} 
        
        url_array = doc.css('h3.card-title a')[0..99].collect {|restaurant_link|
            restaurant_link.attribute('href').value}

        restaurants_array.map.with_index do |name, i|
            restaurant = CLITimeout::Restaurant.new(name)
            restaurant.location = locations_array[i]
            restaurant.url = url_array[i]
            restaurant.save
            restaurant
        end 
    end

    def self.scrape_more_info(restaurant)

        html = open(TIMEOUT_URL + restaurant.url)
        doc = Nokogiri::HTML(html)

        restaurant.type = doc.css("span.flag--sub_category").text.gsub(/, /, "")
        restaurant.description = doc.css("div.sm-pt1 p").text.gsub(/\s+/, " ")
    end
end



