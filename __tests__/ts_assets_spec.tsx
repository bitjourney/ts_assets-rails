import { shallow } from "enzyme";
import * as React from "react";
import { renderToString } from "react-dom/server";

import * as Assets from "./build/assets";

describe("TsAssets Components", () => {
  describe("with Server-Side Rendering", () => {
    test("renders something", () => {
      expect(renderToString(Assets.ImageSvgRubyIcon())).toBeTruthy();
      expect(renderToString(Assets.ImageWebhookSlackIcon())).toBeTruthy();
    });
  });

  describe("with Client-Side Rendering", () => {
    test("renders something", () => {
      const rubyIcon = shallow(
        <Assets.ImageSvgRubyIcon
          className="svg"
        />,
      );
      const slackIcon = shallow(
        <Assets.ImageWebhookSlackIcon
          className="webhook classname"
        />,
      );

      expect(rubyIcon.props().alt).toEqual("ruby-icon");
      expect(rubyIcon.props().className).toEqual("svg");
      expect(rubyIcon.props().src).toBeTruthy();
      expect(rubyIcon.props().srcSet).toBeTruthy();

      expect(slackIcon.props().alt).toEqual("slack_icon");
      expect(slackIcon.props().className).toEqual("webhook classname");
      expect(slackIcon.props().src).toBeTruthy();
      expect(slackIcon.props().srcSet).toBeTruthy();
    });
  });
});
