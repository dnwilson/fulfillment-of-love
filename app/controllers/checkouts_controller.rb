class CheckoutsController < ApplicationController
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
    @client_token = gateway.client_token.generate
    @price = 9.99
    @total = 9.99
  end

  def show
    @transaction = gateway.transaction.find(params[:id])
    @checkout = Checkout.find_by_braintree_id(params[:id])
    @result = _create_result_hash(@transaction)
  end

  def index
    @checkouts = Checkout.all
  end

  def create
    amount = params["qty"].to_f * 9.99 # In production you should not take amounts directly from clients
    nonce = params["payment_method_nonce"]

    result = gateway.transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success? || result.transaction
      @checkout = Checkout.log_transaction!(result.transaction, checkout_params)
      redirect_to checkout_path(result.transaction.id)
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      redirect_to new_checkout_path
    end
  end

  def _create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        header: "Sweet Success!",
        icon: "check",
        success: true,
        message: "Thank you for purchasing Fulfillment of Love. Please check your email (#{@checkout.email}) for payment confirmation as well as shipping updates."
      }
    else
      result_hash = {
        header: "Processing Error",
        icon: "times",
        success: false,
        message: "We were unable to process your transaction. Please return to the checkout page and try again."
      }
    end
  end

  def gateway
    env = ENV["BT_ENVIRONMENT"]

    @gateway ||= Braintree::Gateway.new(
      :environment => env && env.to_sym,
      :merchant_id => ENV["BT_MERCHANT_ID"],
      :public_key => ENV["BT_PUBLIC_KEY"],
      :private_key => ENV["BT_PRIVATE_KEY"],
    )
  end

  private

  def checkout_params
    request.parameters.slice(:email, :first_name, :last_name, :address1, :address2, :city, :state, :zipcode)
  end
end
