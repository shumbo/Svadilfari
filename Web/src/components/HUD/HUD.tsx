import styled from "@emotion/styled";
import React, { VFC } from "react";
import { animated, useTransition } from "@react-spring/web";

export type HUDContent = {
  /**
   * Icon
   * Load svg via svgr and pass the component
   */
  icon?: VFC<React.SVGProps<SVGSVGElement>>;
  /**
   * Title
   */
  title: string;
  /**
   * Message
   */
  message?: string;
};

export type HUDProps = {
  className?: string;
  /**
   * Control visibility of the HUD
   */
  visible: boolean;
  /**
   * Change the leave animation
   */
  cancel: boolean;
} & HUDContent;

export const HUD: VFC<HUDProps> = ({
  visible,
  icon: Icon,
  title,
  message,
  cancel,
}) => {
  const transitions = useTransition(visible, {
    from: { opacity: 0, scale: 0.8 },
    enter: { opacity: 1, scale: 1 },
    leave: { opacity: 0, scale: cancel ? 0.8 : 1.2 },
    config: {
      duration: 167,
    },
  });

  return transitions(
    ({ opacity, scale }, item) =>
      item && (
        <animated.div
          style={{
            opacity,
            scale,
            position: "fixed",
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            zIndex: 2147483647,
          }}
        >
          <Wrapper>
            {Icon && (
              <IconWrapper>
                <Icon style={{ width: 100, height: 100 }} />
              </IconWrapper>
            )}
            <Title>{title}</Title>
            {message && <Message>{message}</Message>}
          </Wrapper>
        </animated.div>
      )
  );
};

const Wrapper = styled.div`
  width: 250px;
  height: 250px;
  backdrop-filter: blur(3px);
  border-radius: 8px;
  background-color: rgba(255, 255, 255, 0.8);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  @media (prefers-color-scheme: dark) {
    background-color: rgba(0, 0, 0, 0.8);
  }
`;

const IconWrapper = styled.div`
  fill: #636366ff;
  @media (prefers-color-scheme: dark) {
    fill: #aeaeb2ff;
  }
`;

const Text = styled.p`
  text-align: center;
  margin: 0;
  font-family: -apple-system;
  color: #636366ff;
  @media (prefers-color-scheme: dark) {
    color: #aeaeb2ff;
  }
`;

const Title = styled(Text)`
  font-size: 24px;
`;
const Message = styled(Text)``;
