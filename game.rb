require_relative 'board.rb'
require_relative 'player.rb'
class Game
    
    def initialize
        @game_board = Board.new 
    end
    def play_game
        assign_player_names
        while(!game_over?)
            turn(@player_one)
            break if(game_over?)
            turn(@player_two)
        end
        congrads_winner
    end
    private
    def congrads_winner
        winning_player = (win?(@player_one))? @player_one : @player_two
        @game_board.display_board
        puts "Congrads! Player #{get_player_number(winning_player)} AKA #{winning_player.player_name}: You WIN!!!"
        print_trophy(winning_player)
    end 
    def assign_player_names
        puts "player 1 You are O's Please enter your name"
        player_one_name = gets.chomp
        puts "player 2 You are X's Please enter your name"
        player_two_name = gets.chomp
        @player_one = Player.new(player_one_name)
        @player_two = Player.new(player_two_name)
    end 
    def game_over?
        win?(@player_one) || win?(@player_two)
    end 
    def win?(player)
        if(player.x_or_o == "X")
            player_positions = @game_board.x_positions
        elsif(player.x_or_o == "O")
            player_positions = @game_board.o_positions
        else
            puts "Something went wrong in 'win?' method"
        end  
        
        win_combos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        win_combos.any? do |win_combo_group|
            win_combo_group.all? do |winning_number|
                (player_positions.include?(winning_number))
            end 
        end 
    end
    def turn(player)
        position_placment = nil
        @game_board.display_board
        puts "Player #{get_player_number(player)}: #{player.player_name}"
        puts "You are #{player.x_or_o}'s"
        puts "Enter The position you would like to place Your #{player.x_or_o}"
        while true
            position_placment  = gets.chomp
            if(position_avalible?(position_placment)) 
                break
            else
                puts "invalid position. Your avalible Options Are #{@game_board.avalible_spots.join("-")}"
            end 
        end 
        @game_board.make_move(player, position_placment.to_i)

    end 
    def position_avalible?(position)
        @game_board.avalible_spots.include?(position.to_i)
    end 
    def get_player_number(player)
        (player.x_or_o == "O")? "1" : "2"
    end 
    def print_trophy(player)
    puts"     ___________"
    puts"    '._==_==_=_.'"
    puts"    .-\:      /-."
    puts"   | (|PLAYER#{get_player_number(player)}|) |"
    puts"    '-|:.     |-'"
    puts"      \::.    /"
    puts"       '::. .'"
    puts"         ) ("
    puts"       _.' '._"   
    puts"      `\"\"\"\"\"\"\"`"
    end 
end 
game_one = Game.new()
game_one.play_game