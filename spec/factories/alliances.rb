FactoryGirl.define do
  factory :alliance do
    name "The appropriate candidates"
    call { FactoryGirl.create(:lukurinki) }
    creator { FactoryGirl.create(:eija) }
  end
end
