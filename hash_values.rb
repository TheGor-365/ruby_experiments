@h = {"key"=>"value", "key2"=>"value2"}

def returner(key, value = nil)
  @h.fetch(key.to_s, value)
end

puts returner(:key).inspect
puts returner(:key2, 'lala').inspect
puts returner(:new, 'ehu').inspect
puts returner(:lalala).inspect
puts returner(:lalala, 'default').inspect
