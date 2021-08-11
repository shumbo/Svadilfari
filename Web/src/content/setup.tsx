import React from "react";
import ReactDOM from "react-dom";
import { ContentApp, ContentAppProps } from "./ContentApp";

export function setupContentApp(props: ContentAppProps) {
  const root = document.createElement("div");
  document.body.appendChild(root);

  ReactDOM.render(<ContentApp {...props} />, root);
}
