require_relative '../views/doctors_view'
require_relative '../models/doctor'

class DoctorsController
  def initialize(doctor_repository)
    @doctor_repository = doctor_repository
    @view = DoctorsView.new
  end


  def list
    # 1. Ter a lista de pacientes
    doctors = @doctor_repository.all
    # 2. Mostrar os pacientes na view
    @view.display(doctors)
  end
end
