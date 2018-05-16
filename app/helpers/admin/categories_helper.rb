module Admin
  module CategoriesHelper
    def init_lv
      @lv ||= 0
    end

    def add_level
      "- " * @lv
    end

    def addition_lv
      @lv += 1
    end

    def sub_lv
      @lv -= 1
    end

    def show_select_categories
      option = [[t("admin.categories.no_parent"), Settings.category.no_parent]]
      @categories.collect{|item| option << [item.name, item.id]}
      option
    end
  end
end
