class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    full_sudoku = "TRUE"
    my_sudoku = Array.new(9){Array.new(9){0}}    
    text_data = @puzzle_string.gsub("-","").gsub("+","").gsub(" ","").gsub("|","").gsub(/^$\n/,"").lines.map(&:chomp)
    for z in 0..8
        one_line = text_data[z]
        for i in 0..8
	    my_sudoku[z][i] = one_line[i]
	end
    end

    for z in 0..8
	for i in 0..8
	    for e in i+1..8
		if my_sudoku[z][i]!="0" and my_sudoku[z][e]!="0"
	            if my_sudoku[z][i] == my_sudoku[z][e]
		        return "Sudoku ir nederīgs."
	    	    end
		else
		    full_sudoku = "FALSE"
		end
		if my_sudoku[i][z]!="0" and my_sudoku[e][z]!="0"
	            if my_sudoku[i][z] == my_sudoku[e][z]
		        return "Sudoku ir nederīgs."
	    	    end
		else
		    full_sudoku = "FALSE"
		end
	    end
	end
    end
    
    row = 0
    col = 0
    one_box = Array.new
    for z in 0..8
	if z == 1
	    row = 3
	elsif z == 2
	    row = 6
	elsif z == 3
	    row = 0
	    col = 3
	elsif z == 4
	    row = 3
	elsif z == 5
	    row = 6
	elsif z == 6
	    row = 0
	    col = 6
	elsif z == 7
	    row = 3
	elsif z == 8
	    row = 6
	end
	for i in row..row+2
	    for e in col..col+2
		if my_sudoku[i][e]!="0"
		    one_box << my_sudoku[i][e]
		end
	    end
	end
        if one_box.uniq.count == 1
	    return "Sudoku ir nederīgs."
        end
    end
 
    if full_sudoku == "FALSE"
	return "Sudoku ir derīgs, bet nepabeigts."
    else
        return "Sudoku ir derīgs."
    end
  end
end
