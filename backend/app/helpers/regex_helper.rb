module RegexHelper
  def normalized_email(email)
    email = email.to_s.gsub(/\s+/, '').downcase
    
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    unless email.match?(email_regex)
      return { errors: { email: "Invalid email format!" } }
    end
    email
  end

  def normalized_phone(phone)
    phone = phone.to_s.gsub(/\s+/, '')
    if phone.match?(/\A01\d{8}\z/)
      phone = phone.sub(/\A01/, '2541')
    elsif phone.match?(/\A07\d{8}\z/)
      phone = phone.sub(/\A07/, '2547')
    elsif phone.match?(/\A(2541|2547)\d{8}\z/)
      phone = phone
    else
      return { errors: { phone: "Invalid phone format!"}}
    end
    phone
  end
end