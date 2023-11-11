require_relative '../views/patients_view'
require_relative '../models/patient'

class PatientsController
  def initialize(patient_repository)
    @patient_repository = patient_repository
    @view = PatientsView.new
  end

  def add
    # 1. Perguntar o nome do paciente
    name = @view.ask_for("name")
    # 2. Perguntar a idade do paciente
    age = @view.ask_for("age").to_i
    # 3. Criar uma instância de paciente
    patient = Patient.new(name: name, age: age)

    # 4. Adicionamos o paciente novo ao repositório
    @patient_repository.add(patient)
  end

  def list
    # 1. Ter a lista de pacientes
    patients = @patient_repository.all
    # 2. Mostrar os pacientes na view
    @view.display(patients)
  end
end
