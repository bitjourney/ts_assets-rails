# TsAssets

[![Build Status](https://travis-ci.org/bitjourney/ts_assets-rails.svg?branch=master)](https://travis-ci.org/bitjourney/ts_assets-rails)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ts_assets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ts_assets

## Usage

### Rake

Here is an example to generate an asset file via rake.

`lib/tasks/ts_assets.rake`:

```ruby
# rake ts_assets:generate
namespace :ts_assets do
  task generate: :environment do
    TS_ASSETS_FILENAME = "client/generated/assets.tsx"
    File.write TS_ASSETS_FILENAME, TsAssets.generate(include: "app/assets/images")
  end
end
```

For example, if  you have `app/assets/images/svg/ruby-icon.svg` in your asset path, the generated source would be like this:

`client/generated/assets.tsx`:

```typescript
/** svg/ruby-icon.svg */
const PATH_SVG_RUBY_ICON = "/assets/svg/ruby-icon-486fbe77b2fa535451a48ccd48587f8a1359fb373b7843e14fb5a84cb2697160.svg";

/** svg/ruby-icon */
export function ImageSvgRubyIcon(props: React.HTMLProps<HTMLImageElement>) {
    return <img alt="ruby-icon"
                width={128}
                height={128}
                src={PATH_SVG_RUBY_ICON}
                srcSet={`${PATH_SVG_RUBY_ICON} 1x`}
                {...props}
                />;
}
```

Then you can import `client/generated/assets.tsx` and use the imported components.

`client/components/MyComponent.tsx`:

```typescript
import * as React from 'react';
import * as Assets from '../../generated/assets';

class MyComponent extend React.Component<any, any> {
  render() {
    return (
      <Assets.ImageSvgRubyIcon 
        alt='ruby' 
        className='svg icon' 
      />
    );
  }
}
```

### Options

All you need to do is to call `TsAssets.generate` class method with supported options. 

Currently supported options are:

- `include`: the path to the assets. e.g.) "app/assets/images"

### React Components

#### `width`, `height`

The `width` and `height` attribute is automatically set via https://github.com/sdsykes/fastimage gem.

#### `srcSet`

If you have files named like `*@1x.png` or `*@2x.png`, the `srcSet` attribute will be automatically set.

For example, if there are those images in your `include` path:

```
app/assets/images
  /webhook
    slack_icon@1x.png
    slack_icon@2x.png
```

Then the generated components looks like:

```typescript
/** webhook/slack_icon@1x.png */
const PATH_WEBHOOK_SLACK_ICON_1X = "/assets/webhook/slack_icon@1x-dd316f78fb005e28fb960482d5972fc58ab33da6836c684c1b61e7cb1b60d1e0.png";

/** webhook/slack_icon@2x.png */
const PATH_WEBHOOK_SLACK_ICON_2X = "/assets/webhook/slack_icon@2x-4f5daeae796f89bb5590bae233226cacd092c1c4e911a12061bfe12c597cc885.png";

/** webhook/slack_icon */
export function ImageWebhookSlackIcon(props: React.HTMLProps<HTMLImageElement>) {
    return <img alt="slack_icon"
                width={20}
                src={PATH_WEBHOOK_SLACK_ICON_1X}
                srcSet={`${PATH_WEBHOOK_SLACK_ICON_1X} 1x,${PATH_WEBHOOK_SLACK_ICON_2X} 2x`}
                {...props}
                />;
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kenju/ts_assets.
