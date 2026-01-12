require "csv"

namespace :exercises do
  desc "Import exercises from CSV"
  task import: :environment do
    file_path = Rails.root.join("megaGymDataset.csv")

    CSV.foreach(file_path, headers: true).with_index do |row, index|
      Exercise.find_or_create_by!(name: row["Title"]) do |e|
        e.description = row["Desc"]
        e.exercise_type = row["Type"]
        e.body_part = row["BodyPart"]
        e.equipment = row["Equipment"]
      end
      print "." if index % 100 == 0
    end
    puts "\nImport completed!"
  end
end
