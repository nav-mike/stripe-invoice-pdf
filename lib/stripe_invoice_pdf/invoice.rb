require 'stripe'

module StripeInvoicePdf
  class Invoice
    attr_reader :id, :issue_date, :due_date, :company, :plan_name,
                :description, :qty, :unit_price, :amount,
                :coupon_id, :coupon_percent_off, :coupon_amount_off,
                :total_amount, :number
    
    Stripe.api_key = StripeInvoicePdf[:api_key]
    
    def initialize(id)
      @id = id
      invoice = Stripe::Invoice.retrieve id

      @issue_date = Time.zone.at invoice.date
      @due_date = Time.zone.at invoice.due_date
      @company = invoice.customer
      @plan_name = invoice.plan.nickname
      @description = "#{invoice.period_start} TO #{invoice.period_end}"
      @qty = invoice.plan.quantity
      @unit_price = invoice.plan.amount
      @amount = invoice.plan.amount
      @coupon_id = invoice.subscription.discount.coupon.id
      @coupon_percent_off = invoice.subscription.discount.coupon.percent_off
      @coupon_amount_off = invoice.subscription.discount.coupon.amount_off
      @total_amount = @amount
      @number = invoice.number
    end
  end
end