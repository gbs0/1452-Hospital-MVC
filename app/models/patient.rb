class Patient
  attr_reader :name, :age, :cured
  attr_accessor :id

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @age = attributes[:age]
    @cured = attributes[:cured] || "false"
  end

  def cure!
    @cured = "true"
  end
end
