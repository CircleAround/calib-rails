# Calib::Rails
Calib::Rails is modules of something tips for Rails.

## Usage
Please read rdocs.

- Basic Auth
  - [Calib::Controllers::BasicAuth](http://www.rubydoc.info/gems/calib-rails/Calib/Controllers/BasicAuth)
- Devise Utilities  
  - Friendly forwarding
    - Redirect to accecced URL on signing in
    - [Calib::Devise::FriendlyForwardable](http://www.rubydoc.info/gems/calib-rails/Calib/Devise/FriendlyForwardable)
  - SoftDeletation
    - [Calib::Devise::SoftDeletion](http://www.rubydoc.info/gems/calib-rails/Calib/Devise/SoftDeletion)
- SoftDeletion
  - soft deletation with unique index(not `delete_at = nil`)
  - [Calib::SoftDeletion::MigrationEnhancable](http://www.rubydoc.info/gems/calib-rails/Calib/SoftDeletion/MigrationEnhancable)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'calib-rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install calib-rails
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
