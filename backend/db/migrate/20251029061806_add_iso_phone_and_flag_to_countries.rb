class AddIsoPhoneAndFlagToCountries < ActiveRecord::Migration[8.0]
  def change
    add_column :countries, :iso_code, :string
    add_column :countries, :phone_code, :string
    add_column :countries, :flag_url, :string
  end
end
