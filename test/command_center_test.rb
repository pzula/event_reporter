require 'minitest'
require 'minitest/autorun'
require './lib/command_center'

class CommandCenterTest < Minitest::Test

  def test_it_exists
    robot = CommandCenter.new
    assert_kind_of CommandCenter, robot
  end

  def test_it_takes_quit_command_and_quits
    input = "quit"
    robot = CommandCenter.new
    assert_equal input, robot.command
  end

end