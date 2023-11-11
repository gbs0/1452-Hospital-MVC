# !. Etapa de Inicio do programa
# Todos os arquivos relativos ao MVC
require_relative 'router'

# 2. Os Repositórios
require_relative 'app/repositories/patient_repository'
require_relative 'app/repositories/doctor_repository'
require_relative 'app/repositories/appointment_repository'
# 3. Os Controllers
require_relative 'app/controllers/patients_controller'
require_relative 'app/controllers/doctors_controller'
require_relative 'app/controllers/appointments_controller'

# 4. Iniciarmos as classes
patient_repository = PatientRepository.new('data/patients.csv')
doctor_repository = DoctorRepository.new('data/doctors.csv')
appointment_repository = AppointmentRepository.new('data/appointments.csv', patient_repository, doctor_repository)

patients_controller = PatientsController.new(patient_repository)
doctors_controller = DoctorsController.new(doctor_repository)
appointments_controller = AppointmentsController.new(appointment_repository, patient_repository, doctor_repository)

app = Router.new(patients_controller, doctors_controller, appointments_controller)
# 5. Inicia o app
app.run
