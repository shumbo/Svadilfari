import React from "react";
import ReactDOM from "react-dom";
import { ContentApp, ContentAppProps } from "./ContentApp";

export function setupContentApp(props: ContentAppProps): void {
  const root = document.createElement("div");
  root.id = "svadilfari-content-root";
  document.body.appendChild(root);

  ReactDOM.render(<ContentApp {...props} />, root);
}
