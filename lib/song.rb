require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist, :genre, :fname
  
  @@all = []
  
  def initialize(name, artist = 0,genre = 0)
    @name = name
    self.artist = (artist) if artist != 0
    self.genre = (genre) if genre != 0
  end
  
  #"Thundercat - For Love I Come - dance.mp3"
  def self.new_from_filename(fname)
    @fname = fname.sub(/.mp3/,"")
    fname = fname.sub(/.mp3/,"").split(" - ")
    artist = Artist.find_or_create_by_name(fname[0])
    genre = Genre.find_or_create_by_name(fname[2])
    Song.new(fname[1],artist,genre)
  end
  
  def self.create_from_filename(fname)
    new_from_filename(fname).save
  end
  
  def self.find_by_name(name)
    self.all.detect{|a| a.name == name}
  end
  
  def self.find_or_create_by_name(name)
    a = find_by_name(name)
    if a == nil
      create(name)
    else
      a
    end
  end
  
  def save
    @@all << self
  end
  
  def artist=(artobj)
    @artist = artobj
    artobj.add_song(self)
  end
  
  def genre=(genobj)
    @genre = genobj
    genobj.add_song(self)
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    a = Song.new(name)
    a.save
    a
  end
end