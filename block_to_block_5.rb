def wrap_in_tags(tag, text)
  html = "<#{tag}>#{text}</#{tag}>"
  yield html
end

wrap_in_tags('title', 'Hello') { |html| Mailer.send(html) }
wrap_in_tags('title', 'Hello') { |html| Page.create(:body => html) }
