$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stripe_invoice_pdf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stripe_invoice_pdf"
  s.version     = StripeInvoicePdf::VERSION
  s.authors     = ["Mikhail Navrotskiy"]
  s.email       = ["m.navrotskiy@hotmail.com"]
  s.homepage    = "https://github.com/nav-mike/stripe-invoice-pdf"
  s.summary     = "Simple stripe invoice pdf generator for rails"
  s.description = "Simple stripe invoice pdf generator for rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
