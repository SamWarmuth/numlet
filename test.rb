require 'numlet'
require 'test/unit'
class BasicTests < Test::Unit::TestCase
  def test_number_is_number
    assert_equal(55.class, Fixnum)
  end
  
  def test_sub_hundred_no_args
    assert_equal(55.to_words, "fifty-five")
  end
  
  def test_over_hundred_no_args
    assert_equal(392.to_words, "three hundred ninety-two")
  end
  
  def test_sub_hundred_en
    assert_equal("fifty-five", 55.to_words(:lang => 'en'))
  end
  
  def test_over_hundred_en
    assert_equal("three hundred ninety-two", 392.to_words(:lang => 'en'))
  end
  
end