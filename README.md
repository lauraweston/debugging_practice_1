# Debugging practice

You can use this exercise to practice and assess your debugging skill.

## Instructions

The goal is to get all the tests in the `spec/` directory passing.

1. Fork this repo.

2. Clone your fork to your machine.

3. Install the dependencies by running `bundle` in the root of the repo.

4. Run the tests by running `rspec` in the root of the repo.

5. Get all the tests in `spec/` passing.

6. To help you debug, feel free to add more tests.

7. To check that your debugged code will be assessed as correctly debugged by Travis, run `rake verify`.  This runs a clean version of the tests.  If all these tests pass, you've successfully debugged the repo.

8. Make a pull request to this repo to submit your solution to the exercise.

## Note

* Don't change the files in the `.spec_verify/` directory.

## Run the project

If you need to run the project, start IRB and type in:

```ruby
require_relative("./blackjack/command_line_interface")

cli = CommandLineInterface.new(STDIN, STDOUT, Game.new)
cli.play
```
