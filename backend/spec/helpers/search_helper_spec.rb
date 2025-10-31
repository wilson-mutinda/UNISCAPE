require 'rails_helper'
RSpec.describe SearchHelper, type: :helper do
  describe "#unique_course_name" do
    let(:courses) do
      [
        double(course_name: "Backend Development"),
        double(course_name: "Data Analytics"),
        double(course_name: "Software Engineering"),
    ].sort_by(&:course_name)
    end

    it "returns an error if the course already exists" do
      result = helper.unique_course_name(courses, "Data Analytics")
      expect(result).to eq({ errors: { course_name: "Course name already exists!"}})
    end

    it "passes if course name is valid" do
      result = helper.unique_course_name(courses, "UI/UX Design")
      expect(result).to eq("UI/UX Design")
    end
  end

  describe "#course_id_search" do
    let(:courses) do
      [
        double(id: 1, course_name: "Backend Development"),
        double(id: 4, course_name: "UI/UX Design"),
        double(id: 3, course_name: "Frontend Development"),
        double(id: 2, course_name: "Software Engineering")
    ].sort_by(&:id)

    end
    it "returns course object info" do
      result = helper.course_id_search(courses, 4)
      expect(result.id).to eq(4)
      expect(result.course_name).to eq("UI/UX Design")
    end

    it "returns an error if course is not found" do
      result = helper.course_id_search(courses, 5)
      expect(result).to eq({ errors: { course_id: "Course not found!"}})
    end
  end

  describe "#course_name_search" do
    let(:courses) do
      [
        double(id: 1, course_name: 'Backend Development'),
        double(id: 2, course_name: 'UI/UX Design'),
        double(id: 3, course_name: 'Software Engineering')
    ].sort_by(&:course_name)
    end

    it "returns an error if already a course exists" do
      result = helper.course_name_search(courses, 'Software Engineering', 2)
      expect(result).to eq({ errors: { course_name: "Course already exists!"}})
    end

    it "returns the course if the name matches the same id" do
      result = helper.course_name_search(courses, 'Software Engineering', 3)
      expect(result.course_name).to eq('Software Engineering')
    end
  end

  describe "#user_email_search" do
    let(:users) do
      [
        double(email: 'aa@gmail.com'),
        double(email: 'dd@gmail.com'),
        double(email: 'ab@gmail.com'),
        double(email: 'bb@gmail.com'),
    ].sort_by(&:email)
    end

    it "returns an error if email alreay exists" do
      result = helper.user_email_search(users, 'aa@gmail.com')
      expect(result).to eq({ errors: { email: "Email has been taken!"}})
    end

    it "passes if email does not exist" do
      result = helper.user_email_search(users, 'ac@gmail.com')
      expect(result).to eq('ac@gmail.com')
    end
  end

  describe "#user_phone_search" do
    let(:users) do
      [
        double(phone: '254711111111'),
        double(phone: '254712121212'),
        double(phone: '254789898989')
    ].sort_by(&:phone)
    end

    it "returns an error if phone already exists" do
      result = helper.user_phone_search(users, '254712121212')
      expect(result).to eq({ errors: { phone: 'Phone has been taken!'}})
    end

    it "passes if phone does not exist" do
      result = helper.user_phone_search(users, '254777777777')
      expect(result).to eq('254777777777')
    end
  end

  describe "#user_slug_search" do
    let(:users) do
      [
        double(id: 1, email: "aa@gmail.com", slug: 'aa'),
        double(id: 2, email: 'cc@gmail.com', slug: 'cc'),
        double(id: 3, email: 'dd@gmail.com', slug: 'dd')
      ]
    end

    it "returns user details by searching with id" do
      result = helper.user_slug_search(users, 3)
      expect(result).to eq(users[2])
    end

    it "returns user object by searching with email" do
      result = helper.user_slug_search(users, 'cc@gmail.com')
      expect(result).to eq(users[1])
    end
    
    it "returns user object by searching with slug" do
      result = helper.user_slug_search(users, 'aa')
      expect(result).to eq(users[0])
    end

    it "returns an error hash when user not found" do
      result = helper.user_slug_search(users, 'Bb')
      expect(result).to eq({ errors: { user: "User not found for '#{'bb'}'"}})
    end

    it "returns an error hash if ID was not found" do
      result = helper.user_slug_search(users, 5)
      expect(result).to eq({ errors: { user: "User with ID 5 not found!"}})
    end
  end

  describe "#country_name_search" do
    let(:countrys) do
      [
        double(id: 1, name: 'Kenya'),
        double(id: 2, name: 'Lagos'),
        double(id: 3, name: 'China')
      ]
    end
    it "returns an error if name exists!" do
      result = helper.country_name_search(countrys, 'kenya')
      expect(result).to eq({ errors: { name: 'Name already exists!'}})
    end

    it "passes when a name does not exist" do
      result = helper.country_name_search(countrys, 'Uganda')
      expect(result).to eq('uganda')
    end
  end

  describe "#course_slug_search" do
    let(:countrys) do
      [
        double(id: 1, name: 'Kenya', slug: 'kenya'),
        double(id: 2, name: 'Lagos', slug: 'lagos'),
        double(id: 3, name: 'China', slug: 'china')
      ]
    end

    it "returns an  error if ID is not found" do
      result = helper.country_slug_search(countrys, 5)
      expect(result).to eq({ errors: { name: 'Country with ID 5 not found!'}})
    end

    it "returns country object if id passes" do
      result = helper.country_slug_search(countrys, 2)
      expect(result).to eq(countrys[1])
    end

    it "returns country object if name passes" do
      result = helper.country_slug_search(countrys, 'Lagos')
      expect(result).to eq(countrys[1])
    end

    it 'returns country object if slug passes' do
      result = helper.country_slug_search(countrys, 'lagos')
      expect(result).to eq(countrys[1])
    end
  end

  describe "#login_email_search" do
    let(:users) do
      [
        double(id: 1, email: "aa@gmail.com"),
        double(id: 2, email: "ba@gmail.com"),
      ]
    end
    it "returns an error if email is not found" do
      result = helper.login_email_search(users, 'ab@gmail.com')
      expect(result).to eq({ errors: { email: "Email 'ab@gmail.com' not found!"}})
    end

    it "returns email if found" do
      result = helper.login_email_search(users, 'aa@gmail.com')
      expect(result).to eq('aa@gmail.com')
    end
  end

  describe "#student_email_search" do
    let(:students) do
      [
        double(id: 1, email: "aa@gmail.com"),
        double(id: 2, email: "dd@gmail.com")
      ]
    end
    it "returns an error if email already exists" do
      result = helper.student_email_search(students, 'aa@gmail.com')
      expect(result).to eq({ errors: { email: "Email already exists!"}})
    end

    it "returns an email of it does not exist" do
      result = helper.student_email_search(students, 'ab@gmail.com')
      expect(result).to eq('ab@gmail.com')
    end
  end

  describe "#student_phone_search" do
    let(:students) do
      [
        double(id: 1, phone: '254791738418'),
        double(id: 2, phone: '254748929891')
      ]
    end

    it "returns an error if phone aleady exists" do
      result = helper.student_phone_search(students, '254791738418')
      expect(result).to eq({ errors: { phone: "Phone already exists!"}})
    end

    it "returns a phone which does not exist!" do
      result = helper.student_phone_search(students, '254790738418')
      expect(result).to eq('254790738418')
    end
  end

  describe "#country_id_search" do
    let(:countrys) do
      [
        double(id: 1, country_id: 1),
        double(id: 2, country_id: 2),
        double(id: 3, country_id: 3)
      ]
    end

    it "returns an error id id is not found" do
      result = helper.country_id_search(countrys, 4)
      expect(result).to eq({ errors: { country_id: "Country not found!"}})
    end

    it "returns country id if its found" do
      result = helper.country_id_search(countrys, 3)
      expect(result).to eq(3)
    end
  end

  describe "#single_application_search" do
    let(:applications) do
      [
        double(id: 1, first_name: "aa", last_name: "bb", email: "aa@gmail.com", phone: "254791738418", course_id: 4, country_id: 6, slug: 'aa-bb'),
        double(id: 2, first_name: "cc", last_name: "dd", email: "cc@gmail.com", phone: "254748929891", course_id: 5, country_id: 7, slug: 'cc-dd')
      ]
    end

    it "returns an error if application not found!" do
      result = helper.single_application_search(applications, 3)
      expect(result).to eq({ errors: { application: "Application of ID 3 not found!"}})
    end

    it "returns an error if application first_name was not found" do
      result = helper.single_application_search(applications, 'zz')
      expect(result).to eq({ errors: { application: "Application not found for zz"}})
    end
  end

  describe "#application_email_search" do
    let(:applications) do
      [
        double(id: 1, email: 'aa@gmail.com'),
        double(id: 2, email: 'bb@gmail.com'),
        double(id: 3, email: 'cc@gmail.com')
      ]
    end
    it "returns an error if email already exists" do
      result = helper.application_email_search(applications, 'bb@gmail.com', 4)
      expect(result).to eq({ errors: { email: "Student with this email exists!"}})
    end

    it "returns an email if not found" do
      result = helper.application_email_search(applications, 'bb@gmail.com', 2)
      expect(result).to eq('bb@gmail.com')
    end

    it "returns an email if it does not exist on the array" do
      result = helper.application_email_search(applications, 'dd@gmail.com', 1)
      expect(result).to eq('dd@gmail.com')
    end
  end

  describe "#contact_search_by_id" do
    let(:contacts) do
      [
        double(id: 1, name: 'aa mm', email: 'aa@gmail.com', message: 'Good job!'),
        double(id: 2, name: 'gg nn', email: 'gg@email.com', message: 'Good job!')
      ]
    end

    it "returns an error if id is not found" do
      result = helper.contact_search_by_id(contacts, 4)
      expect(result).to eq({ errors: { target_id: "Contact of ID 4 not found!"}})
    end

    it "returns an object if id is found" do
      result = helper.contact_search_by_id(contacts, 2)
      expect(result).to eq(contacts[1])
    end
  end

  describe "#category_search_by_slug" do
    let(:categories) do
      [
        double(id: 1, name: "Ai", slug: "ai"),
        double(id: 2, name: "Data", slug: "data"),
        double(id: 3, name: "Design", slug: "design"),
      ]
    end

    it "returns an error if id not found" do
      result = helper.category_search_by_slug(categories, 5)
      expect(result).to eq({ errors: { category: "Category not found for '5'"}})
    end

    it "returns an error if name is not found" do
      result = helper.category_search_by_slug(categories, 'Cybersecurity')
      expect(result).to eq({ errors: { category: "Category not found for 'cybersecurity'"}})
    end

    it "returns an error slug is not found" do
      result = helper.category_search_by_slug(categories, 'cybersecurity')
      expect(result).to eq({ errors: { category: "Category not found for 'cybersecurity'"}})
    end

    it "returns a category object if id is found" do
      result = helper.category_search_by_slug(categories, 1)
      expect(result).to eq(categories[0])
    end

    it "returns a category object if slug is found" do
      result = helper.category_search_by_slug(categories, 'data')
      expect(result).to eq(categories[1])
    end
  end
end
