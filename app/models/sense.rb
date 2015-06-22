class Sense < ActiveRecord::Base
  validates_presence_of :lexical_entry
  validates_presence_of :description
end
