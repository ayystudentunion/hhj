module TestSingletons
  def self.sparta
    @sparta ||= FactoryGirl.create :spartan_teknillinen_yliopisto
  end

  def self.eija
    @eija ||= FactoryGirl.create :eija
  end

  def self.helsinki
    @helsinki ||= FactoryGirl.create :helsinki_uni
  end

  def self.helsinki_uni_student_council
    @helsinki_uni_student_council ||= FactoryGirl.create :helsinki_uni_student_council
  end

  def self.call_for_student_council_board
    @call_for_student_council_board ||= FactoryGirl.create :call_for_student_council_board
  end

  def self.helsinki_uni_student_union_employee
    @helsinki_uni_student_union_employee ||= FactoryGirl.create :helsinki_uni_student_union_employee
  end

  def self.kirjakerho
    @kirjakerho ||= FactoryGirl.create :kirjakerho
  end

  def self.lukurinki
    @lukurinki ||= FactoryGirl.create :lukurinki
  end

  def self.luonnontieteellinen_tiedekunta
    @luonnontieteellinen_tiedekunta ||= FactoryGirl.create :luonnontieteellinen_tiedekunta
  end

  @students = {}

  def self.helsinki_uni_student(student)
    @students[student] ||= FactoryGirl.create "helsinki_uni_student_#{student}"
  end

  def self.kirjasto
    @kirjasto ||= FactoryGirl.create :kirjasto
  end

  def self.clear
    @sparta = @eija = @helsinki = nil
    @helsinki_uni_student_council = @call_for_student_council_board = nil
    @helsinki_uni_student_union_employee = nil
    @kirjakerho = nil
    @lukurinki = nil
    @luonnontieteellinen_tiedekunta = nil
    @students = {}
    @kirjasto = nil
  end
end
