

class RPS
  ROCK = 0 
  PAPER = 1
  SCISSORS = 2
  CHOICES = ["rock", "paper", "scissors"]

  def initialize(rounds)
    if valid_rounds? rounds
      best_of rounds
    else
      puts "Sorry, rounds has to be odd."
    end
  end

  # this is the grossest function imho
  def calculate_winner(a, b)
    if a == b
      puts "A tie!"
      return [0,0]
    elsif a == ROCK && b == SCISSORS ||
          a == SCISSORS && b == PAPER ||
          a == PAPER && b == ROCK
      puts "You win that round! (#{RPS::CHOICES[a]} beats #{RPS::CHOICES[b]})"
      return [1,0]
    elsif b == ROCK && a == SCISSORS ||
          b == SCISSORS && a == PAPER ||
          b == PAPER && a == ROCK
      puts "You lose that round :( (#{RPS::CHOICES[a]} loses to #{RPS::CHOICES[b]})"
      return [0,1]
    end
    puts "what: #{a} #{b}"
  end

  # The state is how we keep track of the game scores.
  # The state is a list of scores [player1, player2].
  def update_state(state, round_score)
    [state[0] + round_score[0], state[1] + round_score[1]]
  end

  def instructions
    string = ""
    RPS::CHOICES.each_with_index do |i, choice|
      string << "#{i}: #{choice} "
    end
    string
  end

  def get_player_move
    puts instructions
    input = gets.chomp.to_i
    if !valid_input? input
      puts "Invalid input."
      # update input until the user gets it right
      input = get_player_move
    end
    input
  end

  def valid_input?(input)
    RPS::CHOICES[input] != nil
  end

  def get_computer_move
    rand(0..2)
  end

  def total_score(state)
    state[0] + state[1]
  end

  def end_condition?(state, best_of)
    first_to = (best_of + 1) / 2
    state.include? first_to
  end

  # can only have best of odd_number
  def valid_rounds?(rounds)
    rounds % 2 == 1
  end

  def best_of(rounds)
    state = [0,0]
    loop do |game_number|
      user_move = get_player_move
      computer_move = get_computer_move
      winner = calculate_winner(user_move, computer_move)
      state = update_state(state, winner)
      if end_condition?(state, rounds)
        if state[0] > state[1]
          puts "You win!"
        else
          puts "You lose :("
        end
        puts "You: #{state[0]}"
        puts "Computer: #{state[1]}"
        end_game
      end
    end
  end

  def end_game
    puts "thanks for playing!"
    exit(1)
  end
end

# make a new game
puts "Best of how many? (must be odd!)"
rounds = gets.chomp.to_i
rps = RPS.new rounds
