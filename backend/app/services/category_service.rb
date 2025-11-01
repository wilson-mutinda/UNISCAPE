class CategoryService

  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @categories = Category.all.order(:id).to_a
    @target_param = params[:slug]
  end
  # create_category
  def create_category
    # name_param
    name_param = normalize_category_name
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # create_category
    created_category = Category.create(
      name: name_param
    )

    if created_category
      { success: true, message: "Category '#{name_param}' created successfully!"}
    else
      { success: false, errors: created_category.errors.full_messages }
    end
  end

  # view single_category
  def single_category
    @cat = category_search_by_slug(@categories, @target_param)
    if @cat.is_a?(Hash) && @cat.key?(:errors)
      return @cat
    end

    info = @cat
    if info
      { success: true, category_info: @cat}
    else
      { success: false, errors: @cat.errors.full_messages }
    end
  end

  # view all_categories
  def all_categories
    categories = @categories
    if categories.empty?
      { success: false, errors: "Empty List!"}
    else
      { success: true, info: categories}
    end
  end

  # update_category
  def update_category
    @cat = category_search_by_slug(@categories, @target_param)
    if @cat.is_a?(Hash) && @cat.key?(:errors)
      return @cat
    end

    # name_param
    name_param = normalize_update_category_name
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # update_name
    updated_name = @cat.update(
      name: name_param
    )

    if updated_name
      { success: true, message: "Category updated successfully!", info: @cat}
    else
      { success: false, errors: @cat.errors.full_messages }
    end
  end

  # delete_category
  def delete_category
    @cat = category_search_by_slug(@categories, @target_param)
    if @cat.is_a?(Hash) && @cat.key?(:errors)
      return @cat
    end

    # soft_delete
    category_name = @cat.name
    category_delete = @cat.soft_delete

    if category_delete
      { success: true, message: "Category '#{category_name}' deleted successfully!"}
    else
      { success: false, errors: @cat.errors.full_messages }
    end
  end

  # restore_category
  def restore_category
    @category = Category.unscoped.find_by(slug: @target_param)
    if @category.nil?
      return  { success: false, errors: { category: "Category not found!"}}
    end

    unless @category.category_deleted?
      return { success: false, errors: { category: "Category is not deleted!"}}
    end

    restored_category = @category.restore
    if restored_category
      { success: true, message: "Category '#{@category.name}' restored successfully!"}
    else
      { success: false, errors: @category.errors.full_messages }
    end
  end

  private
  def normalize_category_name
    name = @params[:name].to_s.downcase
    if name.blank?
      return { errors: { name: "Please input category name!"}}
    end
    name.titleize
  end

  def normalize_update_category_name
    name = @params[:name].to_s.downcase
    if name.present?
      # name should not exist
      existing = category_name_search(@categories, name, @cat.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
      name.titleize
    end
  end
end