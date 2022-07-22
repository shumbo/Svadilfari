import ArrowCircleLeft from "@fluentui/svg-icons/icons/arrow_circle_left_24_regular.svg";
import ArrowCircleRight from "@fluentui/svg-icons/icons/arrow_circle_right_24_regular.svg";
import ArrowClockwise from "@fluentui/svg-icons/icons/arrow_clockwise_20_regular.svg";
import ArrowCurveDownRight from "@fluentui/svg-icons/icons/arrow_curve_down_right_20_regular.svg";
import ArrowCurveUpLeft from "@fluentui/svg-icons/icons/arrow_curve_up_left_20_regular.svg";
import ArrowRight from "@fluentui/svg-icons/icons/arrow_right_20_regular.svg";
import ArrowLeft from "@fluentui/svg-icons/icons/arrow_left_20_regular.svg";
import Broom from "@fluentui/svg-icons/icons/broom_20_regular.svg";
import ClipboardLink from "@fluentui/svg-icons/icons/clipboard_link_20_regular.svg";
import Code from "@fluentui/svg-icons/icons/code_20_filled.svg";
import GlobeAdd from "@fluentui/svg-icons/icons/globe_add_24_regular.svg";
import TabAdd from "@fluentui/svg-icons/icons/tab_add_20_regular.svg";
import TabDesktopCopy from "@fluentui/svg-icons/icons/tab_desktop_copy_20_regular.svg";
import TabProhibited from "@fluentui/svg-icons/icons/tab_prohibited_24_regular.svg";
import Share from "@fluentui/svg-icons/icons/share_ios_20_regular.svg";
import { Action, getActionCode } from "core";
import { unreachableCase } from "ts-assert-unreachable";
import { Browser } from "webextension-typedef";

import { HUDContent } from "../components/HUD/HUD";

export function getActionHUDContent(
  action: Action,
  i18n: Browser.I18n.Static
): HUDContent {
  const key = getActionCode(action);
  const getTitle = (code: string) => {
    return i18n.getMessage(`get_action_hud_content:${code}`);
  };
  switch (key) {
    case "tabClose":
      return { title: getTitle("tab_close"), icon: TabProhibited };
    case "tabCloseAll":
      return { title: getTitle("tab_close_all"), icon: Broom };
    case "tabOpen":
      return { title: getTitle("tab_open"), icon: TabAdd };
    case "tabDuplicate":
      return { title: getTitle("tab_duplicate"), icon: TabDesktopCopy };
    case "tabNext":
      return { title: getTitle("tab_next"), icon: ArrowCircleRight };
    case "tabPrevious":
      return { title: getTitle("tab_previous"), icon: ArrowCircleLeft };
    case "reload":
      return { title: getTitle("tab_reload"), icon: ArrowClockwise };
    case "javascriptRun": {
      const c: HUDContent = { title: getTitle("javascript_run"), icon: Code };
      if (action?.javascriptRun?.description) {
        c.message = action.javascriptRun.description;
      }
      return c;
    }
    case "urlCopy":
      return { title: getTitle("url_copy"), icon: ClipboardLink };
    case "scrollTop":
      return { title: getTitle("scroll_top"), icon: ArrowCurveUpLeft };
    case "scrollBottom":
      return { title: getTitle("scroll_bottom"), icon: ArrowCurveDownRight };
    case "goBackward":
      return { title: getTitle("go_backward"), icon: ArrowLeft };
    case "goForward":
      return { title: getTitle("go_forward"), icon: ArrowRight };
    case "openURL":
      return {
        title: getTitle("open_url"),
        message: action.openURL?.title ?? action.openURL?.url,
        icon: GlobeAdd,
      };
    case "share":
      return {
        title: getTitle("share"),
        icon: Share,
      };
    case null:
      break;
    default:
      unreachableCase(key);
  }
  return { title: getTitle("scroll_bottom") };
}
