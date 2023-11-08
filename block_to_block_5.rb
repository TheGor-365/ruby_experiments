def wrap_in_tags(tag, text)
  html = "<#{tag}>#{text}</#{tag}>"
  yield html
end

wrap_in_tags('title', 'Hello') do |html|
  pp html
end

wrap_in_tags('title', 'Hello') do |html|
  pp html
end
