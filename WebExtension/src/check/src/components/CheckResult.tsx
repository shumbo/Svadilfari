import {
  Flex,
  Spinner,
  VStack,
  Text,
  Alert,
  AlertIcon,
  AlertTitle,
  AlertDescription,
  Button,
} from "@chakra-ui/react";
import React, { VFC } from "react";

export type CheckResultProps = {
  status: "ACTIVE" | "INACTIVE" | null;
  onOpenApp: () => void;
};

export const CheckResult: VFC<CheckResultProps> = ({ status, onOpenApp }) => {
  if (status === null) {
    return (
      <Flex height="100%" justifyContent="center" alignItems="center">
        <VStack>
          <Spinner />
          <Text>Check in progress...</Text>
        </VStack>
      </Flex>
    );
  }
  if (status === "ACTIVE") {
    return (
      <Alert
        status="success"
        variant="subtle"
        flexDirection="column"
        alignItems="center"
        justifyContent="center"
        textAlign="center"
        height="100%"
      >
        <AlertIcon boxSize="40px" mr={0} />
        <AlertTitle mt={4} mb={1} fontSize="lg">
          Svadilfari is Active!
        </AlertTitle>
        <AlertDescription maxWidth="sm">
          Gestures should work now!
        </AlertDescription>
        <AlertDescription mt={2}>
          <Button colorScheme="green" onClick={onOpenApp}>
            Open Svadilfari
          </Button>
        </AlertDescription>
      </Alert>
    );
  }
  return (
    <Alert
      status="warning"
      variant="subtle"
      flexDirection="column"
      alignItems="center"
      justifyContent="center"
      textAlign="center"
      height="100%"
    >
      <AlertIcon boxSize="40px" mr={0} />
      <AlertTitle mt={4} mb={1} fontSize="lg">
        Svadilfari is NOT Active!
      </AlertTitle>
      <AlertDescription maxWidth="sm">
        Follow the tutorial to activate the extension
      </AlertDescription>
      <AlertDescription mt={2}>
        <Button colorScheme="orange" onClick={onOpenApp}>
          Open Svadilfari
        </Button>
      </AlertDescription>
    </Alert>
  );
};
