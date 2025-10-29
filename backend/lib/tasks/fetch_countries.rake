require 'net/http'
require 'json'

namespace :countries do
  desc "Fetch and save countries (with flags) from RestCountries API"
  task fetch: :environment do
    puts "🌍 Fetching countries from RestCountries API..."

    url = URI("https://restcountries.com/v3.1/all?fields=name,cca2,idd,flags")
    response = Net::HTTP.get(url)
    countries = JSON.parse(response)

    countries.each do |country|
      # Skip if the current item is not a Hash
      unless country.is_a?(Hash)
        puts "⚠️ Skipping invalid country entry: #{country.inspect}"
        next
      end

      # Safely extract details
      name = country.dig("name", "common")
      iso_code = country["cca2"]
      phone_root = country.dig("idd", "root") || ""
      phone_suffix = (country.dig("idd", "suffixes") || []).first || ""
      phone_code = "#{phone_root}#{phone_suffix}"
      flag_url = country.dig("flags", "png") || country.dig("flags", "svg")

      # Skip if no valid name
      next if name.blank?

      # Initialize or update the country record
      country_record = Country.unscoped.find_or_initialize_by(name: name)
      country_record.assign_attributes(
        iso_code: iso_code,
        phone_code: phone_code,
        flag_url: flag_url,
        slug: name.parameterize
      )

      if country_record.save
        puts "✅ Saved: #{name} (#{iso_code})"
      else
        puts "❌ Failed to save #{name}: #{country_record.errors.full_messages.join(', ')}"
      end
    end

    puts "🎉 All valid countries have been fetched and saved successfully!"
  end
end
