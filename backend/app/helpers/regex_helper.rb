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
    # convert to string, remove spaces, dashes, parentheses, and leading +
    phone = phone.to_s.gsub(/[\s\-\(\)\+]/, '')

    # Accept any number that starts with a country code (1-3 digits) followed by at least 6 more digits
    if phone.match?(/\A\d{7,15}\z/)
      phone = phone
    else
      return { errors: { phone: "Invalid phone format!"}}
    end
    phone
  end

  def normalized_password(password, password_confirmation)

    # check for blank passwords
    if password.present? && password_confirmation.blank?
      return { errors: { password_confirmation: "Please enter password confirmation!"}}
    elsif password.blank? && password_confirmation.present?
      return { errors: { password: "Please enter password!"}}
    elsif password.blank? && password_confirmation.blank?
      return { errors: { password: "Please enter password!", password_confirmation: "Please enter password confirmation!"}}
    end

    # length validation
    if password.length < 8
      return { errors: { password: "Password should have at least 8 characters!"}}
    end

    # both letters and digits
    unless password.match?(/[A-Za-z]/) && password.match?(/\d/)
      return { errors: { password: "Password should have both letters and digits!"}}
    end

    # password match check
    if password != password_confirmation
      return { errors: { password_confirmation: "Password Mismatch!"}}
    end

    # return the valid passwords
    { password: password, password_confirmation: password_confirmation }
  end
end