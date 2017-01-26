class AltSeClimbingVideos::Video

  attr_accessor :name, :location, :upload_date, :upload_user, :description, :duration, :video_url

  @@all = []

  def initialize(video_hash)
    video_hash.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(video_array)
    video_array.each{|video_hash| AltSeClimbingVideos::Video.new(video_hash)}
  end

  def add_video_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
    self
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

end
