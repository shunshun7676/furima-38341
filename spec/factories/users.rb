FactoryBot.define do
 factory :user do
   nickname { Faker::Name.last_name }
   email { Faker::Internet.free_email }
   password {'1a'+ Faker::Internet.password(min_length: 6) }
   password_confirmation { password }
   first_name { Gimei.last.kanji }
   family_name { Gimei.first.kanji }
   first_name_kana { Gimei.last.katakana }
   family_name_kana { Gimei.first.katakana }
   birthday { Faker::Date.birthday }
 end
end