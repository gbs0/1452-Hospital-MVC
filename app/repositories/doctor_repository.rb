require 'csv'
require_relative "../models/doctor"


class DoctorRepository

  def initialize(csv_file)
    @csv_file = csv_file
    @doctors = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @doctors
  end

  def add(doctor)
    doctor.id = @next_id
    @doctors << doctor # Adiciona o paciente a lista
    save_csv # Salvar a lista dentro do CSV
    @next_id += 1
  end

  def find(id) # 1
    # Precisamos retornar a instância escolhida pelo ID
    @doctors.select { |doctor| doctor.id == id }.first
    #[
    # <000x000b Patient id: 1, name: "Gabriel", age: 27>
    # <000x000b Patient id: 2, name: "Fernando", age: 34>
    # ]
    # Retorno: #[<000x000b Patient id: 1, name: "Gabriel", age: 27>]
    # Ao fazer .first, tiramos a instância de dentro da array
    # Retorno: <000x000b Patient id: 1, name: "Gabriel", age: 27>
  end

  # Persistência de dados, logo precisamos criar uma lógica p/ carregar os dados
  # do csv
  def load_csv
    # 1. Importamos todos os dados de dentro do CSV
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |line|
      # [1, "Gabriel", 27, "false"]
      # {"id" => 1, "name"=>"Gabriel", "age"=> 27} #header_converters
      # {:id => 1, :name=>"Gabriel", :age=> 27} #header_converters
      doctor = Doctor.new(id: line[:id].to_i, name: line[:name], specialty: line[:specialty])
      # De texto CSV, convertemos p/ instância, temos que adicionar o paciente na lista em memória
      @doctors << doctor
    end

    # 2. Qual será o próximo ID a ser inserido?
    @next_id = @doctors.empty? ? 1 : @doctors.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, "wb", headers: :first_row, header_converters: :symbol) do |row|
      row << ['id', 'name', 'specialty']
      @doctors.each do |doctor|
        row << [doctor.id, doctor.name, doctor.specialty]
      end
    end
  end
end
