# tic-tac-toe
# In this program two users play the game tic-tac-toe prompting each user to select a new space until either one player matches one of the winning space combinations or there are no empty spaces left on the board. 


class Board
    
    attr_writer :board_array

    def initialize(board_array)
      @board_array = board_array
    end

    def update(board_array)
      @board_array = board_array
    end

    def board_array
      @board_array
    end

    # Prints board arranged visually for users
    def board_visual

      puts "\n#{replace_digit(@board_array, 0)} | #{replace_digit(@board_array, 1)} | #{replace_digit(@board_array, 2)}\n--+---+--\n#{replace_digit(@board_array, 3)} | #{replace_digit(@board_array, 4)} | #{replace_digit(@board_array, 5)} \n--+---+--\n#{replace_digit(@board_array, 6)} | #{replace_digit(@board_array, 7)} | #{replace_digit(@board_array, 8)}"

    end

    # Method replaces visual representation of digits in array to show X's and O's
    def replace_digit(digit_array, index)
      if digit_array[index] == 0
        return "O"
      elsif digit_array[index] == 1
        return "X"
      elsif digit_array[index] == -1
        if index == 0
          return "0"
        end
        if index == 1
          return "1"
        end
        if index == 2
          return "2"
        end
        if index == 3
          return "3"
        end
        if index == 4
          return "4"
         end
        if index == 5
          return "5"
         end
        if index == 6
          return "6"
         end
        if index == 7
          return "7"
        end
        if index == 8
          return "8"
        end
      end  
    end # Ends function


    def check_victory(player)

      # Victorious Combinations
      check_combos = [[0, 1, 2], [0, 4, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [2, 4, 6],  [3, 4, 5], [6, 7, 8]] 

      player1_array = [] # values that are pushed from each_index check
      player2_array = []

    
      # Pushes values selected by players into player_arrays
      @board_array.each_index { |value|
      
        if @board_array[value] == 0 
          player1_array.push(value)
          player1_array = player1_array.sort
        end

        if @board_array[value] == 1 
          player2_array.push(value)
          player2_array = player2_array.sort
        end

      }

      # Checks player arrays if a victory combination has been met 
      check_combos.each{ |value|
  

        selected_array1 = player1_array
        selected_array2 = player2_array
        compare_array1 = []
        compare_array2 = []

        temp_array = value
          
          index1 = 0

          # Player1 - Responsible for pushing the spaces or 'digits' taken to comparison array, the comparison array is then compared to the temp_array or the current combination being checked for.
          while index1 < selected_array1.length 
            
            if temp_array.include?(selected_array1[index1])
              compare_array1.push(selected_array1[index1]) 
              index1 += 1
            else
              index1 += 1
            end
            
          end


          index2 = 0

          # Player2 - Responsible for pushing the spaces or 'digits' taken to comparison array, the comparison array is then compared to the temp_array or the current combination being checked for.
          while index2 < selected_array2.length 
            
            if temp_array.include?(selected_array2[index2])
              compare_array2.push(selected_array2[index2]) 
              index2 += 1
            else
              index2 += 1
            end
            
          end
        

        if player1_array.length >= 3 && temp_array == compare_array1 # TESTING
          puts "Player1 reached Victory first!"
          return true
        end

        if player2_array.length >= 3 && temp_array == compare_array2 # TESTING
          puts "Player2 reached Victory first!"
          return true
        end
      }

    end
end # Ends Board class


# GAME STARTS HERE

board_array = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
current_board = Board.new(board_array)
player1 = 0
player2 = 1
turn_alternate = false

# This method ensures that only spaces that are not taken can be claimed by either player, otherwise the user is prompted to choose another space
def game_move(index, player, board_array)

  # Prevents taken spaces to be changed
  if board_array[index] == -1
    
    board_array[index] = player
  
  else

    puts "Choose a different position..."
    index = gets.chomp.to_i
    game_move(index, player, board_array)

  end
  
end

# Print introduction to users of program
puts "Let's play Tic-Tac-Toe..."
puts current_board.board_visual

# While 'game' loop continues for as long as there are empty spaces on the board
while current_board.board_array.include?(-1) == true

  if turn_alternate == false

    puts "Player1 choose position then press enter..."
    index = gets.chomp.to_i

    game_move(index, player1, board_array)

    if current_board.check_victory("Player1") == true # TESTING
      puts current_board.board_visual
      exit(0)
    end

    turn_alternate = true
  else
    
    puts "Player2 choose position then press enter..."
    index = gets.chomp.to_i
    
    game_move(index, player2, board_array)

    if current_board.check_victory("Player2") == true # TESTING
      puts current_board.board_visual
      exit(0)
    end

    turn_alternate = false
  end

  current_board.update(board_array)
  puts current_board.board_visual


  # check if current_board includes -1 value in array
  if current_board.board_array.include?(-1) == false
    puts "GAME OVER"
  end

end


