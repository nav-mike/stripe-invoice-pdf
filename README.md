# stripe-invoice-pdf

### Installation

Add this to your Gemfile and run `bundle install`

```ruby
gem 'stripe_invoice_pdf', git: 'https://github.com/nav-mike/stripe-invoice-pdf.git'
```

Then create the initializer with

`rails generate stripe_invoice_pdf`

Open `config/initializer/stripe_invoice_pdf.rb` and set Stripe's `api_key` and your logo:

```ruby
StripeInvoicePdf.config = {
  api_key: 'sk_...',
  company_logo: 'logo.png'
}
```

Run rails server `rails s` and open `http://0.0.0.0:3000/invoices/:invoice_id`.
More about invoice id [here](https://stripe.com/docs/api/ruby#invoice_object-id).
