# TsAssets for Rails [![Gem Version](https://badge.fury.io/rb/ts_assets.svg)](https://badge.fury.io/rb/ts_assets) [![CircleCI](https://circleci.com/gh/bitjourney/ts_assets-rails.svg?style=svg)](https://circleci.com/gh/bitjourney/ts_assets-rails)

`TsAssets` is a code generator to export Rails asset images to TypeScript as React components.

The motivation is that Rails asset images have hash digests in their URLs,
e.g. `/assets/kibela_logo-f3e74a6f5c9f46cc4e8b920cb.svg`, which are not easily available from JavaScript. The gem allows it by generating TypeScript code.

## Usage

### Rake Task

To use this gem, define a rake task to generate the code.

Here is an example rake task to generate a `assets.tsx`.

`lib/tasks/ts_assets.rake`:

```ruby
namespace :ts_assets do
  desc "generate assets.tsx"
  task generate: :environment do
    TS_ASSETS_FILENAME = "client/generated/assets.tsx"
    tscode = TsAssets.generate(include: "app/assets/images")
    File.write(TS_ASSETS_FILENAME, tscode)
  end
end
```

For example, if you have `app/assets/images/svg/ruby-icon.svg` in your asset path, the generated source would be like this:

`client/generated/assets.tsx`:

```tsx
/** svg/ruby-icon.svg */
const PATH_SVG_RUBY_ICON = "/assets/svg/ruby-icon-486fbe77b2fa5354.svg";

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

Then you can import `client/generated/assets.tsx` and use the components.

`client/components/MyComponent.tsx`:

```tsx
import * as React from 'react';
import { ImageSvgRubyIcon } from './generated/assets';

class MyComponent extends React.Component<any, any> {
  render() {
    return (
      <ImageSvgRubyIcon
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

```tsx
/** webhook/slack_icon@1x.png */
const PATH_WEBHOOK_SLACK_ICON_1X = "/assets/webhook/slack_icon@1x-dd316f78fb005e28fb960482.png";

/** webhook/slack_icon@2x.png */
const PATH_WEBHOOK_SLACK_ICON_2X = "/assets/webhook/slack_icon@2x-4f5daeae796f89bb5590bae2.png";

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

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ts_assets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ts_assets

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bitjourney/ts_assets-rails.

## Copyright and Licenses

Copyright 2017 Bit Journey, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
