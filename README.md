# Sprockets::ES6Module

Sprockets ES6 transformer with module syntax.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sprockets-es6module'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprockets-es6module

## Usage

``` js
// hi.es6module

export default class HI {
  hello(name = 'there') {
    return 'Hi, ' + name + '.';
  }
}
```

``` js
// main.es6

import HI from 'hi';

let hi = new HI();
hi.hello(); //=> 'Hi, there.'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
