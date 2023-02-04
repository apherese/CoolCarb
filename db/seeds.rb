# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Company.destroy_all
User.destroy_all
Task.destroy_all
Footprint.destroy_all

aigle_noir = Company.create!({ name: "Aigle Noir", industry: "Hôtel", employee_nb: 15, kwh: 150_000, square_meter: 1_000 })
hotel_plage = Company.create!({ name: "La Plage", industry: "Hôtel", employee_nb: 5, kwh: 50_000, square_meter: 300 })
metropol = Company.create!({ name: "Metropol", industry: "Hôtel", employee_nb: 100, kwh: 2_150_000, square_meter: 5_000 })
radisson = Company.create!({ name: "Radisson", industry: "Hôtel", employee_nb: 50, kwh: 1_150_000, square_meter: 3_000 })

jeanpierre = User.create!({ name: "Jean-Pierre", position: "DFI", email: "jeanpierre@gmail.com", company: aigle_noir, password: "azerty", admin: true })
mohamed = User.create!({ name: "Mohamed", position: "CEO", email: "mohamed@gmail.com", company: hotel_plage, password: "azerty", admin: true })
amine = User.create!({ name: "Amine", position: "DRSE", email: "amine@gmail.com", company: metropol, password: "azerty", admin: true })
nathanael = User.create!({ name: "Nathanaël", position: "CLO", email: "nathanael@gmail.com", company: radisson, password: "azerty", admin: true })

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
