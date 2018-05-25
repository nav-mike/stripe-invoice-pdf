module StripeInvoicePdf
  class << self
    def config=(init_hash)
      @conf = init_hash
    end
    
    def [](key)
      @conf[key.to_sym]
    end
  end
end
