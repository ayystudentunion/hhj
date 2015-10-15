FactoryGirl.define do
  factory :alliance do
    name "The appropriate candidates"
    call { TestSingletons.lukurinki }
    creator { TestSingletons.eija }
    end
  factory :alliance_membership do
    alliance
    position_application factory: :helsinki_uni_board_application
  end
end
