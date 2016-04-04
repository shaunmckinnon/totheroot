class EtsyProduct < ActiveRecord::Base

  def self.search(term)
    where("title ILIKE ?", "%#{term}%")
  end

  def self.featured
    where.not(featured_rank: nil)
  end

  def featured?
    self.featured_rank.present? ? true : false
  end

end
