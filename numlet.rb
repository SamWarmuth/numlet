

class Integer
  Language = {
    "en" => {:ones  => %w[zero one two three four five six seven eight nine ten 
                          eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen], 
             :tens  => %w[zero ten twenty thirty forty fifty sixty seventy eighty ninety], 
             :hundred => "hundred",
             :large => %w[thousand million billion trillion].insert(0, ""),
             :tens_connect => "-"},
             
    "es" => {:ones  => %w[cero uno dos tres cuatro cinco seis siete ocho nueve diez
                          once doce trece catorce quince dieciséis diecisiete dieciocho diecinueve],
             :tens  => %w[cero diez veinte treinta cuarenta cincuenta sesenta setenta ochenta noventa],
             :hundred => "cien",
             :large => %w[mil millón billion trillion].insert(0, ""),
             :tens_connect => " y "}
    }

   def to_words(args = {})
     language = Language[args[:lang] || "en"]
     raise "Language Invalid/Not Found" if language.nil?
     
     
     triplets = to_s.reverse.scan(/\d{1,3}/).map{|l| l.reverse.to_i}
     output = ""
     triplets.each_with_index do |triplet, index|
       tens = (triplet%100 < 20 ? language[:ones][triplet%100] : (language[:tens][triplet%100/10] + (triplet%10 == 0 ? "" : language[:tens_connect] + language[:ones][triplet%10])))
       hundreds = (triplet/100 == 0 ? "" : language[:ones][triplet/100] + " " + language[:hundred])
       large = language[:large][index]
       output = hundreds + " " + tens + " "+large+ " " + output
     end
     return output
   end
end

puts 55.to_words(:lang => "es")
