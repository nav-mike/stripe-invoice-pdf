class InvoicesController < ApplicationController
  def show
    file = StripeInvoicePdf::Invoice.new(params[:invoice_id]).pdf
    render pdf: file.name
  end
end