require "test_helper"

class CommandExecutorServiceTest < ActiveSupport::TestCase
  def test_service_returns_correct_answer
    commands = ["PLACE(0, 0, NORTH)", "MOVE", "MOVE", "REPORT"]
    service = CommandExecutorService.new(commands)
    assert_equal(service.execute, ["0, 2, NORTH"])
  end

  def test_service_returns_multipe_results
    commands = ["PLACE(0, 0, NORTH)", "MOVE", "MOVE", "REPORT", "LEFT", "REPORT"]
    service = CommandExecutorService.new(commands)
    assert_equal(service.execute, ["0, 2, NORTH", "0, 2, WEST"])
  end

  def test_service_does_not_run_invalid_commands
    commands = ["PLACE(0, 0, NORTH)", "GO", "UP", "REPORT"]
    service = CommandExecutorService.new(commands)
    assert_equal(service.execute, ["0, 0, NORTH"])
  end
end
