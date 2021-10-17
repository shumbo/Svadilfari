import React from "react";
import Layout from "@theme/Layout";
import Head from "@docusaurus/Head";

export default function Home() {
  return (
    <Layout description="Gesture Control for Safari">
      <Head>
        <link
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
          rel="stylesheet"
        />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link
          href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@0,600;1,600&amp;display=swap"
          rel="stylesheet"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,300;0,500;0,600;0,700;1,300;1,500;1,600;1,700&amp;display=swap"
          rel="stylesheet"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,400;1,400&amp;display=swap"
          rel="stylesheet"
        />
        <link href="/lp/styles.css" rel="stylesheet" />
        <link href="/lp/custom.css" rel="stylesheet" />
      </Head>
      <div
        className="lp-wrapper"
        dangerouslySetInnerHTML={{
          __html: `<!-- Mashead header-->
          <header class="masthead">
            <div class="container px-5">
              <div class="row gx-5 align-items-center">
                <div class="col-lg-6">
                  <!-- Mashead text and app badges-->
                  <div class="mb-5 mb-lg-0 text-center text-lg-start">
                    <img
                      class="header-app-icon mb-5"
                      src="/lp/img/icon.svg"
                      alt="Download Svadilfari on the App Store"
                    />
                    <h1 class="display-1 lh-1 mb-1">Svadilfari</h1>
                    <p class="h2 mb-1">Gesture Control for Safari</p>
                    <p class="lead fw-normal text-muted mb-5">
                      Svadilfari lets you control Safari with gestures. Try out a new
                      web browsing experience on iPhone and iPad.
                    </p>
                    <div
                      class="d-flex flex-column flex-lg-row align-items-center mb-1"
                    >
                      <a href="https://apps.apple.com/us/app/svadilfari/id1586432379"
                        ><img
                          class="app-badge"
                          src="/lp/img/app-store-badge.svg"
                          alt="Download Svadilfari on the App Store"
                      /></a>
                    </div>
                    <p class="text-muted">Free. Requires iOS 15 or later.</p>
                  </div>
                </div>
                <div class="col-lg-6 d-flex justify-content-center">
                  <video autoplay loop muted playsinline class="header-video-demo">
                    <source
                      src="/lp/hero-demo_hevc.mp4"
                      type='video/mp4; codecs="hvc1"'
                    />
                    <source
                      src="/lp/hero-demo.mp4"
                      type='video/mp4; codecs="avc1"'
                    />
                  </video>
                </div>
              </div>
            </div>
          </header>
          <!-- App features section-->
          <section id="features">
            <div class="container px-5">
              <div class="row gx-5 align-items-center">
                <div class="col-lg-8 order-lg-1 mb-5 mb-lg-0">
                  <div class="container-fluid px-5">
                    <div class="row gx-5">
                      <div class="col-md-6 mb-5">
                        <!-- Feature item-->
                        <div class="text-center">
                          <i class="bi-hand-index icon-feature d-block mb-3"></i>
                          <h3 class="font-alt">Custom Gesture</h3>
                          <p class="text-muted mb-0">
                            Customize your settings and use your favorite gestures to
                            control Safari.
                          </p>
                        </div>
                      </div>
                      <div class="col-md-6 mb-5">
                        <!-- Feature item-->
                        <div class="text-center">
                          <i class="bi-braces icon-feature d-block mb-3"></i>
                          <h3 class="font-alt">10+ Actions</h3>
                          <p class="text-muted mb-0">
                            Svadilfari supports more than 10 actions, such as creating
                            tabs, copying URLs, and executing JavaScript.
                          </p>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6 mb-5 mb-md-0">
                        <!-- Feature item-->
                        <div class="text-center">
                          <i class="bi-slash-circle icon-feature d-block mb-3"></i>
                          <h3 class="font-alt">Exclusion List</h3>
                          <p class="text-muted mb-0">
                            Disable gestures on specific domains and URLs.
                          </p>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <!-- Feature item-->
                        <div class="text-center">
                          <i class="bi-patch-check icon-feature d-block mb-3"></i>
                          <h3 class="font-alt">Free</h3>
                          <p class="text-muted mb-0">
                            Svadilfari is available on the App Store for free!
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4 order-lg-0">
                  <!-- Features section device mockup-->
      
                  <div class="features-device-mockup">
                    <div class="device-wrapper">
                      <div
                        class="device"
                        data-device="iPhoneX"
                        data-orientation="portrait"
                        data-color="black"
                      >
                        <div class="screen bg-black">
                          <!-- PUT CONTENTS HERE:-->
                          <!-- * * This can be a video, image, or just about anything else.-->
                          <!-- * * Set the max width of your media to 100% and the height to-->
                          <!-- * * 100% like the demo example below.-->
                          <img
                            src="/lp/img/gesture-screen.png"
                            style="max-width: 100%; height: 100%"
                            alt="gesture screen"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- Basic features section-->
          <section class="bg-light">
            <div class="container px-5">
              <div
                class="
                  row
                  gx-5
                  align-items-center
                  justify-content-center justify-content-lg-between
                "
              >
                <div class="col-12 col-lg-5">
                  <h2 class="display-4 lh-1 mb-4">Browse the Web like a Pro</h2>
                  <p class="lead fw-normal text-muted mb-3 mb-lg-3">
                    With the introduction of Safari Extensions in iOS 15, it is now
                    possible to extend Safari in ways that were previously impossible.
                  </p>
                  <p class="lead fw-normal text-muted mb-5 mb-lg-0">
                    Svadilfari was created to make browsing easier for users who
                    browse the web a lot.
                  </p>
                </div>
                <div class="col-sm-8 col-md-6">
                  <div class="px-5 px-sm-0">
                    <img
                      class="img-fluid rounded-circle"
                      src="https://source.unsplash.com/oyXis2kALVg/900x900"
                      alt="web"
                    />
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- App badge section-->
          <section class="bg-gradient-primary-to-secondary" id="download">
            <div class="container px-5">
              <h2 class="text-center text-white font-alt mb-4">Get the app now!</h2>
              <div
                class="
                  d-flex
                  flex-column flex-lg-row
                  align-items-center
                  justify-content-center
                "
              >
                <a href="https://apps.apple.com/us/app/svadilfari/id1586432379"
                  ><img
                    class="app-badge"
                    src="/lp/img/app-store-badge.svg"
                    alt="Download on the App Store"
                /></a>
              </div>
            </div>
          </section>
          <!-- Bootstrap core JS-->
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
          <!-- Core theme JS-->
          <script src="js/scripts.js"></script>`,
        }}
      />
    </Layout>
  );
}
