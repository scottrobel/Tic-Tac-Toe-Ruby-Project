require_relative 'player.rb'
class Board  
    attr_reader :x_positions, :o_positions, :avalible_spots
    def initialize
      setup_board
      @x_positions = []
      @o_positions = []
    end 
    def make_move(player,position)
        x_or_o = player.x_or_o
        if(spot_avalible?(position))
          change_board(x_or_o,position)
          update_avalible_spots(position)
        else
          puts "Sorry, Position #{position} Not avalible"
        end
    end
    def display_board
        puts_line_seperator
        @board_state.each_with_index do |position_value,index| 
          print position_value
          if((index+1)%3!=0)
            print "||"
          else
            puts ""#goes to new line
          end 
        end 
        puts_line_seperator
    end
    private
    def puts_line_seperator 
        puts "_________________________________________________"
        puts "                                                  "
    end
    def setup_board
        @board_state = (1..9).to_a.map{|e|e.to_s}#1-9 string array
        @avalible_spots = (1..9).to_a#1-9 int array 
    end  
    def spot_avalible?(position)
      @avalible_spots.include?(position)
    end 
    def update_avalible_spots(position)
      @avalible_spots = @avalible_spots - [position]
    end  
    def change_board(x_or_o, position)
      if(x_or_o == "X")
        @board_state[position-1] = "X"
        @x_positions << position
      elsif(x_or_o == "O")
        @board_state[position-1] = "O"
        @o_positions << position
      else
        puts "Invalid Position"
      end  
    end 

end 

