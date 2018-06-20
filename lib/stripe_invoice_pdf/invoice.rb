# frozen_string_literal: true

require 'stripe'

class StripeInvoicePdf
  class Invoice
    include ActionView::Helpers::NumberHelper

    attr_reader :unit_price,
                :coupon_id, :coupon_percent_off, :coupon_amount_off,
                :total_amount

    def initialize(id)
      Stripe.api_key = Invoice.key unless Stripe.api_key
      @invoice = Stripe::Invoice.retrieve id
    end

    def self.key
      StripeInvoicePdf.api_key
    end

    def plan_name
      plan.try(:nickname)
    end

    def customer_name
      customer.try(:description)
    end

    def quantity
      @invoice.lines.data.first.quantity
    end
    
    def tax
      return nil if @invoice.lines.data.size < 2
      @tax ||= @invoice.lines.data[1]
      OpenStruct.new(
        description: @tax.description,
        quantity: @tax.quantity,
        price: number_to_currency(@tax.try(:amount).to_f / 100.0),
        amount: number_to_currency(@tax.try(:amount).to_f / 100.0 * @tax.quantity)
      )
    end

    def coupon
      return nil unless subscription
      return nil unless subscription.discount
      id = subscription.discount.coupon.id
      return "#{id} (#{subscription.discount.coupon.percent_off}%)" if subscription.discount.coupon.percent_off
      "#{id} (#{number_to_currency(subscription.discount.coupon.amount_off.to_f / 100.0)})"
    end

    def date
      Time.zone.at(@invoice.date).strftime('%B %d, %Y')
    end

    def issue_date
      Time.zone.at(@invoice.date).strftime('%^B %d, %Y')
    end

    def due_date
      return issue_date unless @invoice.due_date.present?
      Time.zone.at(@invoice.due_date).strftime('%^B %d, %Y')
    end

    def subtotal
      number_to_currency(@invoice.subtotal.to_f / 100.0)
    end

    def total
      number_to_currency(@invoice.total.to_f / 100.0)
    end

    # unit_price
    def price
      number_to_currency(plan.try(:amount).to_f / 100.0)
    end

    def amount
      number_to_currency(plan.try(:amount).to_f / 100.0 * @invoice.lines.data.first.quantity)
    end

    def discount
      amount = plan.try(:amount).to_f / 100.0 * @invoice.lines.data.first.quantity.to_f
      return number_to_currency(0.0) unless subscription
      return number_to_currency(0.0) unless subscription.discount
      return number_to_currency(subscription.discount.coupon.amount_off.to_f / 100.0) if subscription.discount.coupon.amount_off
      number_to_currency((amount * subscription.discount.coupon.percent_off / 100.0).to_f)
    end

    def number
      @invoice.number
    end

    def description
      "#{Time.zone.at(@invoice.period_start).strftime('%^B %d, %Y')} TO \
        #{Time.zone.at(@invoice.period_end).strftime('%^B %d, %Y')}"
    end

    private

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
  end
end
