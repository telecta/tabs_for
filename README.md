# TabsFor

[![Build
Status](https://travis-ci.org/blacktangent/tabs_for.svg?branch=master)](https://travis-ci.org/blacktangent/tabs_for)
[![Code
Climate](https://codeclimate.com/github/blacktangent/tabs_for.png)](https://codeclimate.com/github/blacktangent/tabs_for)

Easliy create tabs with with panes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tabs_for'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tabs_for

The gem depends on [Bootstrap 3](http://getbootstrap.com/) to create the tabs. Bring bootstrap into
your project by using [Bootstrap for Sass](https://github.com/twbs/bootstrap-sass) or you preferred method.

Preferred icon and CSS framework is [Font
Awesome](https://github.com/bokmann/font-awesome-rails), but other
frameworks should also be usable.

## Usage

Generate the tabs with corresponding panes using the API below. `tab`
takes two arguments and a block. If a symbol is used and the symbol is
an attribute on the model it will get translated, else the string will
be used directly. `tab` requires a block, this will be used as content
in the tabs pane.

```erb
<%= tabs_for @company do |b| %>
  <%= b.tab :users, active: true, icon: 'fa fa-user' do %>
    <%= render @company.users %>
  <% end %>
  <%= b.tab :statistics, icon: 'fa fa-table' do %>
    <%= render @company.statistics %>
  <% end %>
<% end %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blacktangent/tabs_for. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

