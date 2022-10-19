class Api::V1::AllBooksController < ApplicationController
  # SEARCH
  def index
    @searched = []
  end

  # DISPLAY SAVED
  def show
    @saved.each do |book|
      @searched.push(book.as_json.merge({ image: url_for(book.image) }))
    end

    render json: @searched
  end

  # CREATE CURRENT READING SELECTION
  def create
  end

  private

  # app/controllers/travel_controller.rb
  private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )

    return nil if response.status != 200

    JSON.parse(response.body)
  end

  def find_country(name)
    request_api(
      "https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}"
    )
  end

  def all_books_params
    params.permit(:name, :stars, :image, :link, :total_reviews, :best_seller, :current_reading)
  end
end
