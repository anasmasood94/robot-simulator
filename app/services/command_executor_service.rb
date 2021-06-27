class CommandExecutorService
  VALID_COMMANDS = ["MOVE", "LEFT", "RIGHT", "REPORT"]

  def initialize(commands=[])
    @commands = commands
    @simulator = RobotSimulatorService.new
  end

  def execute
    results = []
    @commands.each do |command|
      next unless is_command_valid? command

      if command.include? "PLACE"
        result = command.split("(").last.split(")").first.split(",")
        @simulator.place(result[0].to_i, result[1].to_i, result[2].strip)

      else
        result = @simulator.send(command.downcase)
        results.push(result) if command == "REPORT"
      end
    end

    results
  end

  private
    def is_command_valid? command
      VALID_COMMANDS.include?(command) || command.include?("PLACE")
    end
end
