class BraintreeService
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement
  ]

  TRANSACTION_DECLINED_STATUSES = [
    Braintree::Transaction::Status::ProcessorDeclined,
    Braintree::Transaction::Status::SettlementDeclined,
  ]

  TRANSACTION_FAILED_STATUSES = [
    Braintree::Transaction::Status::Failed,
    Braintree::Transaction::Status::GatewayRejected,
    Braintree::Transaction::Status::AuthorizationExpired
  ]

  TRANSACTION_COMPLETED_STATUSES = [
    TRANSACTION_DECLINED_STATUSES,
    TRANSACTION_FAILED_STATUSES,
    Braintree::Transaction::Status::Settled
  ].flatten

  TRANSCATION_FAILED_RESPONSE = {
    summary: "Transaction Failed",
    description: "There was an error with the information submitted. Please verify your card information and try again."
  }

  TRANSCATION_DECLINED_RESPONSE = {
    summary: "Transaction Declined",
    description: "Unfortunately, we were unable to successfully process your transaction. Please contact your financial instituation and try again."
  }
end
