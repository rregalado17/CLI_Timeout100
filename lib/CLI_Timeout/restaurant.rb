require 'pry'

class CLITimeout::Restaurant

    attr_accessor :name, :type, :location, :description, :url
    
    @@all = []

    def initialize (name)
        @name = name
 
    end

    def self.all
        @@all
    end

    def save
        @@all << self 
    end
end
