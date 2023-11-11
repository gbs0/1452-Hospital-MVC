class Router
  def initialize(patients_controller, doctors_controller, appointments_controller)
    @patients_controller = patients_controller
    @doctors_controller = doctors_controller
    @appointments_controller = appointments_controller
    @running = true
  end

  def run
    while @running
      menu
      print ">"
      input = gets.chomp.to_i
      dispatch_action(input)
    end
  end

  def dispatch_action(input)
    case input
      when 1 then @patients_controller.add
      when 2 then @patients_controller.list
      when 3 then @doctors_controller.list
      when 4 then @appointments_controller.add
      when 5 then @appointments_controller.list
      when 6 then quit!
    end
  end

  def quit!
    @running = false
  end

  def menu
    puts "---------- HSP MVC -----------"
    puts "1. Create new Patient"
    puts "2. List all Patients"
    puts "---------- Doctor's Menu --------"
    puts "3. List all Doctors"
    puts "---------- Appointment's Menu --------"
    puts "4. Create new Appointment"
    puts "5. List all Appointments"
    puts "6. Exit Program"
  end
end
