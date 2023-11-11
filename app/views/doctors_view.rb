class DoctorsView
  # Mostrar a lista de pacientes
  def display(doctors)
    doctors.each do |doctor|
      puts "- ID: #{doctor.id} | Name: #{doctor.name} | #{doctor.specialty} specialty"
    end
  end
end
