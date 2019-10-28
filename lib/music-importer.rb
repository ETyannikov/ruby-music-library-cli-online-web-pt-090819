require 'pry'
class MusicImporter
  attr_accessor :path, :files
  
  def initialize(path)
    @path = path
  end
  
  def files
    @files ||= Dir.glob("#{@path}/*.mp3").collect{ |f| f.gsub("#{@path}/", "") }
  end
  
  def import
    files.each do |fname|
      Song.create_from_filename(fname)
    end
  end
end