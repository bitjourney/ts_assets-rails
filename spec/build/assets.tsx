/* tslint:disable */

import * as React from 'react';

/** svg/ruby-icon.svg */
const PATH_SVG_RUBY_ICON = "/assets/svg/ruby-icon-486fbe77b2fa535451a48ccd48587f8a1359fb373b7843e14fb5a84cb2697160.svg";

/** webhook/slack_icon@1x.png */
const PATH_WEBHOOK_SLACK_ICON_1X = "/assets/webhook/slack_icon@1x-dd316f78fb005e28fb960482d5972fc58ab33da6836c684c1b61e7cb1b60d1e0.png";

/** webhook/slack_icon@2x.png */
const PATH_WEBHOOK_SLACK_ICON_2X = "/assets/webhook/slack_icon@2x-4f5daeae796f89bb5590bae233226cacd092c1c4e911a12061bfe12c597cc885.png";


/** svg/ruby-icon */
export function ImageSvgRubyIcon(props: React.HTMLProps<HTMLImageElement>) {
    return <img alt="ruby-icon"
                width={128}
                src={PATH_SVG_RUBY_ICON}
                srcSet={`${PATH_SVG_RUBY_ICON} 1x`}
                {...props}
                />;
}

/** webhook/slack_icon */
export function ImageWebhookSlackIcon(props: React.HTMLProps<HTMLImageElement>) {
    return <img alt="slack_icon"
                width={20}
                src={PATH_WEBHOOK_SLACK_ICON_1X}
                srcSet={`${PATH_WEBHOOK_SLACK_ICON_1X} 1x,${PATH_WEBHOOK_SLACK_ICON_2X} 2x`}
                {...props}
                />;
}
