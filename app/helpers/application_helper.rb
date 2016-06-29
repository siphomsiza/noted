module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "KEYSTONE App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |subdepartments_for_form|
      render(association.to_s.singularize + "_fields", f: subdepartments_for_form)
    end
    link_to(name, '', class: "btn add_fields btn-mini", data: { id: id, fields: fields.gsub("\n", "")})
  end

  def sortable(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
end
def javascript(*files)
  content_for(:head) { javascript_include_tag(*files) }
end

def stylesheet(*files)
  content_for(:head) { stylesheet_link_tag(*files) }
end

def active_class(link_path)
  current_page?(link_path) ? "active" : ""
end

end
