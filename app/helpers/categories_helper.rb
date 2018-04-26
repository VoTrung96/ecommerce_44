module CategoriesHelper
  def active_current_category category
    @category.present? && @category.id == category.id ? "class=current" : ""
  end

  def init_level
    @level = 1
  end

  def add_class_multilevel
    @level += 1
    "lv#{@level}"
  end
end
