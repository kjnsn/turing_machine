# Defines a turing machine
#
# Usage:
# machine do
#
#   state :s0
#   state :s1
#   state :s2
#   state :sf, :final
#
#   start :s0
#
#   # (from, to, symbol, write, direction)
#   # from and to need to be states
#   # the symbol can be anything defined or :blank
#   # write is what symbol to write on the current position
#   # direction is one of :left or :right or :stay
#   trans :s0, :s0, :one, :one, :left
#
#   tape [:one, :one, :one, :one, :zero]
#
#   execute!
# end
#

class Machine
  def initialize
    @states = {}
    @finals = []
  end

  def state(s, final = :no)
    @finals << s if final == :final
    @states[s] = {}
  end

  def start(s)
    @start = s
  end

  def transition(from, to, sym, write, dir)

    # each entry in the state arc list is a map
    # :s0 => {:sym => [to, write, dir]}
    @states[from][sym] = [to, write, dir]
  end

  def tape(list)
    # hack to give extra space at the left (100 spaces)
    @tape ||= Array.new(100, :blank)
    @tape.concat(list)
  end

  def execute!
    raise "no start state" unless defined?(@start)
    raise "no final states" if @finals.empty?

    current_state = @start
    position = 100

    while true

      @tape[position] = :blank if @tape[position].nil?

      if @finals.include?(current_state) and not @states[current_state][@tape[position]]
        puts "input accepted"

        # find the first non-blank space on the left
        leftmost = 0
        @tape.each {|x| leftmost += 1 if x == :blank }

        puts "tape: #{@tape.slice(leftmost, @tape.length)}"
        return
      end

      raise "input rejected" unless @states[current_state][@tape[position]]

      # transition
      puts "current_state: #{current_state}, read: #{@tape[position]}"
      arc = @states[current_state][@tape[position]]
      current_state = arc[0]
      @tape[position] = arc[1]
      arc[2] == :left ? position -= 1 : position += 1
      
      puts "going to: #{current_state}, wrote: #{arc[1]}, going: #{arc[2]}"
    end
  end

end

def machine(&block)
  m = Machine.new
  m.instance_eval(&block)
end

