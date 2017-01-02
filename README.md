# capistrano-tarball_scm

This plugin helps you deploy compiled artifacts via [Capistrano](http://capistranorb.com). It packages (locally built) artifacts as [tarballs](https://en.wikipedia.org/wiki/Tar_(computing)) and forwards them to the target server(s).

## Rationale

Capistrano’s defaults demand that your target servers have direct access to your VCS repository in order to pull updates to the application code. This implies that any derivative or dependent resources not stored in the source code repository (e.g. config files, dependencies, compiled resources, etc.) must be delivered via a side channel. This may easily become cumbersome (or even problematic), if any of the following is true for your project:

* You don’t want to grant your application servers direct access to your VCS.
* You’re not using a VCS for this particular project.
* There’s an explicit compilation step involving a separate toolset that is unavailable (or unnecessary) on your application servers.

Despite presented drawbacks, the default approach has been proven to work well for typical Ruby applications, where dependencies are installed on each server individually, and external tools are rarely needed to get the app running.

The `capistrano-tarball_scm` gem is not a replacement, or a generally superior alternative to the defaults. Instead, it’s just a convenient option for deploying static content and compiled artifacts.

The gem is similar to [capistrano-git-copy](https://github.com/ydkn/capistrano-git-copy) and [capistrano-scm-tar](https://github.com/ziguzagu/capistrano-scm-tar). Although, while sharing the goal of *pushing* updates to the server, it’s distinct in two major areas:

* It builds the deployed tarball from a provided filesystem path. Conversely, `capistrano-git-copy` loads deployed artifacts directly from Git, while `capistrano-scm-tar` expects the user to provide a prepared tarball.
* In contrast to `capistrano-scm-tar`, it relies on the modern SCM plugin API introduced in Capistrano 3.7.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-tarball_scm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-tarball_scm

Replace any existing SCM plugins in your Capfile with these two lines:

```ruby
require 'capistrano/tarball_scm'
install_plugin Capistrano::TarballScm::Plugin
```

## Usage

By default, a tarball of your working dir will be created in the Capistrano temporary directory (usually, same as your system’s). You can configure this behavior using the following configuration parameters:

* `:repo_url`
  * **default:** `.`
  * The path to the directory containing the deployed artifact.
* `:tarball_dir`
  * **default:** equals Capistrano’s `:tmp_dir`
  * The path to the directory where to store the create tarball.
* `:tarball_exclude`
  * **default:** `[]`
  * A list of paths to be excluded from the created tarball.

## Development

After cloning the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/temochka/capistrano-tarball_scm.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
