import { ChakraProvider } from "@chakra-ui/react";
import React from "react";
import ReactDOM from "react-dom";

import { PopupApp } from "./PopupApp";
import { PopupMessengerImpl } from "./PopupMessenger";
import { PopupTabManagerImpl } from "./PopupTabManager";

const root = document.getElementById("root");
if (root) {
  ReactDOM.render(
    <ChakraProvider>
      <PopupApp
        i18n={browser.i18n}
        messenger={new PopupMessengerImpl()}
        tabManager={new PopupTabManagerImpl()}
      />
    </ChakraProvider>,
    root
  );
}
