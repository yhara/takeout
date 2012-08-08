module CommitsHelper
  def format_note_body(txt)
    txt.lines.map{|l| "#{h l}<br>\n"}.join.html_safe
  end

  def zone(datetime)
    datetime.in_time_zone(Takeout::Conf[:time_zone])
  end

  def highlight_diff(diff)
    diff.lines.map{|line|
      case line
      when /^-/
        content_tag(:span, line, class: "diff_minus")
      when /^\+/ 
        content_tag(:span, line, class: "diff_plus")
      else
        h line
      end
    }.join
  end

  def highlight_status(stat)
    if (found = Takeout::Conf[:status_colors].find{|pat, col| pat === stat})
      content_tag(:font, stat, color: found[1])
    else
      h stat
    end
  end
end
