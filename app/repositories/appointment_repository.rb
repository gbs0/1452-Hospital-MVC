require 'csv'
require_relative '../models/appointment'

class AppointmentRepository
  def initialize(csv_file, patient_repository, doctor_repository)
    @csv_file = csv_file
    @appointments = []
    @patient_repository = patient_repository
    @doctor_repository = doctor_repository
    load_csv if File.exist?(@csv_file)
  end

  def all
    @appointments
  end

  def add(appointment)
    appointment.id = @next_id
    @appointments << appointment # Adiciona o paciente a lista
    save_csv # Salvar a lista dentro do CSV
    @next_id += 1
  end

  # Persistência de dados, logo precisamos criar uma lógica p/ carregar os dados
  # do csv
  def load_csv
    # 1. Importamos todos os dados de dentro do CSV
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |line|
      # [1, "Gabriel", 27, "false"]
      # {"id" => 1, "name"=>"Gabriel", "age"=> 27} #header_converters
      # {:id => 1, :name=>"Gabriel", :age=> 27} #header_converters
      patient = @patient_repository.find(line[:patient_id].to_i)
      doctor = @doctor_repository.find(line[:doctor_id].to_i)
      appointment = Appointment.new(id: line[:id].to_i, date: line[:date], patient: patient, doctor: doctor)
      @appointments << appointment
    end

    # 2. Qual será o próximo ID a ser inserido?
    @next_id = @appointments.empty? ? 1 : @appointments.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, "wb", headers: :first_row, header_converters: :symbol) do |row|
      row << ['id', 'date', 'patient_id', 'doctor_id']
      @appointments.each do |appointment|
        row << [appointment.id, appointment.date, appointment.patient.id, appointment.doctor.id]
      end
    end
  end


end
