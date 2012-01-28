class TotallyNuts
  attr_accessor :cogs, :results

  # Populate the @cogs array with the list of numbers
  def initialize input_string
    @cogs = Array.new(0)
    @results = Array.new(0)
    input_string.each_line do | line |
      @cogs << line.chomp.split(' ').map! { |elem| elem.to_i }
    end
  end

  # Simple wrapper to call back to assemble_puzzle
  def do_puzzle(puzzle, other_cog, remaining)
    new_puzzle = Array.new(puzzle) << other_cog
    assemble_puzzle(new_puzzle, remaining)
  end

  # assemble_puzzle takes the puzzle so far and tries to add a piece from the
  # pieces array to it, calling assemble_puzzle again recursively until solved
  def assemble_puzzle(puzzle, pieces)
    pieces.each do | other_cog |
      remaining = pieces - [other_cog]

      1.upto(other_cog.size) do
        other_cog.rotate!

        case puzzle.size
          when 1
            if puzzle[0][0] == other_cog[3]
              do_puzzle(puzzle, other_cog, remaining)
            end
          when 2
            if puzzle[0][1] == other_cog[4] and puzzle[1][2] == other_cog[5]
              do_puzzle(puzzle, other_cog, remaining)
            end
          when 3
            if puzzle[0][2] == other_cog[5] and puzzle[2][3] == other_cog[0]
              do_puzzle(puzzle, other_cog, remaining)
            end
          when 4
            if puzzle[0][3] == other_cog[0] and puzzle[3][4] == other_cog[1]
              do_puzzle(puzzle, other_cog, remaining)
            end
          when 5
            if puzzle[0][4] == other_cog[1] and puzzle[4][5] == other_cog[2]
              do_puzzle(puzzle, other_cog, remaining)
            end
          when 6
            if puzzle[0][5] == other_cog[2] and puzzle[5][0] == other_cog[3] and puzzle[1][4] == other_cog[1]
              new_puzzle = Array.new(puzzle) << other_cog
              if @display
                STDERR.puts "Remaining: #{remaining.inspect}" if remaining.size > 0
                puts "Solution found."
                puts "============="
                new_puzzle.each do | line |
                  line.each { | elem | print "#{elem} " }
                  puts
                end
                puts "============="
              end
              @results << Marshal.load(Marshal.dump(new_puzzle))
            end
        end
      end
    end
  end

  # main search function, calls down to assemble_puzzle and returns any valid
  # solutions
  def search display = true
    @display = display
    @cogs.each do | cog |
      remainder = Array.new(@cogs)
      remainder.delete_at(remainder.index(cog))

      # Each iteration, the only cogs to be searched are the @cogs - [cog]
      if @display
        puts
        puts "Searching #{cog.inspect} against #{remainder}"
        puts "============================"
      end
      assemble_puzzle([cog], remainder)
    end
  end

end
