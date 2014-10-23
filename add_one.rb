require_relative 'turing'

machine do
  tape [:zero, :zero, :one, :one]

  state :s0
  state :s1
  state :h, :final

  start :s0

  # from, to, sym, write, dir
  transition :s0, :s0, :zero, :zero, :right
  transition :s0, :s0, :one, :one, :right
  transition :s0, :s1, :blank, :blank, :left

  # s1
  transition :s1, :s1, :one, :zero, :left
  transition :s1, :h, :zero, :one, :right
  transition :s1, :h, :blank, :zero, :right

  execute!

end

