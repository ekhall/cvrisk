require 'minitest/autorun'

begin
  require_relative 'patient'
rescue LoadError => e
  eval("\"#{DATA.read}\n\"").split("\n.\n").each_with_index do |s,i|
    if i > 0
      puts "\t--- press enter to continue ---"
      gets
    end
    puts "\n\n", s, "\n\n\n"
  end
  exit!
end

class CVRiskTest < MiniTest::Unit::TestCase
  attr_reader :patient

  def test_lifetime_risk_female_smoker1
    hash = {
      sbp: 130, chol: 190, age: 50, 
      htn_treated: false, is_smoker: true, is_male: false
    }
    @patient = ::Patient.new hash
    assert_equal 39, patient.lifetime_risk
  end

  def test_lifetime_risk_female_smoker2
    hash = {
      sbp: 160, chol: 140, age: 60, 
      htn_treated: true, is_smoker: true, is_male: false
    }
    @patient = ::Patient.new hash
    assert_equal 50, patient.lifetime_risk
  end

  def test_lifetime_risk_female_nonsmoker
    hash = {
      sbp: 180, chol: 210, age: 50, 
      htn_treated: false, is_smoker: false, is_male: false
    }
    @patient = ::Patient.new hash
    assert_equal 39, patient.lifetime_risk
  end
end