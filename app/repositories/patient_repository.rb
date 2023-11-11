require 'csv'
require_relative "../models/patient"
require 'pry'

class PatientRepository

  def initialize(csv_file)
    @csv_file = csv_file
    @patients = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @patients
  end

  def add(patient)
    patient.id = @next_id
    @patients << patient # Adiciona o paciente a lista
    save_csv # Salvar a lista dentro do CSV
    @next_id += 1
  end

  def find(id) # 1
    # Precisamos retornar a instância escolhida pelo ID
    @patients.select { |patient| patient.id == id }.first
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
      patient = Patient.new(id: line[:id].to_i, name: line[:name], age: line[:age].to_i, cured: line[:cured])
      # De texto CSV, convertemos p/ instância, temos que adicionar o paciente na lista em memória
      @patients << patient
    end

    # 2. Qual será o próximo ID a ser inserido?
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, "wb", headers: :first_row, header_converters: :symbol) do |row|
      row << ['id', 'name', 'age', 'cured']
      @patients.each do |patient|
        row << [patient.id, patient.name, patient.age, patient.cured]
      end
    end
  end
end
