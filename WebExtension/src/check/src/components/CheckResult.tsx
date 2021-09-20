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
import { t } from "react-i18nify";

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
          <Text>{t("check_result.check_in_progress")}</Text>
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
          {t("check_result.active.title")}
        </AlertTitle>
        <AlertDescription maxWidth="sm">
          {t("check_result.active.description")}
        </AlertDescription>
        <AlertDescription mt={2}>
          <Button colorScheme="green" onClick={onOpenApp}>
            {t("check_result.app_link")}
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
        {t("check_result.inactive.title")}
      </AlertTitle>
      <AlertDescription maxWidth="sm">
        {t("check_result.inactive.description")}
      </AlertDescription>
      <AlertDescription mt={2}>
        <Button colorScheme="orange" onClick={onOpenApp}>
          {t("check_result.app_link")}
        </Button>
      </AlertDescription>
      <AlertDescription mt={4}>解決しませんか？</AlertDescription>
      <AlertDescription mt={2}>
        <Button
          colorScheme="orange"
          variant="link"
          as="a"
          href="https://rebrand.ly/svadilfari-contact"
        >
          お問い合わせください
        </Button>
      </AlertDescription>
    </Alert>
  );
};
