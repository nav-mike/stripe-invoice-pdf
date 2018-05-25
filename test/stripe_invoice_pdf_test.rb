# frozen_string_literal: true

require 'test_helper'

class StripeInvoicePdfTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, StripeInvoicePdf
  end
end
