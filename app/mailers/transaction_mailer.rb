class TransactionMailer < ActionMailer::Base
  default from: "michaelzapmealetter@gmail.com"

  # transaction = {:amount, :status, :error, :transaction_id}
  def notify_transaction_submitted(id, opts={})
    @checkout = Checkout.find(id)
    @opts = opts.merge!(OPTIONS)
    mail(to: @checkout.email, subject: "#{@opts[:title]} order confirmation")
  end

  def notify_transaction_completed(id, opts={})
    @checkout = Checkout.find(id)
    @opts = opts.merge!(OPTIONS)
    mail(to: @checkout.email, subject: "#{@opts[:title]} order confirmation")
  end

  OPTIONS = {
    url: "https://fulfillmentoflove.com",
    logo: "main_bg.png",
    title: "Fulfillment of Love",
    color: "yellow",
    fb: "fulfillmentoflove",
    ig: "fulfillmentoflove",
    twitter: "fulfillmentofl",
    whatsapp: "13475257771"
  }
end
