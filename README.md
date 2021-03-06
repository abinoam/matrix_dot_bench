# MatrixDotBench

A simple benchmark of some strategies to do Matrix multiplication (dot product) in Ruby.

See post at: http://abinoam.tl1n.com/400x-faster-matrix-multiplication-for-ruby/

Basically it shows that using `NMatrix#dot` with an NMatrix object with `dtype: :float64` is more than 400x faster than using `Matrix#*`.

## Installation

    $ git clone git@github.com:abinoam/matrix_dot_bench.git
    $ cd matrix_dot_bench
    $ bundle install

## Usage

    $ exe/matrix_dot_bench

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abinoam/matrix_dot_bench.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

