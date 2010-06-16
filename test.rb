require 'numlet'
require 'test/unit'
class BasicTests < Test::Unit::TestCase
  def test_number_is_number
    assert_equal(55.class, Fixnum)
  end
end

class EnglishTest < Test::Unit::TestCase
  def setup
    @numbers = File.read('cardinals/en.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  end
  
  def test_number_to_words
    @numbers.each do |pair|
      assert_equal(pair[1], pair[0].to_words('en'))
    end
  end
end

class FrenchTest < Test::Unit::TestCase
  def setup
    @numbers = File.read('cardinals/fr.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  end
  
  def test_number_to_words
    @numbers.each do |pair|
      assert_equal(pair[1], pair[0].to_words('fr'))
    end
  end
end

class SpanishTest < Test::Unit::TestCase
  def setup
    @numbers = File.read('cardinals/es.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  end
  
  def test_number_to_words
    @numbers.each do |pair|
      assert_equal(pair[1], pair[0].to_words('es'))
    end
  end
  
end

