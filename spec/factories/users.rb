FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    kana_last_name        { person.last.katakana }
    kana_first_name       { person.first.katakana }
    birthday              { Faker::Date.birthday }
  end
end
