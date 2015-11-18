FactoryGirl.define do
  
  factory :haiku do
  end

  factory :line do
    haiku_id 1
    content "MyString"
  end

  factory :session do
    oauth_token "MyString"
  end

  factory :tag do
    haiku_id 1
    tag "MyString"
  end

  factory :user do
    email "user@example.com"
  end

end
