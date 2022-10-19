class Api::V1::AllBooksController < ApplicationController
  # SEARCH
  def index
    @search_query = params[:search_query] 
    @books = find_book(@search_query)
    render json: {status:'sucess', data: @books}

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
    @search_query = params[:search_query] 
    @books = find_book(@search_query.parameterize(separator: '_'))['results']
    @books.each do |book|
      @new_book = AllBook.create(name: book['name'], stars: book['stars'], image: book['image'], link: book['url'], total_reviews: book['total_reviews'], best_seller: book['best_seller'], current_reading: false, user_id: '1')
    end
    new_books = AllBook.all
    render json: {status:'sucess', data: new_books}
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
