[travis]: https://travis-ci.org/blacktangent/tabs_for
[codeclimate]: https://codeclimate.com/github/blacktangent/tabs_for
[fontawesome]: https://fortawesome.github.io/Font-Awesome
[fontawesomerails]: https://github.com/bokmann/font-awesome-rails
[coveralls]: https://coveralls.io/r/blacktangent/tabs_for
[rubygems]: https://rubygems.org/gems/tabs_for

# TabsFor

[![Build Status](https://travis-ci.org/blacktangent/tabs_for.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/blacktangent/tabs_for/badges/gpa.svg)][codeclimate]
[![Test Coverage](http://img.shields.io/coveralls/blacktangent/tabs_for/master.svg)][coveralls]
[![Gem Version](http://img.shields.io/gem/v/tabs_for.svg)][rubygems]

ActiveView Helper for creating tabs with Bootstrap.

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

Preferred icon and CSS framework is [Font Awesome][fontawesome] and the `help` option uses
[Font Awesome][fontawesome] to display the help icon. This dependency
could easily be removed in the future.
Bring [Font Awesome][fontawesome] into your project by using
[font-awesome-rails][fontawesomerails] or your preferred method.

## Screenshot
![Screenshot](https://cloud.githubusercontent.com/assets/1222916/9381832/42b92924-4765-11e5-930e-1c5f236173c3.png)

## Sample Application

Sample application using `tabs_for` can be found
[here](https://github.com/blacktangent/tabs_for-demo).

## Usage

Generate the tabs with corresponding panes using the API below. `tab`
takes two arguments and a block. If a symbol is used and the symbol is
an attribute on the model it will get translated, else the string will
be used directly. `tab` requires a block, this will be used as content
in the tabs pane.

```erb
<%= tabs_for @project do |b| %>
  <%= b.tab :tasks, icon: "tasks", size: @project.tasks.size, active: true do %>
    <%= render partial: "tasks/table", locals: { tasks: @project.tasks } %>
  <% end %>
  <%= b.tab :people, icon: "users", size: @project.people.size, label: "Members", help: "Only showing active users." do %>
    <%= render partial: "people/table", locals: { people: @project.people } %>
  <% end %>
  <%= b.tab :statistics, icon: "bar-chart" do %>
    <%= render "statistics", object: @project %>
  <% end %>
  <%= b.tab :settings, icon: "cogs" do %>
    <%= render "settings", object: @project %>
  <% end %>
<% end %>
```

## Options
Supported options for `tab`:

* __:active__ - Active tab, the contents will be shown upon rendering.
* __:label__ - Use custom label text in tab header.
* __:icon__ - Icon used next to tab header text
* __:size__ - Number of entires in tab pane. Use if tab pane contains
  table or list.
* __:id__ - Override element's ID.
* __:help__ - Add help text shown on top of tab pane.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blacktangent/tabs_for. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

