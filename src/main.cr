require "ncurses"
require "./options"

class Notes
  def initialize(title, subject)
    @title = title
    @subject = subject
  end
end

module Notor
  NCurses.start
  NCurses.cbreak
  NCurses.no_echo
  NCurses.no_timeout
  NCurses.keypad true
  NCurses.mouse_mask(NCurses::Mouse::AllEvents | NCurses::Mouse::Position)

  NCurses.print "Welcum to da notes manager! Currently there is no functionality here so please come back later :)"

  NCurses.get_char
  NCurses.end
end
