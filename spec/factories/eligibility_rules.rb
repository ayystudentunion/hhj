# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eligibility_rule do
    factory :must_be_martti do
      edu_field 'A_GIVEN_NAME'
      valid_values ['Martti']
    end
  end
end
