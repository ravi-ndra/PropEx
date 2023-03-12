class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def create
    property = Property.find_by(id: params[:id])
    @session = Stripe::Checkout::Session.create({
      metadata: {order_id: property.id, cid: current_user.id},
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
         currency: 'inr',
         product_data: {
           name: property.name,
         },
         unit_amount: property.price * 100
        },
       quantity: 1
     }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: "https://1ca4-2401-4900-1f3f-190d-f18d-5517-ee59-c309.ngrok.io" + '/dashboard/index',
    })
    redirect_to @session.url, allow_other_host: true
    # respond_to do |format|
    #   format.js
    # end
  end
end
