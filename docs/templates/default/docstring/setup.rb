def init
  super
  if show_api_marker_section?
    if sections.first
      sections.first.place(:api_marker).before(:private)
    else
      sections :index, [:api_marker]
    end
  end
end

def api_marker
  return if object.type == :root
  case api_text
  when 'public'
    #erb(:public_api_marker)
  when 'private'
    # Let section 'private' handle this.
  else
    erb(:private)
  end
end

private

def api_text
  api_text = object.has_tag?(:api) && object.tag(:api).text
  api_text = 'public' if object.has_tag?(:public)
  return api_text
end

def show_api_marker_section?
  return false if object.type == :root
  case api_text
  when 'public'
    false
  when 'private'
    false
  else
    true
  end
end
