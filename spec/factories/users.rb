FactoryGirl.define do
  factory :bob, class: User do
    name "bob-jackson"
    email "bob@jackson.com"
    password "bobbybou"
    password_confirmation { password }
  end

  factory :john, class: User do
    name "JohnnyD"
    email "john@doe.com"
    password "gojohnnygo"
    password_confirmation { password }
  end

end
