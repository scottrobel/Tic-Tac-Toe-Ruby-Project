class Player    
  attr_reader :player_name, :x_or_o
  @@avalible_player_options = ["X","O"] 
  def initialize(player_name)
    @player_name = player_name
    @x_or_o = @@avalible_player_options.pop() if(!@@avalible_player_options.empty?)
    #puts "Hello #{self.player_name} You are #{@x_or_o}'s"
  end
end
