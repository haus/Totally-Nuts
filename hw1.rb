require 'totally_nuts'

puzzle = "2 3 3 2 4 1
3 3 1 2 3 4
4 2 1 2 3 3
1 4 3 1 2 3
3 3 2 3 4 2
2 2 4 1 1 2
1 3 2 2 4 3"

tn = TotallyNuts.new(puzzle)
tn.search
