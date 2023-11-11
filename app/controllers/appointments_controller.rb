require_relative "../views/appointments_view"
require_relative "../views/patients_view"
require_relative "../views/doctors_view"
require_relative "../models/appointment"

class AppointmentsController
  def initialize(appointment_repository, patient_repository, doctor_repository)
    @appointment_repository = appointment_repository
    @patient_repository = patient_repository
    @doctor_repository = doctor_repository
    @view = AppointmentsView.new
    @patient_view = PatientsView.new
    @doctors_view = DoctorsView.new
  end

  # Para adicionar uma nova consulta
  def add
    # 1. Perguntar ao usuário, qual o ID paciente ele deseja escolher
    puts "Choose a patient:"
    patients = @patient_repository.all
    @patient_view.display(patients)
    print "> "
    patient_id = gets.chomp.to_i
    # 1.1 Precisamos assimilar o paciente a consulta
    patient = @patient_repository.find(patient_id)

    # 2. Perguntar ao usuário, qual o médico ele deseja escolher
    puts "Choose a doctor:"
    doctors = @doctor_repository.all
    @doctors_view.display(doctors)
    print "> "
    doctor_id = gets.chomp.to_i
    # 2.1 Precisamos assimilar o doutor a consulta
    doctor = @doctor_repository.find(doctor_id)

    # 3. Perguntar qual a data da consulta
    date = @view.ask_for("date")

    # 4. Criamos uma consulta p/ receber as informações
    appointment = Appointment.new(date: date, patient: patient, doctor: doctor)

    # 5. Salvamos a consulta no repostório
    @appointment_repository.add(appointment)
  end

  def list
    appointments = @appointment_repository.all
    @view.display(appointments)
  end
end
