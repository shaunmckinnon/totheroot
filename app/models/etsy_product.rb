class EtsyProduct < ActiveRecord::Base

  acts_as_paranoid

  def self.search(term)
    where("title ILIKE ?", "%#{term}%")
  end

  def self.featured
    where.not(featured_rank: nil)
  end

  def featured?
    self.featured_rank.present? ? true : false
  end

  def self.generate_registration_code
    return "#{SecureRandom.hex(10)}-#{Time.now.to_i}"
  end

end
