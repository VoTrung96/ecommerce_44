module Admin
  module ProductsHelper
    def add_input_file field_for
      link_to "javascript:void(0)", class: "input-plus",
        onclick: "do_render(#{render_input(field_for).dump})" do
        content_tag :i, "", class: "fa fa-plus"
      end
    end

    def add_input_file_update_form
      input_counter = counter
      link_to "javascript:void(0)", class: "input-plus input-plus-update", onclick:
        "render_update(#{render_input_update_form(input_counter).dump}, #{input_counter})" do
        content_tag :i, "", class: "fa fa-plus"
      end
    end

    def render_images product, field_for, counter
      return if product.images.blank? || product.images[counter].name.blank?
      images = []
      images << "<div class=\"myFile\">".html_safe
      images << link_to("x", "javascript:void(0)", class: "remove")
      images << image_tag(product.images[counter].name.url, size: "100x100")
      images << field_for.file_field(:name, onchange: "previewImage(this)")
      images << field_for.hidden_field(:_destroy, class: "destroy")
      images << "</div>".html_safe
      safe_join images
    end

    def counter
      @counter ||= -1
      @counter += 1
    end

    private

    def render_input field_for
      render partial: "admin/products/input_file", locals: {f: field_for}
    end

    def render_input_update_form counter
      render partial: "admin/products/input_file_update", locals: {counter: counter}
    end
  end
end
