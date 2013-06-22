class SiteController < ApplicationController

  require "httparty"
  require "nokogiri"

  def index
  end

  def home
    current_user
    redirect_to "/" and return if !cookies[:user_id]
    @username = @current_user.name if @current_user
  end

  def share
    current_user
    if request.post?
        url = params[:url]
        @comment = params[:comment]

        @url = url
        @host = URI.parse(url).host


        # get the url content
        response = HTTParty.get(url)
        # /get the url content
        
        
        # nokogiri in action
        doc = Nokogiri::HTML(response)
        @description = ""
        doc.xpath("//meta[@name='description']/@content").each do |attr|
            @description = attr.value
        end
        @images = []
        doc.xpath("//img/@src").each do |attr|
            @images << attr.value if attr.value.include? ".jpg"
        end
        doc.xpath("//meta[@property='og:image']/@content").each do |attr|
            if attr.value.include? ".jpg"
                @images = []
                @images << attr.value 
            end
        end
        @image = @images.first
        @title = doc.at_css("title").text
        # /nokogiri in action

        @site = Site.create(:url => @url, :host => @host, :image_url => @image, :description => @description, :title => @title, :user_id => @current_user.id) if !Site.exists?(:user_id => @current_user.id, :url => @url)

    else
        redirect_to "/profile" and return
    end
  end


  def profile
    current_user
    if request.post?
        site_id = params[:id]
        issue = params[:issue]
        i = Issue.create(:name => issue)
        Issuesite.create(:site_id => site_id, :issue_id => i.id)
    end
    @sites = @current_user.sites.order("created_at DESC")
  end

end
