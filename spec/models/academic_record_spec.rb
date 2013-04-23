require 'spec_helper'

describe AcademicRecord do
  it "is valid with a university, degree, start, finish, gpa, gpa_range" do
    academicrecord = AcademicRecord.new(university: 'University of California, San Diego', degree: 'Biology', start: '01/01/2000', finish: '01/01/2004', gpa: '3.5', gpa_range: '4.0')
    expect(academicrecord).to be_valid
  end
  
  it "is invalid without a university" do
    expect(AcademicRecord.new(university: nil)).to have(1).error_on(:university) 
  end
  
  it "is invalid without a degree" do
    expect(AcademicRecord.new(degree: nil)).to have(1).error_on(:degree)
  end
  
  it "is invalid without a start" do
    expect(AcademicRecord.new(start: nil)).to have(1).error_on(:start)
  end
  
  it "is invalid without a finish" do
    expect(AcademicRecord.new(finish: nil)).to have(1).error_on(:finish)
  end
  
  it "is invalid without a gpa" do
    expect(AcademicRecord.new(gpa: nil)).to have(1).error_on(:gpa)
  end
  
  it "is invalid without a gpa_range" do
    expect(AcademicRecord.new(gpa_range: nil)).to have(1).error_on(:gpa_range)
  end
  
end