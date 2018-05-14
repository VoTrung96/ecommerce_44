module Admin
  class ImportProductsController < AdminController
    def new; end

    def create
      file = open_spreadsheet params[:file]
      if file
        Product.import file
        flash[:success] = t "flash.import_success"
        redirect_to admin_products_path
      else
        flash.now[:danger] = t "flash.danger"
        render :new
      end
    end

    private

    def open_spreadsheet file
      return unless file
      case File.extname(file.original_filename)
      when ".csv"
        Roo::Csv.new(file.path, file_warning: :ignore)
      when ".xls"
        Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx"
        Roo::Excelx.new(file.path, file_warning: :ignore)
      end
    end
  end
end
