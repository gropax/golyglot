class Cmn::Example < ActiveRecord::Base
  belongs_to :sense, class_name: 'Cmn::Sense', inverse_of: :examples
  belongs_to :sentence, class_name: 'Cmn::Sentence', inverse_of: :examples

  validates_presence_of :sense
  validates_presence_of :sentence
end
