require "test_helper"

class SimulatorControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_root
    get root_url
    assert_response :success
  end

  def test_should_post_simulate
    post simulate_simulator_index_url,
      params: { commands: ["PLACE(0, 2, NORTH)", "MOVE", "MOVE", "MOVE", "REPORT"].to_s}
    assert_response :success
  end
end
