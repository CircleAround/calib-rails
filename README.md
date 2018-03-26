# Calib::Rails
Calib::Rails is modules of something tips for Rails.

## Usage
Please read following rdocs.

### Basic Auth
- [Calib::Controllers::BasicAuth](http://www.rubydoc.info/gems/calib-rails/Calib/Controllers/BasicAuth)

### Utilities for devise
Support libraries for [devise](https://github.com/plataformatec/devise) .

#### Friendly forwarding
Redirect to accecced URL on signing in.

- [Calib::Devise::FriendlyForwardable](http://www.rubydoc.info/gems/calib-rails/Calib/Devise/FriendlyForwardable)

####  SoftDeletion
Module of soft deletion for devise account model(usually User).

- [Calib::Devise::SoftDeletion](http://www.rubydoc.info/gems/calib-rails/Calib/Devise/SoftDeletion)

### Soft Deletion
Module of migration for soft deletion with unique index(not `delete_at = nil`)
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
