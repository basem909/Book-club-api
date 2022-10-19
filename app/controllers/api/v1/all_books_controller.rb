class Api::V1::AllBooksController < ApplicationController
  before_action :tokenized
  
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
    @searched = find_book(params[:search_query].parameterize(separator: '_'))['results']
    @searched.each do |book|
      AllBook.create!(name: book['name'], stars: book['stars'], image: book['image'], link: book['url'], total_reviews: book['total_reviews'], best_seller: book['is_best_seller'], current_reading: false, user_id: current_user.id)
    end

    render json: { status: 'success', data: @searched }
  end

  private

  # app/controllers/travel_controller.rb
  private

  def search
    

    unless book
      flash[:alert] = 'Book not found'
      return render action: :index
    end

  end

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => 'amazon-kindle-scraper.p.rapidapi.com',
        'X-RapidAPI-Key' => 'b30047b871msh8af28f560a0b816p14a2fdjsnff9489a1dd3f'
      },
      query: {
        'api_key' => 'bc09e263d60d1bbdfc2455c657c5e9bd'
      }
    )

    return nil if response.status != 200

    JSON.parse(response.body)
  end

  def find_book(search)
    request_api(
      "https://amazon-kindle-scraper.p.rapidapi.com/search/#{search}"
    )
  end
end
