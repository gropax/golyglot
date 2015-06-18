FactoryGirl.define do
  factory :cmn_lexical_entry, :class => 'Cmn::LexicalEntry' do
    lexicon nil
type 1
part_of_speech 1
simplified "MyString"
traditional "MyString"
pinyin "MyString"
  end

end
