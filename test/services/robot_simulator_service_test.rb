require "test_helper"

class RobotSimulatorServiceTest < ActiveSupport::TestCase
  setup do
    @service = RobotSimulatorService.new
  end

  def test_reports_nothing_when_intialized_without_params
    assert_nil @service.report
  end

  def test_place_work_correctly
    @service.place(1, 3, "NORTH")
    assert_equal(@service.report, "1, 3, NORTH")
  end

  def test_place_does_not_set_if_direction_is_wrong
    @service.place(1, 3, "NORTH1")
    assert_nil @service.report
  end

  def test_place_does_not_set_if_coordintates_is_wrong
    @service.place(-1, -3, "NORTH")
    assert_nil @service.report
  end

  def test_left_updates_direction_correctly
    @service.place(1, 3, "NORTH")
    @service.left
    assert_equal(@service.report, "1, 3, WEST")
  end

  def test_right_updates_direction_correctly
    @service.place(1, 3, "NORTH")
    @service.right
    assert_equal(@service.report, "1, 3, EAST")
  end

  def test_move_moves_in_correct_direcction
    @service.place(1, 3, "NORTH")
    @service.move
    assert_equal(@service.report, "1, 4, NORTH")

    @service.left
    @service.move
    assert_equal(@service.report, "0, 4, WEST")
  end

  def test_move_does_not_update_position_if_end_of_table
    @service.place(0, 0, "SOUTH")
    @service.move
    assert_equal(@service.report, "0, 0, SOUTH")
  end

  def test_initialize_set_coordinates_and_direction_correctly
    service = RobotSimulatorService.new(0, 3, "EAST")
    assert_equal(service.report, "0, 3, EAST")
  end
end
