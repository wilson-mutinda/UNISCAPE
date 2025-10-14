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
end
