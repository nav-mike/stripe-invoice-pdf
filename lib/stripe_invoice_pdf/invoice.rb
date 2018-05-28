# frozen_string_literal: true

require 'stripe'

class StripeInvoicePdf
  class Invoice
    include ActionView::Helpers::NumberHelper

    attr_reader :id, :issue_date, :due_date, :company, :plan_name,
                :description, :qty, :unit_price, :amount,
                :coupon_id, :coupon_percent_off, :coupon_amount_off,
                :total_amount, :number, :subtotal

    def initialize(id)
      Stripe.api_key = Invoice.key
      @invoice = Stripe::Invoice.retrieve id

      @id = id
      @issue_date = Time.zone.at(@invoice.date).strftime('%^B %d, %Y')
      @due_date = due_date_parse
      @company = company_parse
      @plan_name = plan.try(:nickname)
      @description = "#{Time.zone.at(@invoice.period_start).strftime('%^B %d, %Y')} TO \
                      #{Time.zone.at(@invoice.period_end).strftime('%^B %d, %Y')}"
      @qty = @invoice.lines.data.first.quantity
      @unit_price = plan.try(:amount).to_f / 100.0
      @amount = plan.try(:amount).to_f / 100.0
      @coupon_id = parse_coupon_id
      @coupon_percent_off = parse_coupon_percent_off
      @coupon_amount_off = parse_coupon_amount_off.to_f / 100
      @total_amount = @invoice.total
      @number = @invoice.number
      @subtotal = @invoice.subtotal
    end

    def self.key
      StripeInvoicePdf.api_key
    end

    def self.debug(id)
      Stripe.api_key = key
      Stripe::Invoice.retrieve id
    end

    def date
      Time.zone.at(@invoice.date).strftime('%B %d, %Y')
    end

    def total
      number_to_currency(@invoice.total.to_f / 100.0)
    end

    # unit_price
    def price
      number_to_currency(plan.try(:amount).to_f / 100.0)
    end

    private

    def due_date_parse
      return @issue_date unless @invoice.due_date.present?
      Time.zone.at(@invoice.due_date).strftime('%^B %d, %Y')
    end

    def company_parse
      customer.try(:description)
    end

    def customer
      @customer ||= Stripe::Customer.retrieve(@invoice.customer)
    end

    def plan
      @plan ||= @invoice.lines.data.first.plan
    end

    def subscription
      return nil unless @invoice.subscription
      @subscription ||= Stripe::Subscription.retrieve(@invoice.subscription)
    end

    def parse_coupon_id
      return nil unless subscription
      return nil unless subscription.discount
      subscription.discount.coupon.id
    end

    def parse_coupon_percent_off
      return nil unless subscription
      return nil unless subscription.discount
      subscription.discount.coupon.percent_off
    end

    def parse_coupon_amount_off
      return nil unless subscription
      return nil unless subscription.discount
      subscription.discount.coupon.amount_off
    end
  end
end
