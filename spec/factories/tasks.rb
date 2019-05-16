FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    done { false }
    deadline { "2019-05-15 13:15:44" }
    user { nil }
  end
end
