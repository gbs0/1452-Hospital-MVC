class AppointmentsView
  # Mostrar a lista de pacientes
  def display(appointments)
    appointments.each do |appointment|
      puts "- ID: #{appointment.id} | #{appointment.date} | P: #{appointment.patient.name}| D: #{appointment.doctor.name} | #{appointment.doctor.specialty}"
    end
  end

  def ask_for(info)
    puts "What's the appointment's #{info}?"
    gets.chomp
  end
end
