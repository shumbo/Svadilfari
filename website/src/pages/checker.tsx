import { NextPage } from "next";
import {
  Container,
  Center,
  Spinner,
  Alert,
  AlertIcon,
  AlertTitle,
  AlertDescription,
} from "@chakra-ui/react";
import { useEffect, useState } from "react";

const Checker: NextPage = () => {
  const [enabled, setEnabled] = useState<boolean | null>(null);
  useEffect(() => {
    let subscribed = true;

    function check(remainingAttempt: number) {
      if (!subscribed) {
        return;
      }
      if (remainingAttempt === 0) {
        setEnabled(false);
        return;
      }
      const contentRoot = document.getElementById("svadilfari-content-root");
      if (contentRoot) {
        setEnabled(true);
        return;
      }
      setTimeout(() => {
        check(remainingAttempt - 1);
      }, 1000);
    }
    check(5);

    return () => {
      subscribed = false;
    };
  }, []);

  if (enabled === null) {
    return (
      <Center width="100%" height="100%">
        <Spinner />
      </Center>
    );
  }
  if (enabled) {
    return (
      <Container>
        <Alert status="success">
          <AlertIcon />
          Svadilfari is enabled!
        </Alert>
      </Container>
    );
  }
  return (
    <Container>
      <Alert status="error">
        <AlertIcon />
        <AlertTitle mr={2}>Svadilfari is not enabled!</AlertTitle>
        <AlertDescription>
          Please make sure you followed each step of the tutorial
        </AlertDescription>
      </Alert>
    </Container>
  );
};

export default Checker;
