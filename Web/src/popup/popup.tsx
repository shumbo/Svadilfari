import React from "react";
import ReactDOM from "react-dom";
import { PopupApp } from "./PopupApp";
import { PopupMessengerImpl } from "./PopupMessenger";
import { PopupTabManagerImpl } from "./PopupTabManager";

const root = document.getElementById("root");
if (root) {
  ReactDOM.render(
    <PopupApp
      messenger={new PopupMessengerImpl()}
      tabManager={new PopupTabManagerImpl()}
    />,
    root
  );
}
