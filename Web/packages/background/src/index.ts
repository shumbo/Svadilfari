import { startBackground } from "./background";
import { ChannelImpl } from "./channel";
import { executeAction } from "./executeAction";
import { BackgroundMessengerImpl } from "./messenger";

startBackground({
  channel: new ChannelImpl(),
  executeAction: executeAction,
  messenger: new BackgroundMessengerImpl(),
});
