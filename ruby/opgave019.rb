# You are given the following information, but you may prefer to do some research for yourself.

# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

# februar falder 31%7 = 3 dage senere end janar
# marts falder samme dag som februar, hvis ikke skud år, ellers 1 dag senere
# april falder 31%7 = 3 dage senere end marts
# maj falder 30%7 = 2 dage senere end april
# juni falder 31%7 = 3 dage senere end maj
# juli falder 30%7 = 2 dage senere end juni
# august falder 31%7 = 3 dage senere end juli
# september falder 31%7 = 3 dage senere end august
# oktober falder 30%7 = 2 dage senere end september
# november falder 31%7 = 3 dage senere end oktober
# december falder 30%7 = 2 dage senere end november
# januar falder 31%7 = 3 dage senere end december

class Sundays
  def initialize
    @current_day = 1
    @current_year = 1900
    @sundays = 0
  end

  def newDay(add)
    @current_day += add
    @current_day %= 7
  end

  def sunday
    @sundays += 1 if @current_day == 0
  end

  def leapYear
    leap = 0
    if @current_year % 4 == 0
      leap = 1
      if @current_year % 100
        leap = 0
        if @current_year % 400
          leap = 1
        end
      end
    end
    leap
  end

  def sundays
    while (@current_year < 2001) do
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(leapYear)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(2)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(2)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(2)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      if @current_year > 1900
        sunday()
      end
      newDay(2)
      if @current_year > 1900
        sunday()
      end
      newDay(3)
      @current_year += 1
    end
    @sundays
  end
end

sunday = Sundays.new
puts sunday.sundays