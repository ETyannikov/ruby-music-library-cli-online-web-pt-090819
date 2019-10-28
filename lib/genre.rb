require 'pry'
class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def add_song(song)
    if @songs.bsearch{|x| x == song} == nil
    self.songs << song
    song.genre = self
    end
  end
  
  def artists
    @songs.collect{|x|x.artist}.uniq
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    a = Genre.new(name)
    a.save
    a
  end
end