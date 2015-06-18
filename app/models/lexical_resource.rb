class LexicalResource < ActiveRecord::Base
  belongs_to :user
  has_many :lexicons

  validates_presence_of :user
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user
end
