class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Membership charge - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Membership charge - #{current_user.email}",
      currency: 'usd'
    )
    
    flash[:notice] = "Thank you for your payment of #{charge.amount}, #{current_user.email}"
    current_user.premium!
    redirect_to user_path
    
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
