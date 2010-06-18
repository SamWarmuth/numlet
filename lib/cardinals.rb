# encoding: utf-8
class Integer
  Rules = {"en" => [[[0], ""],
                    [(1..19).to_a,                             "[small] [magnitude]"],
                    [(1..99).to_a.find_all{|n|  n%10 == 0},    "[tens] [magnitude]"],
                    [(1..99).to_a.delete_if{|n| n%10 == 0},    "[tens]-[ones] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 == 0}, "[hundreds] hundred [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 <= 19}, "[hundreds] hundred [small] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%10 == 0},  "[hundreds] hundred [tens] [magnitude]"],
                    [(100..999).to_a.delete_if{|n| n%10 == 0}, "[hundreds] hundred [tens]-[ones] [magnitude]"]],
            "de" => [[[0], ""],
                    [[1], "eins[magnitude]"],
                    [(2..20).to_a,                             "[small][magnitude]"],
                    [(1..99).to_a.find_all{|n|  n%10 == 0},    "[tens][magnitude]"],
                    [(1..99).to_a.delete_if{|n| n%10 == 0},    "[ones]und[tens][magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 == 0}, "[hundreds][hundred_name][magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 == 1}, "[hundreds][hundred_name]eins"],
                    [(100..999).to_a.find_all{|n| n%100 <= 20},"[hundreds][hundred_name][small][magnitude]"],
                    [(100..999).to_a.find_all{|n| n%10 == 0},  "[hundreds][hundred_name][tens][magnitude]"],
                    [(100..999).to_a.delete_if{|n| n%10 == 0}, "[hundreds][hundred_name][ones]und[tens][magnitude]"]],
            "es" => [[[0], ""],
                    [(1..29).to_a,                             "[small] [magnitude]"],
                    [(1..99).to_a.find_all{|n|  n%10 == 0},    "[tens] [magnitude]"],
                    [(1..99).to_a.delete_if{|n| n%10 == 0},    "[tens] y [ones] [magnitude]"],
                    [[100],                                    "cien"],
                    [(100..999).to_a.find_all{|n| n%100 == 0}, "[hundred_name] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 <= 29}, "[hundred_name] [small] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%10 == 0},  "[hundred_name] [tens] [magnitude]"],
                    [(100..999).to_a.delete_if{|n| n%10 == 0}, "[hundred_name] [tens] y [ones] [magnitude]"]],
            "fr" => [[[0], ""],
                    [(1..19).to_a,                             "[small] [magnitude]"],
                    [[71],                                     "[tens] et [small] [magnitude]"],
                    [(70..79).to_a,                            "[tens]-[small] [magnitude]"],
                    [(1..99).to_a.find_all{|n|  n%10 == 0},    "[tens] [magnitude]"],
                    [(1..99).to_a.find_all{|n|  n%10 == 1},    "[tens] et [ones] [magnitude]"],
                    [(1..99).to_a.delete_if{|n| n%10 == 0},    "[tens]-[ones] [magnitude]"],
                    [[100],                                    "cien"],
                    [(100..999).to_a.find_all{|n| n%100 == 0}, "[hundreds] [hundred_name] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%100 <= 19}, "[hundreds] [hundred_name] [small] [magnitude]"],
                    [(100..999).to_a.find_all{|n| n%10 == 0},  "[hundreds] [hundred_name] [tens] [magnitude]"],
                    [(100..999).to_a.delete_if{|n| n%10 == 0}, "[hundreds] [hundred_name] [tens] y [ones] [magnitude]"]]        
            }
  
  
  Cardinals = {
    "en" => {:ones  => %w[one two three four five six seven eight nine ten 
                          eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen].unshift(""), 
             :tens  => %w[ten twenty thirty forty fifty sixty seventy eighty ninety].unshift(""), 
             :hundreds => Array.new(10, "hundred"),
             :magnitude => %w[thousand million billion trillion].unshift(""),
             :zero => "zero",
             :join => " "},
    "de" => {:ones  => %w[ein zwei drei vier fünf sechs sieben acht neun zehn
                          elf zwölf dreizehn vierzehn fünfzehn sechzehn siebzehn achtzehn neunzehn zwanzig].unshift(""),
             :tens  => %w[zehn zwanzig dreißig vierzig fünfzig sechzig siebzig achtzig neunzig].unshift(""),
             :hundreds => Array.new(10, "hundert"),
             :magnitude => ["tausend", " Millionen"].unshift(""),
             :tens_connect => " y ",
             :zero => "null",
             :join => ""},
    "es" => {:ones  => %w[uno dos tres cuatro cinco seis siete ocho nueve diez
                          once doce trece catorce quince dieciséis diecisiete dieciocho diecinueve
                          veinte veintiuno veintidós veintitrés veinticuatro veinticinco
                          veintiséis veintisiete veintiocho veintinueve].unshift(""),
             :tens  => %w[diez veinte treinta cuarenta cincuenta sesenta setenta ochenta noventa].unshift(""),
             :hundreds => %w[ciento doscientos trescientos cuatrocientos quinientos seiscientos setecientos ochocientos novecientos].unshift(""),
             :magnitude => %w[mil millón].unshift(""),
             :tens_connect => " y ",
             :zero => "cero",
             :join => " "},
    "fr" => {:ones  => %w[un deux trois quatre cinq six sept huit neuf dix
                          onze douze treize quatorze quinze seize dix-sept dix-huit dix-neuf].unshift(""),
             :tens  => %w[dix vingt trente quarante cinquante soixante soixante quatre-vingt].unshift(""),
             :hundreds => Array.new(10, "cent"),
             :magnitude => %w[mille million].unshift(""),
             :tens_connect => " y ",
             :zero => "zéro",
             :join => " "}
    }

  def to_cardinal(lang = "en")
    language = Cardinals[lang]
    raise "Language Invalid/Not Found" if language.nil?
    rules = Rules[lang]
    raise "Language Rules Invalid/Not Found" if rules.nil?
    triplets = to_s.reverse.scan(/\d{1,3}/).map{|l| l.reverse.to_i}
    
    return language[:zero] if self == 0
    return triplets.each_with_index.map do |triplet, index|
      replacements = {"[small]" => language[:ones][((triplet%100)%language[:ones].length)], 
                      "[ones]" => language[:ones][triplet%10],
                      "[tens]" => language[:tens][(triplet%100)/10],
                      "[hundreds]" => language[:ones][triplet/100],
                      "[hundred_name]" => language[:hundreds][triplet/100],
                      "[magnitude]" => language[:magnitude][index].to_s}
      output = rules.find{|rule| rule[0].include?(triplet)}[1].dup
      replacements.each_pair{|key, val| output.gsub!(key, val)}
      output.strip
    end.reverse.find_all{|trip| !trip.empty?}.join(language[:join]).strip
  end
end
