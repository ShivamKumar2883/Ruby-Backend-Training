require 'csv'

namespace :import do
  # Conference Modes
  task conference_modes: :environment do
    file_path = Rails.root.join('private/master_tables/conference_modes.csv')
    CSV.foreach(file_path, headers: true) do |row|
      ConferenceMode.find_or_create_by!(id: row['id']) do |record|
        record.name = row['name']
      end
    end
    puts "Conference modes imported successfully"
  end

  # Badges
  task badges: :environment do
    file_path = Rails.root.join('private/master_tables/badges.csv')
    CSV.foreach(file_path, headers: true) do |row|
      Badge.find_or_create_by!(id: row['id']) do |record|
        record.badge_name = row['badge_name']
        record.badge_type = row['badge_type']
      end
    end
    puts "Badges imported successfully"
  end

  # Enquire Types
  task enquire_type: :environment do
    file_path = Rails.root.join('private/master_tables/enquire_types.csv')
    CSV.foreach(file_path, headers: true) do |row|
      EnquireType.find_or_create_by!(id: row['id']) do |record|
        record.name = row['name']
      end
    end
    puts "Enquire types imported successfully"
  end

  # Conference Categories
  task conference_categories: :environment do
    file_path = Rails.root.join('private/master_tables/conference_categories.csv')
    CSV.foreach(file_path, headers: true) do |row|
      ConferenceCategory.find_or_create_by!(id: row['id']) do |record|
        record.name = row['name']
        if row['conferences_id'].present? && Conference.exists?(row['conferences_id'])
        record.conferences_id = row['conferences_id']
      end
    end
    end
    puts "Conference categories imported successfully"
  end

  # States
  task states: :environment do
    file_path = Rails.root.join('private/master_tables/states.csv')
    CSV.foreach(file_path, headers: true) do |row|
      State.find_or_create_by!(id: row['id']) do |record|
        record.name = row['name']
      end
    end
    puts "States imported successfully"
  end

  # Districts
  task districts: :environment do
    file_path = Rails.root.join('private/master_tables/districts.csv')
    CSV.foreach(file_path, headers: true) do |row|
      District.find_or_create_by!(id: row['id']) do |record|
        record.name = row['name']
      end
    end
    puts "Districts imported successfully"
  end

end