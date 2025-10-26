class CountryService

  include SearchHelper
  include SortHelper

  def initialize(params = {} )
    @params = params || {}
    @countrys = Country.all.order(:name).to_a
    @target_param = params[:slug]
  end

  # create_country
  def create_country
    # name_param
    name_param = normalize_country_name
    if name_param.is_a?(Hash)
      return name_param
    end

    # check if country exists (not soft deleted)
    existing_country = Country.unscoped.find_by(name: name_param)
    if existing_country
      if existing_country.deleted?
        existing_country.restore
      end
      return { success:true, country: existing_country }
    end

    # create_country
    created_country = Country.create(
      name: name_param
    )

    if created_country
      { success: true, country: created_country }
    else
      { success: false, errors: created_country.errors.full_messages }
    end
  end

  # view single_country
  def single_country
    @country = country_slug_search(@countrys, @target_param)

    if @country.is_a?(Hash) && @country.key(:errors)
      return @country
    end

    info = @country
    if info
      { success: true, country_info: info }
    else
      { success: false, errors: @country.errors.full_messages }
    end
  end

  # view all_countrys
  def all_countrys
    @sorted_countrys = country_name_sort(@countrys)
    if @sorted_countrys.empty?
      { success: false, errors: "Empty List!"}
    else
      { success: true, countrys: @sorted_countrys}
    end
  end

  # update_country
  def update_country
    updated_country_params = {}

    @country = country_slug_search(@countrys, @target_param)
    if @country.is_a?(Hash) && @country.key?(:errors)
      return @country
    end

    # name_param
    name_param = normalize_update_country_name
    if name_param.is_a?(Hash)
      return name_param
    end
    updated_country_params[:name] = name_param

    updated_country = @country.update(updated_country_params)
    if updated_country
      { success: true, message: "Country '#{name_param}' updated successfully!"}
    else
      { success: false, errors: @country.errors.full_messages }
    end
  end

  # delete_country
  def delete_country

    @country = country_slug_search(@countrys, @target_param)
    if @country.is_a?(Hash) && @country.key?(:errors)
      return @country
    end

    country_name = @country.name
    country_delete = @country.soft_delete
    if country_delete
      { success: true, message: "Country '#{country_name}' soft deleted successfully!"}
    else
      { success: false, errors: @country.errors.full_messages }
    end
  end

  # restore_country
  def restore_country
    @country = Country.unscoped.find_by(slug: @target_param)
    
    if @country.nil?
      return { success: false, errors: { country: "Country not found!"}}
    end

    unless @country.deleted?
      return { success: false, errors: { country: "Country is not deleted!"}}
    end

    restored_country = @country.restore
    if restored_country
      { success: true, message: "Country '#{@country.name}' restored successfuly!"}
    else
      { success: false, errors: @country.errors.full_messages }
    end
  end

  private
  def normalize_country_name
    # country_name
    country_name = @params[:name].to_s.downcase

    if country_name.blank?
      return { errors: { name: "Please enter name!"}}
    end

    # # name should not exist
    # existing = country_name_search(@countrys, country_name)
    # if existing.is_a?(Hash) && existing.key?(:errors)
    #   return existing
    # end
    country_name.to_s.titleize
  end

  def normalize_update_country_name
    country_name = @params[:name].to_s.downcase
    if country_name.present?
      # should not exist
      existing = unique_country_name(@countrys, country_name, @country.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
    end
    country_name.to_s.titleize
  end
end