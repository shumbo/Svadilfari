import { ChakraProvider } from "@chakra-ui/react";
import React from "react";
import ReactDOM from "react-dom";

import { check, checkBrowser } from "./check";
import { CheckerApp } from "./CheckerApp";
import { i18n } from "./i18n";
import "./index.css";

const isTouchDevice = "ontouchstart" in window || navigator.maxTouchPoints > 0;

i18n();
ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider>
      <CheckerApp
        check={check}
        onOpenApp={() => window.open("svadilfari://")}
        checkBrowser={() => {
          return checkBrowser(navigator.userAgent, isTouchDevice);
        }}
      />
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
