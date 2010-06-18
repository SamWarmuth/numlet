require '../lib/numlet'
require 'test/unit'
class BasicTests < Test::Unit::TestCase
  def test_didnt_break_class
    assert_equal(55.class, Fixnum)
  end
end

class EnglishTest < Test::Unit::TestCase
  @cardinals = File.read('cardinals/en.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  @cardinals.each do |pair|
    define_method("test_english_#{pair[0]}".to_sym) do
      assert_equal(pair[1], pair[0].to_cardinal('en'))
    end
  end
end

class FrenchTest < Test::Unit::TestCase
  @cardinals = File.read('cardinals/fr.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  @cardinals.each do |pair|
    define_method("test_french_#{pair[0]}".to_sym) do
      assert_equal(pair[1], pair[0].to_cardinal('fr'))
    end
  end
end

class GermanTest < Test::Unit::TestCase
  @cardinals = File.read('cardinals/de.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  @cardinals.each do |pair|
    define_method("test_german_#{pair[0]}".to_sym) do
      assert_equal(pair[1], pair[0].to_cardinal('de'))
    end
  end
end

class ItalianTest < Test::Unit::TestCase
  def setup
    @cardinals = File.read('cardinals/it.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  end
  
  def test_to_cardinal
    @cardinals.each do |pair|
      assert_equal(pair[1], pair[0].to_cardinal('it'))
    end
  end
end

class PortugueseTest < Test::Unit::TestCase
  def setup
    @cardinals = File.read('cardinals/pt.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  end
  
  def test_to_cardinal
    @cardinals.each do |pair|
      assert_equal(pair[1], pair[0].to_cardinal('pt'))
    end
  end
end

class SpanishTest < Test::Unit::TestCase
  @cardinals = File.read('cardinals/es.txt').map{|l| l = l.split(","); [l[0].to_i, l[1].strip]}
  @cardinals.each do |pair|
    define_method("test_spanish_#{pair[0]}".to_sym) do
      assert_equal(pair[1], pair[0].to_cardinal('es'))
    end
  end
end

