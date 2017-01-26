class AltSeClimbingVideos::Scraper

def self.scrape_youtube_list(link, location)
    doc = Nokogiri::HTML(open(link))

    videos = []

    doc.css("div.yt-lockup-content").each do |video|
      videos << {
      :location => location,
      :name => video.search("a.yt-uix-tile-link").attr("title").text,
      :upload_user => video.search("div.yt-lockup-byline").first.text,
      :duration => video.search("span.accessible-description").text.gsub(" - Duration: ", "").gsub(".", ""),
      :video_url => "https://www.youtube.com" +  video.search("a.yt-uix-tile-link").attr("href").value}
    end
    videos
  end

  def self.scrape_youtube_video(video_url)
    video_doc = Nokogiri::HTML(open(video_url))
    video_doc.search("br").each {|node| node.replace("\n")}

    video_info = {
      :description => video_doc.search("#eow-description").text,
      :upload_date => video_doc.search("#watch-uploader-info").text.gsub("Published on ", "").strip
      }

    video_info
  end


end
