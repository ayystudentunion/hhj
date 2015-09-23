# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eligibility_rule_set do
    factory :accept_only_martti_to_lukurinki do
      organization { TestSingletons.sparta }
      after_create do |set|
        set.eligibility_rules = [FactoryGirl.create(:must_be_martti)]
        set.save!
      end
    end
  end
end
