class Api::V1::AllBooksController < ApplicationController
 
  # DISPLAY SAVED
  def index
    render json: AllBook.find_by(user_id: current_user.id)
  end

  # BOOK DETAILS
  def show
    render json: AllBook.find(params[:id])
  end

  # CREATE SEARCH & SAVE
  def create
    @searched = fetch api
    @seached.each do |book|
      AllBook.create(book)
    end

    render json: @searched
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
end
