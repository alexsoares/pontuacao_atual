# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def hinted_text_field_tag(name, value = nil, hint = "Click and enter text", options={})
    value = value.nil? ? hint : value
    text_field_tag name, value, {:onclick => "if($(this).value == '#{hint}'){$(this).value = ''}", :onblur => "if($(this).value == ''){$(this).value = '#{hint}'}" }.update(options.stringify_keys)
  end

  def current_announcement
    @current_announcements ||= Announcement.current_announcements(session[:announcement_hide_time])
  end

  def sortable(search,column,title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column  == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:search => search,:sort => column, :direction => direction},{:class => css_class}
  end


  def datepicker_tag(model, attribute, options ={}, datepicker_options ={})
    field_id = "#{model}_#{attribute}"
    field_name = "#{model}[#{attribute}]"
    field = ::ActionView::Helpers::InstanceTag.new(model, attribute, self)
    options = {:id => field_id, :name => field_name}.merge(options)
    datepicker_options = "#{options_for_javascript(datepicker_options)}"
    js = "$(document).ready(function() { $(\"\##{field_id}\").datepicker(#{datepicker_options});});"
    field.tag(:input, options) + javascript_tag(js)
  end

  def datetimepicker_tag(model, attribute, options ={}, datetimepicker_options = {})
    field_id = "#{model}_#{attribute}"
    field_name = "#{model}[#{attribute}]"
    field = ::ActionView::Helpers::InstanceTag.new(model, attribute, self)
    options = {:id => field_id, :name => field_name}.merge(options)
    datetimepicker_options = "#{options_for_javascript(datetimepicker_options)}"
    js = "$(document).ready(function() { $(\"\##{field_id}\").datetimepicker(#{datetimepicker_options});});"
    field.tag(:input, options) + javascript_tag(js)
  end

end
