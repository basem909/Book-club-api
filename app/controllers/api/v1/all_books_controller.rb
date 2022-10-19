class Api::V1::AllBooksController < ApplicationController
  # SEARCHED
  def index
    @books = AllBook.all
    render json: {status:'sucess', data: @books}

  end

  # DISPLAY DETAILS
  def show
    @book = AllBook.find_by(id: params[:id])

    render json: {status: 'sucess', data: @book}
  end

  # NEW SEARCH QUERY
  def create
    @search_query = params[:search_query] 
    @books = find_book(@search_query.parameterize(separator: '_'))['results']
    @books.each do |book|
      @new_book = AllBook.create(name: book['name'], stars: book['stars'], image: book['image'], link: book['url'], total_reviews: book['total_reviews'], best_seller: book['best_seller'], current_reading: false, user_id: '1')
    end
    new_books = AllBook.all
    render json: {status:'sucess', data: new_books}
  end

  def update
  end
  private

  # app/controllers/travel_controller.rb
  private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => 'amazon-kindle-scraper.p.rapidapi.com',
        'X-RapidAPI-Key' => 'ab5dd93003msh198ddd4a3b3488ep147992jsn52900d232c05'
      },
      query: {
        'api_key' => 'bc09e263d60d1bbdfc2455c657c5e9bd'
      }
    )

    return nil if response.status != 200

    JSON.parse(response.body)
  end

  def find_book(search_query)
    request_api(
      "https://amazon-kindle-scraper.p.rapidapi.com/search/#{search_query}"
    )
  end

  def all_books_params
    params.permit(:name, :stars, :image, :link, :total_reviews, :best_seller, :current_reading, :search_query)
  end
end
