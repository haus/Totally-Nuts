require 'totally_nuts'

describe TotallyNuts do
  describe "Using the assigned puzzle" do
    let (:puzzle) { "2 3 3 2 4 1\n3 3 1 2 3 4\n4 2 1 2 3 3\n1 4 3 1 2 3\n3 3 2 3 4 2\n2 2 4 1 1 2\n1 3 2 2 4 3" }
    let (:total_nuts) { TotallyNuts.new(puzzle) }

    it "should parse the puzzle text correctly" do
      total_nuts.cogs.should == [ [2,3,3,2,4,1], [3,3,1,2,3,4], [4,2,1,2,3,3], [1,4,3,1,2,3], [3,3,2,3,4,2], [2,2,4,1,1,2], [1,3,2,2,4,3] ]
    end

    it "should have at least one solution" do
      total_nuts.search(false)
      total_nuts.results.size.should > 0
    end
  end

  describe "Using the example puzzle (should be unsolvable)" do
    let (:puzzle) { "1 2 3 4 5 6\n1 2 3 4 5 6\n1 2 3 4 5 6\n1 2 3 4 5 6\n1 2 3 4 5 6\n1 2 3 4 5 6\n1 2 3 4 5 6\n" }
    let (:total_nuts) { TotallyNuts.new(puzzle) }

    it "should parse the puzzle text correctly" do
      total_nuts.cogs.should == [ [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6] ]
    end

    it "should have no solutions" do
      total_nuts.search(false)
      total_nuts.results.size.should == 0
    end
  end

  describe "Using a handcrafted puzzle (with at least one solution" do
    let (:puzzle) { "1 2 2 1 4 3\n2 3 2 3 4 1\n2 2 2 3 3 3\n1 2 2 1 4 4\n3 4 2 4 1 2\n2 4 4 2 1 1\n3 1 2 4 3 3" }
    let (:total_nuts) { TotallyNuts.new(puzzle) }
    before do
      total_nuts.search(false)
    end

    it "should parse the puzzle text correctly" do
      total_nuts.cogs.should == [ [1,2,2,1,4,3], [2,3,2,3,4,1], [2,2,2,3,3,3], [1,2,2,1,4,4], [3,4,2,4,1,2], [2,4,4,2,1,1], [3,1,2,4,3,3] ]
    end

    it "should have at least one solution" do
      total_nuts.results.size.should > 0
    end
  end

  describe "Using the Drive Ya Nuts puzzle from the web site. Known to have one solution" do
    let (:puzzle) { "3 5 2 4 6 1\n6 3 4 1 2 5\n1 3 5 4 2 6\n3 2 6 4 1 5\n2 3 4 5 6 1\n4 3 2 1 6 5\n5 6 1 4 2 3" }
    let (:total_nuts) { TotallyNuts.new(puzzle) }

    before do
      total_nuts.search(false)
    end

    it "should parse the puzzle text correctly" do
      total_nuts.cogs.should == [ [3,5,2,4,6,1], [6,3,4,1,2,5], [1,3,5,4,2,6], [3,2,6,4,1,5], [2,3,4,5,6,1], [4,3,2,1,6,5], [5,6,1,4,2,3] ]
    end

    it "should have exactly one solution" do
      total_nuts.results.size.should == 1
      total_nuts.results.include?([ [1,3,5,4,2,6], [2,6,4,1,5,3], [5,6,1,2,3,4], [2,4,6,1,3,5], [4,3,2,1,6,5], [1,2,5,6,3,4], [3,5,6,1,4,2] ]).should == true
    end
  end
end
