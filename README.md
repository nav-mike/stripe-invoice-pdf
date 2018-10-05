# Stripe Invoice PDF

![status](https://img.shields.io/badge/status-deprecated-red.svg)

## A PDF generation stripe's invoices plugin for Ruby on Rails

Plugin uses the plugin [wicked_pdf](https://github.com/mileszs/wicked_pdf) to build a PDF file.  You can customize HTML-template.

_Stripe Invoice PDF has been verified to work on Ruby versions 2.3.4 through 2.4; Rails 4.2.1 through 5.1_

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'stripe_invoice_pdf', git: 'https://github.com/nav-mike/stripe-invoice-pdf.git'
```

And then execute:
```bash
$ bundle install
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

#### SVG logo

You can use svg logo. For this set `company_logo` as `"logo"`, without extension, [more](https://github.com/nav-mike/stripe-invoice-pdf/blob/master/lib/stripe_invoice_pdf/helpers.rb#L15).

#### Debug mode

stripe-invoice-pdf use [wicked_pdf](https://github.com/mileszs/wicked_pdf) for generate pdf. You can use GET parameter `?debug=1` for show [pdf as html](https://github.com/mileszs/wicked_pdf#advanced-usage-with-all-available-options).

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
