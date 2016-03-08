# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_application do
    position :position_member
    factory :kirjakerho_application do
      user { TestSingletons.eija }
      call { TestSingletons.lukurinki }
    end
    factory :helsinki_uni_board_application do
      user { TestSingletons.helsinki_uni_student_union_employee }
      call { TestSingletons.call_for_student_council_board }
    end
    custom Hash[*%w(degree VTT)]
  end
end
