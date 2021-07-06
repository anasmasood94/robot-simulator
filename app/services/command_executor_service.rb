class CommandExecutorService
  VALID_COMMANDS = ["MOVE", "LEFT", "RIGHT", "REPORT"]

  def initialize(commands=[])
    @commands = commands
    @simulators = {}
  end

  def execute
    results = []
    @commands.each do |command|
      robot = command.split(" ").first
      command = command.gsub(Regexp.new(robot), '').strip
      next unless is_command_valid? command

      simulator = robot_simulator(robot.to_sym)
      report = simulator.simulate(command)

      if validate(report, robot.to_sym)
        if command.include? "PLACE"
          result = command.split("(").last.split(")").first.split(",")
          simulator.place(result[0].to_i, result[1].to_i, result[2].strip)

        else
          result = simulator.send(command.downcase)
          results.push("#{robot} #{result}") if command == "REPORT"
        end
      end
    end

    results
  end

  private
    def robot_simulator(key)
      @simulators[key] ||= RobotSimulatorService.new
    end

    def validate result, current_robot
      return true if @simulators.keys.length < 2

      results = @simulators.map do |key, simulator|
        simulator.report if key != current_robot
      end

      results.select { |r| r == result }.length < 1
    end

    def is_command_valid? command
      VALID_COMMANDS.include?(command) || command.include?("PLACE")
    end
end
