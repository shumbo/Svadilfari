import { Global, css } from "@emotion/react";
import React, { VFC } from "react";

const styles = css`
  body {
    width: min(${window.screen.width}px, 400px);
    margin: 0 auto;
  }
`;

export const PopupGlobalStyle: VFC = () => {
  return <Global styles={styles} />;
};
