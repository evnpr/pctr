class SiteController < ApplicationController

  require "httparty"
  require "nokogiri"

  def index
  end

  def home
    redirect_to "/" and return if !session[:user_id]
    @username = @current_user.name if @current_user
  end

  def profile
    if request.post?
        url = params[:url]
        comment = params[:comment]

        # get the url content
        response = HTTParty.get(url)
        doc = Nokogiri::HTML(response)
        @description = ""
        doc.xpath("//meta[@name='description']/@content").each do |attr|
            @description = attr.value
        end
        @title = doc.at_css("title").text
        render :text => "#{url} has title #{@title} and description #{@description} and the comment #{comment}" and return
        # /get the url content
        
    end
  end


end
