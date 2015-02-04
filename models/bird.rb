class Bird < ActiveRecord::Base

  def self.bird_of_the_day
    Bird.take(5).sample
  end

end