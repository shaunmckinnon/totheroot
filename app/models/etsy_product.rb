class EtsyProduct < ActiveRecord::Base

  def self.search(term)
    where("title ILIKE ?", "%#{term}%")
  end

end
