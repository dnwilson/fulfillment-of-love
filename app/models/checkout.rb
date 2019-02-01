class Checkout < ApplicationRecord
  def self.log_transaction!(transaction, params)
    checkout = new(params)
    checkout.braintree_id = transaction.id
    checkout.status       = transaction.status
    checkout.save!
  end

  def full_name
    first_name + " " + last_name rescue ""
  end

  def full_address
    return address1 unless address2.present?
    address1 + ", " + address2
  end
end
