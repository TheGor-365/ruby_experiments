3.times do
  p 'how'.upcase
end
puts

3.times do |f|
  p f.to_s
end
puts

def self.next_letter(letter)
  res = 'a' + letter
  p res
end

a = 'a'
a.upcase do |f|
  f.next_letter 'v'
end

next_letter a
