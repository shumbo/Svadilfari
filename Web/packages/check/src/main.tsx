import { ChakraProvider } from "@chakra-ui/react";
import React from "react";
import ReactDOM from "react-dom";

import { check } from "./check";
import { CheckerApp } from "./CheckerApp";
import { i18n } from "./i18n";
import "./index.css";

i18n();
ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider>
      <CheckerApp
        check={check}
        onOpenApp={() => window.open("svadilfari://")}
      />
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
