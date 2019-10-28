require 'pry'
class MusicLibraryController
  attr_accessor :path, :songs
  
  def initialize(path = './db/mp3s')
    @path = path
    songs = MusicImporter.new(path)
    @songs = songs.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts"To list all of your songs, enter 'list songs'."
    puts"To list all of the artists in your library, enter 'list artists'."
    puts"To list all of the genres in your library, enter 'list genres'."
    puts"To list all of the songs by a particular artist, enter 'list artist'."
    puts"To list all of the songs of a particular genre, enter 'list genre'."
    puts"To play a song, enter 'play song'."
    puts"To quit, type 'exit'."
    puts"What would you like to do?"
    
    
    #input loop
    @input = gets
    until @input == "exit"
    case @input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
    end #case
    @input = gets
    end #until
  end #call
  
  def list_songs
    counter = 1
    Song.all.sort_by{|song|song.name}.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end #each
  end #list_songs
  
  def list_artists
    counter = 1
    Artist.all.sort_by{|artist|artist.name}.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1
    end #each
  end #list_artist
  
  def list_genres
    counter = 1
    Genre.all.sort_by{|genre|genre.name}.each do |genre|
      puts "#{counter}. #{genre.name}"
      counter += 1
    end #each
  end #list_genre
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    artist = Artist.find_by_name(input)
    #loop runs only if artist exists
    if artist != nil
      counter = 1
      artist.songs.sort_by{|song|song.name}.each do |song|
        puts "#{counter}. #{song.name} - #{song.genre.name}"
        counter += 1
    end #each loop
    end #if statment(no else)
  end # list_songs_by_artist
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    genre = Genre.find_by_name(input)
    #loop runs only if genre exists
    if genre != nil
      counter = 1
      genre.songs.sort_by{|song|song.name}.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name}"
        counter += 1
    end #each loop
    end #if statment(no else)
  end # list_songs_by_genre
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets
    counter = 1
      Song.all.sort_by{|song|song.name}.each do |song|
        if counter == input.to_i
          puts "Playing #{song.name} by #{song.artist.name}"
        end #if
        counter += 1
      end #each
  end #play_song
end #class