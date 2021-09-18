import type { NextPage } from "next";
import Head from "next/head";
import { Text } from "@chakra-ui/react";
import styles from "../styles/Home.module.css";

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Svadilfari</title>
        <meta name="description" content="Gesture Control for Safari" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <h1>
          <Text
            bgGradient="linear(to-l, #7928CA, #FF0080)"
            bgClip="text"
            fontSize="6xl"
            fontWeight="extrabold"
          >
            Svadilfari
          </Text>
        </h1>
      </main>
    </div>
  );
};

export default Home;
