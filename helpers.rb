class Time
  def pretty_format
    date = self
    expression = ""

    case date.hour
    when  0..4
      date -= 1.day
      expression = "late, late night"
    when  5..6  then expression = "early morning"
    when  7..11 then expression = "morning"
    when 12..16 then expression = "afternoon"
    when 17..20 then expression = "evening"
    when 21..23 then expression = "night"
    end

    date.pretty_date_format + ", in the " + expression
  end

  def pretty_date_format
    self.strftime("%h %d, %Y")
  end
end

class ViewHelpers
  def published_line(page, short = true)
    method = short ? :pretty_date_format : :pretty_format
    if page.modified?
      "updated " + page.current_version.publish_date.send(method)
    else
      "published " + page.versions.first.publish_date.send(method)
    end
  end

  def adjust_header_levels(html)
    html.gsub(/<(\/?)h([0-4])>/) do |tag|
      "<" + $1 + "h" + ($2.to_i + 2).to_s + ">"
    end
  end

  def absolutify_urls(html)
    site = "http://alltom.com/"
    html.gsub(/(src|href)="([^"]*)"/) do |url|
      $1 + '="' + URI.join(site, $2).to_s + '"'
    end
  end
end

def local_file(filename)
  File.join(File.dirname(__FILE__), filename)
end
