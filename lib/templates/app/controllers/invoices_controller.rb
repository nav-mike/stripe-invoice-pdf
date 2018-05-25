# frozen_string_literal: true

class InvoicesController < ApplicationController
  layout 'stripe_invoice_pdf/pdf'

  def show
    @invoice = StripeInvoicePdf::Invoice.new(params[:invoice_id])
    render pdf: "Invoice-#{@invoice.number}"
  end
end
