class User < ApplicationRecord
  validates_uniqueness_of :username

  helper_method :current_user # it will make it available everywhere

  def self.generate
    adjectives = %w[Ancient Timid Creative Dangerous Effective Flying Dilligent]
    nouns = %w[Highway Intern Jacket Fox Monkey Halberd]
    number = rand.to_s[2..4]
    username = "#{adjectives.sample}-#{nouns.sample}-#{number}"
    create(username: username)
  end
end
