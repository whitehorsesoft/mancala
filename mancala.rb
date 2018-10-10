class Mancala
  attr_accessor(:slots)
  
  def initialize
    setup
  end

  def setup
    @slots = Array.new
    (0..13).each do |i|
      @slots[i] = 4
    end

    @slots[1] = 3
    @slots[0] = 0
    @slots[7] = 0
  end

  def runthrough(player_number, slot_num)
    number_stones = @slots[slot_num]
    @slots[slot_num] = 0

    while (number_stones > 0)
      slot_num += 1
      slot_num = 0 if slot_num > 13

      if (player_number == 0 && slot_num == 0)
        @slots[slot_num] += 1
        number_stones -= 1
      elsif (player_number == 1 && slot_num == 7)
        @slots[slot_num] += 1
        number_stones -= 1
      elsif (slot_num != 0 && slot_num != 7)
        @slots[slot_num] += 1
        number_stones -= 1
      end
    end

    if (slot_num != 0 && slot_num != 7 && @slots[slot_num] > 1)
      # puts slot_num.to_s + ": " + @slots.to_s
      runthrough(player_number, slot_num)
    end

    # puts slot_num.to_s + ": " + @slots.to_s
  end

  def play
    begin
      avail1 = false
      slot_num = @slots.each_index.select{|s| s != 0 && s != 7}.max_by(1){|i| @slots[i]}.last
      if (@slots[slot_num] != 0)
        avail1 = true
        runthrough(0, slot_num)
      end

      avail2 = false
      slot_num = @slots.each_index.select{|s| s != 0 && s != 7}.max_by(1){|i| @slots[i]}.last
      if (@slots[slot_num] != 0)
        avail2 = true
        runthrough(1, slot_num)
      end
    end while (avail1 || avail2)
  end
end

def test
  m = Mancala.new
  (1..6).each do |i|
    m.setup
    m.runthrough(0, i)
    puts i.to_s + ": " + m.slots[0].to_s
  end
  (8..13).each do |i|
    m.setup
    m.runthrough(0, i)
    puts i.to_s + ": " + m.slots[0].to_s
  end
end

def test2
  m = Mancala.new
  m.play
  puts m.slots.to_s
end

test2
