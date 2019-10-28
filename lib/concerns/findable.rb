module Concerns::Findable
  def find_by_name(name)
    self.all.detect{|a| a.name == name}
  end
  
  def find_or_create_by_name(name)
    a = find_by_name(name)
    if a == nil
      self.create(name)
    else
      a
    end
  end
end