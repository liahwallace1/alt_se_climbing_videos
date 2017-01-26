class AltSeClimbingVideos::Video

  attr_accessor :name, :location, :upload_date, :upload_user, :description, :duration, :video_url

  @@all = []

#  def self.new_from_youtube_list(video, location)
#    self.new(
#      video.search("a.yt-uix-tile-link").attr("title").text, video.search("div.yt-lockup-byline").text, video.search("span.accessible-description").text.gsub(" - Duration: ", "").gsub(".", ""), ("https://www.youtube.com" +  video.search("a.yt-uix-tile-link").attr("href").value), location
#    )
#  end

#  def initialize(name=nil, upload_user=nil, duration=nil, video_url=nil, location=nil)
#    @name = name
#    @upload_user = upload_user
#    @duration = duration
#    @video_url = video_url
#    @@all << self unless @@all.include?(self)
#  end

  def initialize(video_hash)
    video_hash.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end

  def self.find(input)
    self.all[input.to_i-1]
  end

  def self.create_from_collection(video_array)
    video_array.each{|video_hash| Video.new(video_hash)}
  end

  def add_video_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
    self
  end

#  def video_doc
#    @video_doc ||= Nokogiri::HTML(open(self.video_url))
#  end
#
#  def description
#    @video_doc.search("br").each {|node| node.replace("\n")}
#    @description ||= @video_doc.search("#eow-description").text
#  end
#
#  def upload_date
#    @upload_date ||= video_doc.search("#watch-uploader-info").text.gsub("Published on ", "").strip
#  end

end
