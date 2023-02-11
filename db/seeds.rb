# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# avec Rest-Client (marche aussi)
# require "json"
# require "rest-client"
# url = "https://data.ademe.fr/data-fair/api/v1/datasets/bilans-ges/values_agg?field=APE(NAF)&metric=avg&metric_field=Emissions_publication_P1_-_tCO2e&qs=5510Z"
# benchmark_serialized = RestClient.get(url)
# benchmark = JSON.parse(benchmark_serialized)

# Seed the benchmark of hotels avec open URI
require "json"

Task.destroy_all
Footprint.destroy_all
User.destroy_all
Company.destroy_all


# require "open-uri"

# moyenne du secteur des hôtels du Poste P1
# url = "https://data.ademe.fr/data-fair/api/v1/datasets/bilans-ges/values_agg?field=APE(NAF)&metric=avg&metric_field=Emissions_publication_P1_-_tCO2e&qs=5510Z"
# benchmark_serialized = URI.open(url).read
# benchmark_mean = JSON.parse(benchmark_serialized)
# p benchmark_mean

# url = "https://data.ademe.fr/data-fair/api/v1/datasets/bilans-ges/lines?select=Raison_sociale_%2F_Nom_de_l'entit%C3%A9%2CAnn%C3%A9e_de_reporting%2CNombre_de_salari%C3%A9s_%2F_d'agents%2CAPE(NAF)%2CEmissions_publication_P1_-_tCO2e%2CEmissions_publication_P2_-_tCO2e%2CEmissions_publication_P3_-_tCO2e%2CEmissions_publication_P4_-_tCO2e%2CEmissions_publication_P5_-_tCO2e%2CEmissions_publication_P6_-_tCO2e%2CEmissions_publication_P7_-_tCO2e%2CEmissions_publication_P8_-_tCO2e%2CEmissions_publication_P9_-_tCO2e%2CEmissions_publication_P10_-_tCO2e%2CEmissions_publication_P11_-_tCO2e%2CEmissions_publication_P12_-_tCO2e%2CEmissions_publication_P13_-_tCO2e%2CEmissions_publication_P14_-_tCO2e%2CEmissions_publication_P15_-_tCO2e%2CEmissions_publication_P16_-_tCO2e%2CEmissions_publication_P17_-_tCO2e%2CEmissions_publication_P18_-_tCO2e%2CEmissions_publication_P19_-_tCO2e%2CEmissions_publication_P20_-_tCO2e%2CEmissions_publication_P21_-_tCO2e%2CEmissions_publication_P22_-_tCO2e%2CEmissions_publication_P23_-_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_1_-_en_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_2_-_en_tCO2e%2CVolume_de_r%C3%A9duction_attendu_-_Scope_3_-_en_tCO2e%2CPlan_d'actions_-_Scope_1%2CPlan_d'actions_-_Scope_2%2CPlan_d'actions_-_Scope_3&qs=5510Z"
# list_hotel_serialized = URI.open(url).read
=begin
filepath = "data/ademe_data.json"
data = File.read(filepath)
list_data = JSON.parse(data)["results"]
list_data.each do |el|
  hotel_parameter = {
    name: el["Raison_sociale_/_Nom_de_l'entité"],
    industry: "Hôtel",
    employee_nb: el["Nombre_de_salariés_/_d'agents"]
  }

  company = Company.create(hotel_parameter)

  scope_1 = el["Emissions_publication_P1_-_tCO2e"] + el["Emissions_publication_P2_-_tCO2e"]
  footprint_parameter = {
    ghg_result: {
    scope_1: scope_1
    },
    company_id: company.id
  }

 Footprint.create(footprint_parameter)

end
=end

aigle_noir = Company.create!({ name: "Aigle Noir", industry: "Hôtel", employee_nb: 15, kwh: 150_000, square_meter: 1_000 })
hotel_plage = Company.create!({ name: "La Plage", industry: "Hôtel", employee_nb: 5, kwh: 50_000, square_meter: 300 })
metropol = Company.create!({ name: "Metropol", industry: "Hôtel", employee_nb: 100, kwh: 2_150_000, square_meter: 5_000 })
radisson = Company.create!({ name: "Radisson", industry: "Hôtel", employee_nb: 50, kwh: 1_150_000, square_meter: 3_000 })

jeanpierre = User.create!({ name: "Jean-Pierre", position: "DFI", email: "jeanpierre@gmail.com", company: aigle_noir, password: "azerty", admin: true })
mohamed = User.create!({ name: "Mohamed", position: "CEO", email: "mohamed@gmail.com", company: hotel_plage, password: "azerty", admin: true })
amine = User.create!({ name: "Amine", position: "DRSE", email: "amine@gmail.com", company: metropol, password: "azerty", admin: true })
nathanael = User.create!({ name: "Nathanaël", position: "CLO", email: "nathanael@gmail.com", company: radisson, password: "azerty", admin: true })

employee_1_1 = User.create!({ name: "Claire", position: "CEO", email: "claire@gmail.com", company: aigle_noir, password: "azerty", admin: false })
employee_1_2 = User.create!({ name: "Margot", position: "DRSE", email: "margot@gmail.com", company: aigle_noir, password: "azerty", admin: false })
employee_1_3 = User.create!({ name: "Fred", position: "DSI", email: "fred@gmail.com", company: aigle_noir, password: "azerty", admin: false })
employee_1_4 = User.create!({ name: "Iris", position: "Chef", email: "iris@gmail.com", company: aigle_noir, password: "azerty", admin: false })
employee_1_5 = User.create!({ name: "Luc", position: "Commis", email: "luc@gmail.com", company: aigle_noir, password: "azerty", admin: false })
employee_1_6 = User.create!({ name: "Flora", position: "CPO", email: "flora@gmail.com", company: aigle_noir, password: "azerty", admin: false })

employee_2_1 = User.create!({ name: "Claire", position: "CEO", email: "claire@gmail.com", company: hotel_plage, password: "azerty", admin: false })
employee_2_2 = User.create!({ name: "Margot", position: "DRSE", email: "margot@gmail.com", company: hotel_plage, password: "azerty", admin: false })
employee_2_3 = User.create!({ name: "Fred", position: "DSI", email: "fred@gmail.com", company: hotel_plage, password: "azerty", admin: false })
employee_2_4 = User.create!({ name: "Iris", position: "Chef", email: "iris@gmail.com", company: hotel_plage, password: "azerty", admin: false })
employee_2_5 = User.create!({ name: "Luc", position: "Commis", email: "luc@gmail.com", company: hotel_plage, password: "azerty", admin: false })
employee_2_6 = User.create!({ name: "Flora", position: "CPO", email: "flora@gmail.com", company: hotel_plage, password: "azerty", admin: false })

employee_3_2 = User.create!({ name: "Margot", position: "DRSE", email: "margot@gmail.com", company: metropol, password: "azerty", admin: false })
employee_3_3 = User.create!({ name: "Fred", position: "DSI", email: "fred@gmail.com", company: metropol, password: "azerty", admin: false })
employee_3_4 = User.create!({ name: "Iris", position: "Chef", email: "iris@gmail.com", company: metropol, password: "azerty", admin: false })
employee_3_5 = User.create!({ name: "Luc", position: "Commis", email: "luc@gmail.com", company: metropol, password: "azerty", admin: false })
employee_3_6 = User.create!({ name: "Flora", position: "CPO", email: "flora@gmail.com", company: metropol, password: "azerty", admin: false })

employee_4_1 = User.create!({ name: "Claire", position: "CEO", email: "claire@gmail.com", company: radisson, password: "azerty", admin: false })
employee_4_2 = User.create!({ name: "Margot", position: "DRSE", email: "margot@gmail.com", company: radisson, password: "azerty", admin: false })
employee_4_3 = User.create!({ name: "Fred", position: "DSI", email: "fred@gmail.com", company: radisson, password: "azerty", admin: false })
employee_4_4 = User.create!({ name: "Iris", position: "Chef", email: "iris@gmail.com", company: radisson, password: "azerty", admin: false })
employee_4_5 = User.create!({ name: "Luc", position: "Commis", email: "luc@gmail.com", company: radisson, password: "azerty", admin: false })
employee_4_6 = User.create!({ name: "Flora", position: "CPO", email: "flora@gmail.com", company: radisson, password: "azerty", admin: false })

footprint1 = Footprint.create!({ company: aigle_noir, ghg_result: 95, step: "Simulation", certified: false, date: "2023-02-01" })
footprint2 = Footprint.create!({ company: hotel_plage, ghg_result: 50, step: "Simulation", certified: false, date: "2023-02-01" })
footprint3 = Footprint.create!({ company: metropol, ghg_result: 500, step: "Simulation", certified: false, date: "2023-02-01" })
footprint4 = Footprint.create!({ company: radisson, ghg_result: 300, step: "Simulation", certified: false, date: "2023-02-01" })

task1_1 = Task.create!({ name: "chauffage", footprint: footprint1, ghg_contribution: 20, owner: jeanpierre })
task1_2 = Task.create!({ name: "isolation", footprint: footprint1, ghg_contribution: 15, owner: jeanpierre })
task1_3 = Task.create!({ name: "cycle court", footprint: footprint1, ghg_contribution: 25, owner: jeanpierre })

task2_1 = Task.create!({ name: "chauffage", footprint: footprint2, ghg_contribution: 20, owner: mohamed })
task2_2 = Task.create!({ name: "isolation", footprint: footprint2, ghg_contribution: 15, owner: mohamed })
task2_3 = Task.create!({ name: "cycle court", footprint: footprint2, ghg_contribution: 25, owner: mohamed })

task3_1 = Task.create!({ name: "chauffage", footprint: footprint3, ghg_contribution: 20, owner: amine })
task3_2 = Task.create!({ name: "isolation", footprint: footprint3, ghg_contribution: 15, owner: amine })
task3_3 = Task.create!({ name: "cycle court", footprint: footprint3, ghg_contribution: 25, owner: amine })

task4_1 = Task.create!({ name: "chauffage", footprint: footprint4, ghg_contribution: 20, owner: nathanael })
task4_2 = Task.create!({ name: "isolation", footprint: footprint4, ghg_contribution: 15, owner: nathanael })
task4_3 = Task.create!({ name: "cycle court", footprint: footprint4, ghg_contribution: 25, owner: nathanael })
