class AltSeClimbingVideos::CLI

  attr_accessor :location_input

  def call
    puts ""
    puts "Welcome to SE Climbing Videos. This is a way to find the newest videos uploaded on Youtube for your favorite Southeast Bouldering spot.".colorize(:light_cyan)
    puts ""
    start
  end

  def start
    location_search
    print_videos
    select_video
    select_new_video
    select_new_location
    goodbye
  end

  def location_search
    puts "Please enter the number of the bouldering area you would like to search:".colorize(:cyan)
    puts "You can enter:".colorize(:cyan)
    puts "1. Boone, NC"
    puts "2. Grayson Highlands, VA"
    puts "3. Horse Pens 40, AL"
    puts "4. Rocktown, GA"
    puts "5. Rumbling Bald, NC"
    puts "6. Stone Fort (LRC), TN"
    self.location_input = gets.strip

    if ["1", "2", "3", "4", "5", "6"].include?(@location_input)
      self.make_videos(AltSeClimbingVideos::SEARCH_LINKS[@location_input][:link], AltSeClimbingVideos::SEARCH_LINKS[@location_input][:location])
      self.add_attributes_to_videos

    elsif @location_input =="exit"
      goodbye
      exit
    else
      puts "Please enter a valid number. If you don't see your favorite location, send me an email so I can update the app!".colorize(:yellow)
      location_search
    end
  end

  def make_videos(link, location)
    video_array = AltSeClimbingVideos::Scraper.scrape_youtube_list(link, location)
    AltSeClimbingVideos::Video.create_from_collection(video_array)
  end

  def add_attributes_to_videos
    AltSeClimbingVideos::Video.all.each do |video|
        attributes = AltSeClimbingVideos::Scraper.scrape_youtube_video(video.video_url)
        video.add_video_attributes(attributes)
    end
  end

  def print_videos
    puts "---Latest 20 videos from #{AltSeClimbingVideos::SEARCH_LINKS[@location_input][:location]}---".colorize(:light_blue)
    puts ""
 AltSeClimbingVideos::Video.all.each.with_index(1) do |video, i|
      if video.location == AltSeClimbingVideos::SEARCH_LINKS[@location_input][:location]
      puts "#{i}. "+"#{video.name}".colorize(:light_blue)+" - #{video.upload_user} - #{video.upload_date}"
      end
    end
  end

  def select_video
    puts ""
    puts "Please select which video from the list you would like to learn more about:".colorize(:cyan)
    video_input = gets.strip

    if video_input.to_i > 0 and video_input.to_i < 21
      video = AltSeClimbingVideos::Video.find(video_input)
      display_video(video)
    elsif video_input == "exit"
      select_new_location
    else
      puts "Not sure which video you want to see more about. Type a number from the list or exit.".colorize(:yellow)
      select_video
    end
  end

  def display_video(video)
    puts ""
    puts "Video Name:".colorize(:light_blue)+"     #{video.name}"
    puts ""
    puts "Location:".colorize(:light_blue)+"       #{video.location}"
    puts "Upload Date:".colorize(:light_blue)+"    #{video.upload_date}"
    puts "Uploaded By:".colorize(:light_blue)+"    #{video.upload_user}"
    puts "Duration:".colorize(:light_blue)+"       #{video.duration}"
    puts "Video URL:".colorize(:light_blue)+"      #{video.video_url}"
    puts ""
    puts "Description:".colorize(:light_blue)
    puts "#{video.description}"
    puts ""
  end

  def select_new_video
    puts "Would you like to select another video from the list? (Y/N)".colorize(:cyan)
    input = gets.strip.downcase
    case input
      when "y"
        select_video
        select_new_video
      when "n"
        select_new_location
      when "exit"
        goodbye
        exit
      else
        puts "Please enter Y to search more videos or N to exit".colorize(:yellow)
        select_new_video
    end
  end

  def select_new_location
    puts "Would you like to search for videos in a different location? (Y/N)".colorize(:cyan)
    input = gets.strip.downcase
    case input
    when "y"
        AltSeClimbingVideos::Video.reset
        start
      when "n"
        goodbye
        exit
      when "exit"
        goodbye
        exit
      else
        puts "Please enter Y to search more videos or N to exit".colorize(:yellow)
        select_new_location
    end
  end

  def goodbye
    puts "Come back soon to see the newest climbing videos for your favorite area!".colorize(:light_cyan)
  end

end
