module ApplicationHelper
  # helper_method :resource_name, :resource, :devise_mapping, :resource_class
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def navigation(is_present)
    return 'layouts/nav/public' if is_present

    'layouts/nav/before_public'
  end

  def user(u_id)
    user = User.find_by(id: u_id)
    user
  end

  def image_attached(property)
    return  property.images[0] if property.images.attached?
    'default.jpg'
  end

  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end
end
