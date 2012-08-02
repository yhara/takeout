module CommitsHelper
  def format_note_body(txt)
    txt.lines.map(&:chomp).join("<br>\n").html_safe
  end
end
