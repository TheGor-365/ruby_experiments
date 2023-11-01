def pluralize(count, singular, plural_arg = nil, plural: plural_arg, locale: I18n.locale)
  word = if (count == 1 || count.to_s =~ /^1(\.0+)?$/)
    singular
  else
    plural || singular.pluralize(locale)
  end

  "#{count || 0} #{word}"
end
