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
  
  describe "#normalized_password" do
    it "returns an error on password mismatch" do
      result = helper.normalized_password("user1234", "user12345")
      expect(result).to eq({ errors: { password_confirmation: "Password Mismatch!"}})
    end

    it "returns an error on <8 characters" do
      result = helper.normalized_password("user123", "user1234")
      expect(result).to eq({ errors: { password: "Password should have at least 8 characters!"}})
    end

    it "checks on both letters and digits" do
      result = helper.normalized_password("12341234", "12341234")
      expect(result).to eq({ errors: { password: "Password should have both letters and digits!"}})
    end

    it "checks for empty password and password confirmation fields" do
      result = helper.normalized_password("", "")
      expect(result).to eq({ errors: { password: "Please enter password!", password_confirmation: "Please enter password confirmation!"}})
    end
  end
end
