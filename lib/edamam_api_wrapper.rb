require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  TOKEN = ENV["app_key"]
  ID = ENV["app_id"]
  NUM = 50

  def self.list_recipes(word)
    url = BASE_URL + "?app_id=#{ID}" + "&app_key=#{TOKEN}" + "&q=#{word}" + "&to=#{NUM}"

    data = HTTParty.get(url)

    # data = URI.encode(url)

    recipe_list = []

    if data["hits"]
      data["hits"].each do |hit|
        recipe = Recipe.new(
          hit["recipe"]["label"],
          hit["recipe"]["uri"],
          hit["recipe"]["image"],
          hit["recipe"]["url"],
          hit["recipe"]["dietLabels"],
          hit["recipe"]["healthLabels"],
          hit["recipe"]["ingredientLines"],

        )
        recipe_list << recipe
      end
    end
    return recipe_list
  end

  # in the uri there is a uniq sequence of numbers that is id for the recipe
  def self.show_recipe(word)

    url = BASE_URL + "?app_id=#{ID}" + "&app_key=#{TOKEN}" + "&r=http:%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_#{word}"

    # url = URI.encode(url)

    data = HTTParty.get(url)

    recipe = Recipe.new(
      data[0]["label"],
      data[0]["uri"],
      data[0]["image"],
      data[0]["url"],
      data[0]["dietLabels"],
      data[0]["healthLabels"],
      data[0]["ingredientLines"]

    )

    # https://api.edamam.com/search?app_id=4725ac52&app_key=38d001a81b3e952ed69594b6172e18a0&r=http:%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_a91ad068e8956a7cda46bf41c57bb084

    return recipe


  end

end
