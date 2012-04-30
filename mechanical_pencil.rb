class MechanicalPencil
  attr_reader :writeable_lead_length, :stored_lead
  
  def initialize(stored_lead = [100,100])
    @stored_lead = stored_lead
    @writeable_lead_length = 0
  end

  def click!
    10.times do
      if @stored_lead[0].is_a?(Integer) && @stored_lead[0] > 1
        @stored_lead[0] -= 1
        @writeable_lead_length += 1
      else
        @stored_lead.shift
        @writeable_lead_length += 1
      end
    end

  end

  def clicked?
    writeable_lead_length > 0
  end

  alias writeable? clicked?

  def write(string)
    written_string = ""
    if clicked?
      string.each_char do |char|
        break if @writeable_lead_length == 0
        written_string << char
        @writeable_lead_length -= 1 if char !=" "
      end
    end
    puts(written_string)
    return(written_string)
  end
end

require "test/unit"
 
class TestMechanicalPencil < Test::Unit::TestCase
 
  def setup
    @pencil = MechanicalPencil.new
  end 

  def test_pencil_has_2_leads
    pencil = MechanicalPencil.new([10,10])
    pencil.click!
    pencil.click!
    assert_equal([],pencil.stored_lead)
  end

  def test_pencil_has_no_lead_at_initialize
    assert_equal(@pencil.writeable_lead_length, 0)
  end

  def test_click_will_subtract_10_stored_lead
    @pencil.click!
    assert_equal(90, @pencil.stored_lead[0])
  end

  def test_click_adds_10_lead_length
    @pencil.click!
    assert_equal(@pencil.writeable_lead_length, 10)
  end

  def test_write_will_use_lead
    @pencil.click!
    @pencil.write("Hello World")
    assert(!@pencil.clicked?)
  end
end