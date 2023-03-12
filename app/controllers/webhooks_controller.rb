class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

   
    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      property = Property.find_by(id: session.metadata.order_id)
      property.is_paid = true
      property.buyer_id = session.metadata.cid
      property.save!
    end

    render json: { message: 'success' }
  end
end