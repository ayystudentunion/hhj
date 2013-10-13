FactoryGirl.define do
  factory :alliance do
    name "The appropriate candidates"
    call { FactoryGirl.create(:lukurinki) }
    creator { FactoryGirl.create(:eija) }
    end
  factory :alliance_membership do
    alliance
    position_application factory: :helsinki_uni_board_application
  end
end
