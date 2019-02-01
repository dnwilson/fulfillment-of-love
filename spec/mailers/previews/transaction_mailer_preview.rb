class TransactionMailerPreview < ActionMailer::Preview
  def notify_transaction_submitted
    params = {amount: 1.99999e3, status: "submitted_for_settlement", error: nil, transaction_id: "abc123", products: [{price: "$99.99", name: "Beer"}, {price: "$399.99", name: "Chicken"}]}
    TransactionMailer.notify_transaction_submitted(User.first.id, params)
  end

  def notify_transaction_failed
    params = {
      amount: 1.99999e3, status: Braintree::Transaction::Status::Failed,
      error: "There was an error", transaction_id: "abc123", error_details: BraintreeService::TRANSCATION_FAILED_RESPONSE,
      products: [{price: "$99.99", name: "Beer"}, {price: "$399.99", name: "Chicken"}]
    }
    TransactionMailer.notify_transaction_completed(User.first.id, params)
  end

  def notify_transaction_declined
    params = {
      amount: 1.99999e3, status: Braintree::Transaction::Status::ProcessorDeclined,
      error: "There was an error", transaction_id: "abc123", error_details: BraintreeService::TRANSCATION_DECLINED_RESPONSE,
      products: [{price: "$99.99", name: "Beer"}, {price: "$399.99", name: "Chicken"}]
    }
    TransactionMailer.notify_transaction_completed(User.last.id, params)
  end

  def notify_transaction_completed
    params = {
      amount: 1.99999e3, status: "Transaction Completed",
      transaction_id: "abc123", description: "Thank you for purchasing Fulfillment of Love. Your shipment should arrive in 5 - 7 business days",
      products: [{price: "$99.99", name: "Beer"}, {price: "$399.99", name: "Chicken"}]
    }
    TransactionMailer.notify_transaction_completed(User.last.id, params)
  end
end
