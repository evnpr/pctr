class SiteController < ApplicationController

  require "httparty"
  require "nokogiri"

  def index
    redirect_to home_path and return if cookies[:user_id]
    @issues = Issue.all
  end

  def home
    current_user
    redirect_to "/" and return if !cookies[:user_id]
    @username = @current_user.name if @current_user
    @issues = Issue.all
  end

  def share
    current_user
    if request.post?
        url = params[:url]
        @comment = params[:comment]

        @url = url
        @host = URI.parse(url).host

        begin

        # get the url content
        response = HTTParty.get(url)
        # /get the url content
        
        
        # nokogiri in action
        doc = Nokogiri::HTML(response)

        #----- description ----
        @description = ""
        doc.xpath("//meta[@name='description']/@content").each do |attr|
            @description = attr.value
        end
        if @description == ""
            doc.xpath("//p").each do |attr|
                @description = attr.text
                break
            end
        end
        if @description == ""
            doc.xpath("//meta[@name='description']/@content").each do |attr|
                @description = ""
                @description = attr.value
            end
        end
        if @description == ""
            doc.xpath("//meta[@property='og:description']/@content").each do |attr|
                @description = ""
                @description = attr.value
            end
        end
        if @description == ""
            redirect_to request.referer, :notice => "Link yang anda submit tidak bisa kami save karena bukan merupakan halaman berita yang memenuhi standard" and return
        end
        #----- /description --------
        #----- images --------
        @images = []
        doc.xpath("//img/@src").each do |attr|
            @images << attr.value if attr.value.include? ".jp" or  attr.value.include? ".png"
        end
        doc.xpath("//meta[@property='og:image']/@content").each do |attr|
            if attr.value.include? ".jp" or  attr.value.include? ".png"
                @images = []
                @images << attr.value 
            end
        end
        @image = @images.first
        #----- /images --------
        #
        #----- title --------
        @title = doc.at_css("title").text
        #----- /title --------
        # /nokogiri in action
        #
        
        # rescue
        rescue
           redirect_to request.referer, :notice => "link yang anda submit tidak valid" and return
        end
        # end rescue
        
        if !Site.exists?(:user_id => @current_user.id, :url => @url)
            @site = Site.create(:url => @url, :host => @host, :image_url => @image, :description => @description, :title => @title, :user_id => @current_user.id) 
            Comment.create(:site_id => @site.id, :message => @comment, :user_id => @current_user.id)
        else
            redirect_to request.referer and return 
        end

    else
        redirect_to "/profile" and return
    end
  end


  def profile
    current_user
    if request.post?
        site_id = params[:id]
        issue = params[:issue]
        i = Issue.create(:name => issue, :user_id => @current_user.id)
        Issuesite.create(:site_id => site_id, :issue_id => i.id)
        if Issue.exists?(:name => issue)
            Issue.where(:name => issue).each do |ii|
                Issuesite.create(:site_id => site_id, :issue_id => ii.id)
            end
        end
    end
    if request.GET["user"]
        @current_user = User.find(request.GET["user"])
    end
    @sites = @current_user.sites.order("created_at DESC")
    if request.GET['issue']
        issue_id = request.GET['issue']
        if Issue.exists?(:id => issue_id)
            @sites_issue = Issue.find(issue_id).sites
            @sites = @sites_issue & @sites
        else
            @sites = []
        end
    end
  end

  def issue
    current_user
    if request.post?
    else
        @issue = Issue.find(params[:id])
        @issue_same = Issue.where(:name => @issue.name).order("id asc")
        @issue = @issue_same.first
        @komentars = @issue.komentars.order("created_at desc")
        @users = @issue.users.uniq
    end
  end


end
