class Integer
  Language = {
    "en" => {:ones  => %w[one two three four five six seven eight nine ten 
                          eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen].unshift(""), 
             :tens  => %w[ten twenty thirty forty fifty sixty seventy eighty ninety].unshift(""), 
             :hundred => "hundred",
             :large => %w[thousand million billion trillion].unshift(""),
             :tens_connect => "-",
             :zero => "zero"},
             
    "es" => {:ones  => %w[uno dos tres cuatro cinco seis siete ocho nueve diez
                          once doce trece catorce quince dieciséis diecisiete dieciocho diecinueve
                          veinte veintiuno veintidós veintitrés veinticuatro veinticinco
                          veintiséis veintisiete veintiocho veintinueve].unshift(""),
             :tens  => %w[diez veinte treinta cuarenta cincuenta sesenta setenta ochenta noventa].unshift(""),
             :hundred => "cien",
             :large => %w[mil millón billion trillion].unshift(""),
             :tens_connect => " y ",
             :zero => "cero"}
    }

   def to_words(args = {})
     language = Language[args[:lang] || "en"]
     raise "Language Invalid/Not Found" if language.nil?
     
     
     triplets = to_s.reverse.scan(/\d{1,3}/).map{|l| l.reverse.to_i}
     output = ""
     triplets.each_with_index do |triplet, index|
       next if triplet == 0
       
       if triplet%100 < language[:ones].length
         tens = language[:ones][triplet%100]
       else
         tens = language[:tens][triplet%100/10] + (triplet%10 == 0 ? "" : language[:tens_connect] + language[:ones][triplet%10])
       end
       
       if triplet/100 == 0
         hundreds = ""
       else
         hundreds = language[:ones][triplet/100] + " " + language[:hundred]
       end

       large = language[:large][index]
       output = hundreds + " " + tens + " "+large+ " " + output
     end
     output = language[:zero] if output.strip.empty?
     return output.strip
   end
end
