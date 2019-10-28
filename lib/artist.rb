require 'pry'

class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    if (song.artist == self || song.artist == nil) && @songs.find{|i| i == song} == nil
      @songs << song
      song.artist = self if song.artist != self
    end
  end
  
  def genres
    self.songs.map{|x|x.genre}.uniq
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    a = Artist.new(name)
    a.save
    a
  end
  
end