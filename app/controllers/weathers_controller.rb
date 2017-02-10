class WeathersController < ApplicationController

  def index
    city = params[:city] || "Chicago"
    state = params[:state] || "IL"
    @weather = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{ city }%2C%20#{ state }%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body

    @forecasts = @weather["query"]["results"]["channel"]["item"]["forecast"][0..4]
    @temp = @weather["query"]["results"]["channel"]["item"]["condition"]["temp"]
    @city = @weather["query"]["results"]["channel"]["location"]["city"]
    @state = @weather["query"]["results"]["channel"]["location"]["region"]
    @condition = @weather["query"]["results"]["channel"]["item"]["condition"]["text"]
    @date = @weather["query"]["results"]["channel"]["item"]["condition"]["date"]
    @image = @weather["query"]["results"]["channel"]["item"]["description"]
    @image_url = @image[/\w{4,4}\:\D\D\w\.\w{4,4}\.\w{3,3}\D\w\D\w\D\w{2,2}\D\w{2,2}\D\w{2,2}\D\w{2,2}\.\w{3,3}/]
  end
end
