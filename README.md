# Weather

What's the weather like?

This isn't a _great_ tool, it's a solution to one of the practice problems
in [_Programming Elixir_][pe]. You probably don't want to use this.

[pe]: https://pragprog.com/book/elixir/programming-elixir

## Installation

You'll need [elixir][] installed. 

You can do this with whatever your system package manager is. For instance on
macOS you can `brew install elixir` if you have [`brew`][brew] installed

You can build this with [`mix`][mix].

Documentation can be generated with [ExDoc][]

[brew]: http://brew.sh
[elixir]: http://elixir-lang.org
[mix]: http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[exdoc]: https://github.com/elixir-lang/ex_doc

## Configuration

`weather` needs to be told what city you're in. Find your city
on [weather.gc.ca][gc] and copy the URL.

Run weather with the `--init` flag and the URL to have it set a `.weather`
file in your home directory that it'll use to remember for next time.

``` sh
$ weather --init <url>
```

[gc]: https://weather.gc.ca/canada_e.html

## Use

Just run `weather` to get the current conditions. 

<!-- Get the full details with `--details`.  -->

<!-- You can also get the forecast with the `--forecast` flag. -->

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
