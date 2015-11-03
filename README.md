# grape-formats

`grape-formats` is a very small extension to [grape](https://github.com/ruby-grape/grape)
that provides endpoint parameter validation and type coercion for a range of well-known
data formats.

To use these formats, all you need to do is pass the appropriate token as the `type`
option for any endpoint parameter declared in the `params` block using `requires` or
`optional`. See the usage examples below.

## `Date`

Most of the standard string parsing functions available on the `Date` class are
available in `Grape::Formats::Dates`. Any parameter value that doesn't match the
expected format will cause a `HTTP 400` error to be generated.

```ruby
require 'grape'
require 'grape/formats/dates'

Dates = Grape::Formats::Dates

class API < Grape::API
  resource :calendar do
    params do
      # Allows '2001-02-03', '20010203' ...
      requires :start, type: Dates::Iso8601

      # Allows 'H13.02.04' ...
      requires :finish, type: Dates::Jisx0301
    end
    get :agenda do
      params[:start] # => #<Date: 2001-02-03 ...>
      params[:finish] # => #<Date: 2001-02-04 ...>
      # ...
    end
  end
end
```

See `lib/grape/formats/dates.rb` for a full list of available formats.

## `DateTime`

As with `Grape::Formats::Dates`, so too with `Grape::Formats::DateTimes`

```ruby
require 'grape/formats/date_times'

DateTimes = Grape::Formats::DateTimes

# ...

params do
  requires :start, type: DateTimes::Iso8601
  requires :finish, type: DateTimes::Jisx0301
end
```

See `lib/grape/formats/date_times.rb` for available formats.
