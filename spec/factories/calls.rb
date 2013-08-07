# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    association :organ, :factory => :kirjakerho
    member_amount 2
    deputy_amount 1
    factory :lukurinki do
      title "Kirjakerhon lukurinki"
      _id "4f6b1edf91bc2b4403020202"
    end
    factory :uimarinki do
      title "Kirjakerhon uimarinki"
      _id "4f6b1edf91bc2b4403020203"
    end
  end
  factory :helsinki_uni_call, class: Call do
    association :organ, :factory => :helsinki_uni_student_council
    member_amount 2
    deputy_amount 1
    factory :call_for_student_council_board do
      title "Student council board members"
      _id "4f6b1edf91bc2b4403020209"
    end
  end
end
