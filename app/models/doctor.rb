class Doctor
  attr_reader :name, :specialty
  attr_accessor :id
  
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @specialty = attributes[:specialty]
  end
end
