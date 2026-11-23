import React from "react";
import { createRoot } from "react-dom/client";

import "./styles/ios.css";
import { PopupApp } from "./PopupApp";
import { PopupMessengerImpl } from "./PopupMessenger";
import { PopupTabManagerImpl } from "./PopupTabManager";

// Safari sizes the popover from the content, so pin the width to the screen
// (capped for iPad).
document.body.style.width = `min(${window.screen.width}px, 400px)`;

const container = document.getElementById("root");
if (container) {
  const root = createRoot(container);
  root.render(
    <PopupApp
      i18n={browser.i18n}
      messenger={new PopupMessengerImpl()}
      tabManager={new PopupTabManagerImpl()}
    />,
  );
}
