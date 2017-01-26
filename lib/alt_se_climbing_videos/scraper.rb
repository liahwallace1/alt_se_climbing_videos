class AltSeClimbingVideos::Scraper

  def get_page(link)
    Nokogiri::HTML(open(link))
  end

#  def make_videos(link, location)
#    self.get_page(link).css("div.yt-lockup-content").each do |video|
#      AltSeClimbingVideos::Video.new_from_youtube_list(video, location)
#    end
#  end

def self.scrape_youtube_list(link, location)

    videos = []

    get_page(link).css("div.yt-lockup-content").each do |video|
      videos << {
      :location = location,
      :name = video.search("a.yt-uix-tile-link").attr("title").text,
      :upload_user = doc.search("div.yt-lockup-byline").text,
      :duration = doc.search("span.accessible-description").text.gsub(" - Duration: ", "").gsub(".", ""),
      :video_url = "https://www.youtube.com" +  doc.search("a.yt-uix-tile-link").attr("href").value}
    end
    videos
  end

  def self.scrape_youtube_video(video_url)
    video_doc = Nokogiri::HTML(open(video_url))

    video_info = {
      video_doc.search("br").each {|node| node.replace("\n")}
      :description = video_doc.search("#eow-description").text,
      :upload_date = video_doc.search("#watch-uploader-info").text.gsub("Published on ", "").strip
      }

    video_info
  end


end
