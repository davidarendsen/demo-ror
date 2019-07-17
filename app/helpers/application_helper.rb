module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def error_message_on(object, method)
    return unless object.respond_to?(:errors) && object.errors.include?(method)
    errors = field_errors(object, method).join(', ')

    content_tag(:div, errors, class: 'alert alert-dismissible alert-danger')
  end

  private
    def field_errors(object, method)
      object.errors[method]
    end
end
