# frozen_string_literal: true

class InvoicesController < ApplicationController
  layout 'stripe_invoice_pdf/pdf'

  def show
    @invoice = StripeInvoicePdf::Invoice.new(params[:invoice_id])
    render pdf: "Invoice-#{@invoice.number}",
           template: 'invoices/show.pdf.erb',
           layout: 'stripe_invoice_pdf/pdf.html',
           show_as_html: show_as_html?
  end

  private

  def show_as_html?
    (Rails.env.development? || Rails.env.test?) && params.key?('debug')
  end
end
