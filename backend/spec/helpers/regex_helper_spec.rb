require 'rails_helper'
RSpec.describe RegexHelper, type: :helper do
  describe "#normalized_email" do
    it "returns if an email is invalid" do
      result = helper.normalized_email("invalid-email.com")
      expect(result).to eq({ errors: { email: "Invalid email format!" } })
    end

    it "normalizes an email" do
      result = helper.normalized_email(" Email@Gmail.co m")
      expect(result).to eq("email@gmail.com")
    end

    it "passes on a valid email" do
      result = helper.normalized_email('aa@gmail.com')
      expect(result).to eq('aa@gmail.com')
    end
  end

  describe "#normalized_phone" do
    it "normalizes phone to standard form" do
      result = helper.normalized_phone("0791738418")
      expect(result).to eq('254791738418')
    end

    it "passes on a valid phone format" do
      result = helper.normalized_phone("254791738418")
      expect(result).to eq('254791738418')
    end

    it 'returns an error on invalid format' do
      result = helper.normalized_phone('25479173841')
      expect(result).to eq({ errors: { phone: "Invalid phone format!"}})
    end
  end
end
