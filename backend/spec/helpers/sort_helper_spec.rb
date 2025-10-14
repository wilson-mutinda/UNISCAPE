require 'rails_helper'
RSpec.describe SortHelper, type: :helper do
  describe "#course_name_sort" do
    let(:courses) do
      [
        double(course_name: 'Backend Development'),
        double(course_name: 'Data Analytics'),
        double(course_name: 'AI Engineering')
      ]
    end

    it "returns an array of courses sorted in ascending order by course_name" do
      result = helper.course_name_sort(courses)
      names = result.map(&:course_name)
      expect(names).to eq(['AI Engineering', 'Backend Development', 'Data Analytics'])
    end
  end
end
