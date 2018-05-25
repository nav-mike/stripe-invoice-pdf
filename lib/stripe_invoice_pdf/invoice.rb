require 'stripe'

class StripeInvoicePdf
  class Invoice
    attr_reader :id, :issue_date, :due_date, :company, :plan_name,
                :description, :qty, :unit_price, :amount,
                :coupon_id, :coupon_percent_off, :coupon_amount_off,
                :total_amount, :number
    
    def initialize(id)
      @id = id
      Stripe.api_key = Invoice.key
      invoice = Stripe::Invoice.retrieve id

      @issue_date = Time.zone.at invoice.date
      @due_date = due_date_parse invoice
      @company = company_parse invoice
      @plan_name = plan(invoice).nickname
      @description = "#{invoice.period_start} TO #{invoice.period_end}"
      @qty = invoice.lines.data.first.quantity
      @unit_price = plan(invoice).amount.to_f / 100.0
      @amount = plan(invoice).amount.to_f / 100.0
      @coupon_id = parse_coupon_id invoice
      @coupon_percent_off = parse_coupon_percent_off invoice
      @coupon_amount_off = parse_coupon_amount_off(invoice).to_f / 100
      @total_amount = @amount
      @number = invoice.number
    end
    
    def self.key
      StripeInvoicePdf.api_key
    end
    
    def self.debug(id)
      Stripe.api_key = key
      Stripe::Invoice.retrieve id
    end
    
    private
    
    def due_date_parse(invoice)
      return nil unless invoice.due_date
      Time.zone.at invoice.du_date
    end
    
    def company_parse(invoice)
      customer(invoice).description
    end
    
    def customer(invoice)
      @customer ||= Stripe::Customer.retrieve(invoice.customer)
    end
    
    def plan(invoice)
      @plan ||= invoice.lines.data.first.plan
    end
    
    def subscription(invoice)
      @subscription ||= Stripe::Subscription.retrieve(invoice.subscription)
    end
    
    def parse_coupon_id(invoice)
      return nil unless subscription(invoice).discount
      subscription(invoice).discount.coupon.id
    end
    
    def parse_coupon_percent_off(invoice)
      return nil unless subscription(invoice).discount
      subscription(invoice).discount.coupon.percent_off
    end
    
    def parse_coupon_amount_off(invoice)
      return nil unless subscription(invoice).discount
      subscription(invoice).discount.coupon.amount_off
    end
  end
end