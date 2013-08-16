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
  end
  factory :helsinki_uni_call, class: Call do
    factory :call_for_student_council_board do
      association :organ, :factory => :helsinki_uni_student_council
      member_amount 1
      deputy_amount 0
      title "Student council board members"
      _id "4f6b1edf91bc2b4403020209"
      workflow :workflow_administration_election
    end
    factory :call_for_uni_alumni_council do
      member_amount 1
      deputy_amount 1
      association :organ, :factory => :helsinki_uni_alumni_council
      title "Alumni council board members call"
      _id "4f6b1edf91bc2b4403020208"
      workflow :workflow_administration_election
    end
  end
end
