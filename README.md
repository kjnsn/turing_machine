# Turing Machine program

This program allows you to define and execute small turing machines.

## Usage

Clone this repository, and then start writing your machine.

It needs the following skeleton:

    require_relative 'turing'

    machine do

      execute!
    end

You need to define at least one state, a start state, and a tape.

Have a look at the example `add_one.rb` to work out how to define a machine.

To run your program go `ruby your_program.rb`.

## Limitations

Unfortunately real computers are memory limited, so this isn't a universial turing machine.

There are only 100 spaces to the left of the input tape, so it might be better to put your
infinite loops spiralling off to the right.


