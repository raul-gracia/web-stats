# Web::Stats

A small script to parse and show stats for your webserver log

## Installation

    $ gem install web-stats

## Usage

    $ weblog-parser webserver.log

Example output

```bash
    -- WEBLOG STATS --
==========================
    -- Total Visits --
/home           (78 views)
/help_page/1    (80 views)
/about          (81 views)
/index          (82 views)
/contact        (89 views)
/about/2        (90 views)
==========================
    -- Unique Views --
/about          (21 views)
/about/2        (22 views)
/help_page/1    (23 views)
/contact        (23 views)
/home           (23 views)
/index          (23 views)
```

## Testing

    $ bundle exec rspec

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Web::Stats project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/raul-gracia/web-stats/blob/master/CODE_OF_CONDUCT.md).
