require_relative 'board.rb'#ADD IN TIE FUNCTIONALITY
require_relative 'player.rb'
class Game
    def initialize()
        @game_board = Board.new 
        set_score_to_zero
        number_of_rounds = prompt_for_desired_number_of_rounds
        play_games(number_of_rounds)
    end
    private
    def prompt_for_desired_number_of_rounds
        puts "How many rounds would You like to play?"
        while true
            ammount_of_rounds  = gets.chomp.to_i#non ints will be converted to zero and denyed by the boolean 
            if(ammount_of_rounds.is_a?(Integer) && ammount_of_rounds > 0)
                break
            else
                puts "Please enter a valid number greater than 0"
            end
        end
        ammount_of_rounds
    end 
    def set_score_to_zero
        @player_one_wins = 0
        @player_two_wins = 0
        @ties = 0
    end 
    def play_games(number_of_rounds)
        assign_player_names
        number_of_rounds.times do 
            play_one_round
            update_score
            display_score
            @game_board.clear_board
        end    
    end
    def play_one_round
        while(!game_over?)
            turn(@player_one)
            break if(game_over?)
            turn(@player_two)
        end 
    end 
    def update_score
        if(!tie?)
            winning_player = who_won?
            @player_one_wins += 1 if(winning_player == @player_one)
            @player_two_wins += 1 if(winning_player == @player_two)
            congrads_winner(winning_player)
        else
            puts "tie"
            @ties += 1
        end
    end 
    def display_score
        print_wins
        print_ties
    end 
    def print_divider
        puts "----------------------------------"
    end
    def print_ties
        print_divider
        puts "Ties: #{@ties}"
        print_divider
    end
    def print_wins
        print_divider
        print_player_name_and_number(@player_one)
        puts "Wins :#{@player_one_wins}"
        print_divider
        print_player_name_and_number(@player_two)
        puts "Wins :#{@player_two_wins}"
        print_divider
    end 
    def congrads_winner(winning_player)
        @game_board.display_board
        puts "Congrads! Player #{get_player_number(winning_player)} AKA #{winning_player.player_name}: You WIN!!!"
        print_trophy(winning_player)
    end 
    def who_won?
        win?(get_player_positions(@player_one))? @player_one :  @player_two
    end 
    def assign_player_names
        puts "player 1 You are X's Please enter your name"
        player_one_name = gets.chomp
        puts "player 2 You are O's Please enter your name"
        player_two_name = gets.chomp
        @player_one = Player.new(player_one_name)
        @player_two = Player.new(player_two_name)
    end 
    def game_over?
        win?(get_player_positions(@player_one)) || win?(get_player_positions(@player_two)) || tie?
    end 
    def tie?
        x_plus_possible_outcomes = (@game_board.avalible_spots + @game_board.x_positions).uniq
        o_plus_possible_outcomes = (@game_board.avalible_spots + @game_board.o_positions).uniq
        !win?(x_plus_possible_outcomes) && !win?(o_plus_possible_outcomes)    
    end
    def get_player_positions(player)
        if(player.x_or_o == "X")
            player_positions = @game_board.x_positions
        elsif(player.x_or_o == "O")
            player_positions = @game_board.o_positions
        else
            puts "Something went wrong in 'win?' method"
        end  
    end 
    def win?(player_positions)
        win_combos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        win_combos.any? do |win_combo_group|
            win_combo_group.all? do |winning_number|
                player_positions.include?(winning_number)
            end 
        end 
    end
    def turn(player)
        @game_board.display_board
        prompt_player(player)
        position_placment = get_user_position_input
        @game_board.make_move(player, position_placment)
    end 
    def prompt_player(player)
        print_player_name_and_number(player)
        puts "You are #{player.x_or_o}'s"
        puts "Enter The position you would like to place Your #{player.x_or_o} Avalible options: #{@game_board.avalible_spots}"
    end 
    def print_player_name_and_number(player)
        puts "Player #{get_player_number(player)} : #{player.player_name}"
    end 
    def get_user_position_input
        while true
            position_placment  = gets.chomp
            if(position_avalible?(position_placment)) 
                break
            else
                puts "invalid position. Your avalible Options Are #{@game_board.avalible_spots.join("-")}"
            end
        end 
        position_placment.to_i
    end 
    def position_avalible?(position)
        @game_board.avalible_spots.include?(position.to_i)
    end 
    def get_player_number(player)
        (player.x_or_o == "O")? "2" : "1"
    end 
    def print_trophy(player)
    puts"     ___________"
    puts"    '._==_==_=_.'"
    puts"    .-\:      /-."
    puts"   | (|PLAYER#{get_player_number(player)}|) |"
    puts"    '-|#{player.player_name.center(7)}|-'"
    puts"      \::.    /"
    puts"       '::. .'"
    puts"         ) ("
    puts"       _.' '._"   
    puts"      `\"\"\"\"\"\"\"`"
    end 
end 
my_game = Game.new

