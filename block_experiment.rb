3.times do
  pp 'how'.upcase
end; puts



3.times do |f|
  pp f.to_s
end; puts



def self.next_letter(letter)
  result = 'a' + letter
  pp result
end


a = 'a'
a.upcase do |f|
  f.next_letter 'v'
end

next_letter a
