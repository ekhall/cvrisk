class Patient
  attr_accessor :sbp, :chol, :hdl, :age, :htn_treated, :is_diabetic, :is_smoker, :is_male
  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def to_s
    puts "Person:
            \tAge: \t\t\t#{age}
            \tSBP: \t\t\t#{sbp}
            \tCholesterol \t\t#{chol}
            \tTreated for HTN: \t#{htn_treated}
            \tDiabetic: \t\t#{is_diabetic}
            \tSmoker: \t\t#{is_smoker}
            \tIs Male: \t\t#{is_male}".squeeze(' ')
  end

  def d12; chol.between?(199, 240)? 1 : 0;  end
  def d15; (sbp.between?(139, 160) and htn_treated.eql? false)? 1 : 0; end
  def d16; d12 + d15;             end

  def e12; (chol > 240)?  1 : 0;  end
  def e13; (sbp  > 160)?  1 : 0;  end
  def e14; htn_treated;           end
  def e15; e13 + (e14 ? 1 : 0);   end
  def e17; is_smoker;             end
  def e18; is_diabetic;           end
  def e19; e12 + e15 + (e17 ? 1 : 0) + (e18 ? 1 : 0); end # Sum of major

  def b12; (chol < 180)? 1 : 0;   end
  def b15; ((sbp < 120) and (htn_treated.eql? false))? 1 : 0; end
  def b16; b12 + b15;             end
  def b22; (e19  >= 2)? 1 : 0;    end # >= 2 major
  def b23; (e19  == 1)? 1 : 0;    end # 1 major
  def b24; ((d16 >  1) and (e19 == 0))? 1 : 0; end # Elevated
  def b25; ((c16 >= 1) and (d16 == 0) and (e19 == 0))? 1 : 0; end # Not optimal
  def b26; ((b16 == 2) and (e19 == 0))? 1 : 0; end # All optimal

  def c12; chol.between?(179, 200)? 1 : 0; end
  def c15; (sbp.between?(119, 140) and htn_treated.eql? false)? 1 : 0; end
  def c16; c12 + c15; end
  def c22; 50; end
  def c23; 39; end
  def c24; 39; end
  def c25; 27; end
  def c26;  8; end
  def c27; b22*c22 + b23*c23 + b24*c24 + b25*c25 + b26*c26; end
  def c31; (is_male.eql? true)? g27 : c27; end # Lifetime Risk ASCVD

  def lifetime_risk; c31; end

end