class LexicalResource < ActiveRecord::Base
  belongs_to :user
  has_many :lexicons
end
