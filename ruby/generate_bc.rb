# Generates a relative path breadcrumb navigation bar from a url and
# a given separator

def generate_bc(url, separator)
  url_parts = make_url_parts(url)
  paths = build_paths(url_parts)
  names = make_names(url_parts)
  paths.map.with_index{ |path, i|
    a_or_span = i != paths.length - 1
    generate_a_or_span(path, names[i], a_or_span)
  }.join(separator)
end

def build_paths(url_parts)
  url_parts.map.with_index { |part, i| url_parts.slice(0, i).join + part }
end

def generate_a_or_span(path, name, boolean)
  short_name = name.length > 30 ? make_acronym(name) : name
  boolean ? '<a href="' + path + '">' + short_name + '</a>' : '<span class="active">' + short_name + '</span>'
end

def make_acronym(str)
  skip = ["the", "of", "in", "from", "by", "with", "and", "or", "for", "to", "at", "a"]
  str.split(' ').reject { |w| skip.include? w.downcase }.map { |w| w[0] }.join
end

def make_names(url_parts)
  url_parts[0] = "HOME"
  url_parts.map { |part| part.gsub(/-/, ' ').sub(/\//, '').upcase }
end

def make_url_parts(url)
  url.sub!(/^https?:\/\//, '')
  url_parts = url.scan(/\b[\w\-._?#=&]+\/?/).map { |part| part.sub(/[?#.].+/, '') }
  url_parts[0] = '/'
  url_parts.reject! { |part| part =~ /^index/ }
  url_parts
end

puts generate_bc("mysite.com/pictures/holidays.html", " : ")
# => <a href="/">HOME</a> : <a href="/pictures/">PICTURES</a> : <span class="active">HOLIDAYS</span>
puts generate_bc("www.codewars.com/users/GiacomoSorbi?ref=CodeWars", " / ")
# => <a href="/">HOME</a> / <a href="/users/">USERS</a> / <span class="active">GIACOMOSORBI</span>
puts generate_bc("www.microsoft.com/docs/index.htm#top", " * ")
# => <a href="/">HOME</a> * <span class="active">DOCS</span>
puts generate_bc("mysite.com/very-long-url-to-make-a-silly-yet-meaningful-example/example.asp", " > ")
# => <a href="/">HOME</a> > <a href="/very-long-url-to-make-a-silly-yet-meaningful-example/">VLUMSYME</a> > <span class="active">EXAMPLE</span>
puts generate_bc('pippi.pi/in-transmutation-biotechnology/skin-bed-bladder-cauterization-kamehameha#offers?order=desc&filter=adult', ' > ')
# => <a href="/">HOME</a> > <a href="/in-transmutation-biotechnology/">IN TRANSMUTATION BIOTECHNOLOGY</a> > <span class="active">SBBCK</span>
