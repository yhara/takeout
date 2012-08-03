module CommitsHelper
  def format_note_body(txt)
    txt.lines.map{|l| "#{h l}<br>\n"}.join.html_safe
  end

  def zone(datetime)
    datetime.in_time_zone(Takeout::Conf[:time_zone])
  end
end
