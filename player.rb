class Player    
  attr_reader :player_name, :x_or_o
  @@alternating_assignment_boolean = true
  def initialize(player_name)
    @player_name = player_name
    @x_or_o = (@@alternating_assignment_boolean)? "X" : "O"
    @@alternating_assignment_boolean = !@@alternating_assignment_boolean
  end
 
end
