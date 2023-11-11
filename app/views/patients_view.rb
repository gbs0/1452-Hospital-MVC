class PatientsView
  # Mostrar a lista de pacientes
  def display(patients)
    patients.each do |patient|
      puts "- ID: #{patient.id} | Name: #{patient.name} | #{patient.age} years | Cured?: #{patient.cured}"
    end
  end

  def ask_for(info)
    puts "What's the patient's #{info}?"
    gets.chomp
  end
end
