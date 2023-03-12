class DashboardController < ApplicationController
  def index
    @users = User.all
    @user_properties = current_user.properties
    @sold_property =  @user_properties.where(is_paid: true)
    @buyer_props = Property.where(buyer_id: current_user.id)
  end 
  # sold properties page
  def sold
    @user_properties = current_user.properties
    @sold_property =  @user_properties.where(is_paid: true)
  end
end
