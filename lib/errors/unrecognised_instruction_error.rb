class UnrecognisedInstructionError < StandardError
  def initialize(message)
    super(message)
  end
end
