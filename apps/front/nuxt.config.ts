// https://nuxt.com/docs/api/configuration/nuxt-config
import svgLoader from "vite-svg-loader";
import dotenv from "dotenv"; // Load .env variables

dotenv.config(); // Load environment variables from .env

export default defineNuxtConfig({
  srcDir: "src/",
  modules: ["@pinia/nuxt", "@nuxtjs/i18n", "nuxt-primevue"],
  runtimeConfig: {
    API_URL: process.env.API_URL || "",
    googleMapsApiKey: process.env.GOOGLE_MAPS_API_KEY || "",
    public: {
      googleMapsApiKey: process.env.GOOGLE_MAPS_API_KEY || "",
    },
  },
  primevue: {
    options: {
      unstyled: false,
    },
  },
  i18n: {
    vueI18n: "./modules_config/nuxt/i18n.config.ts",
  },
  app: {
    head: {
      charset: "utf-8",
      viewport: "width=device-width, initial-scale=1",
      title: "Boilerplate TCM v2",
      meta: [
        { name: "description", content: "Boilerplate Symfony / Nuxt / Docker" },
      ],
      link: [
        {
          rel: "icon",
          type: "image/svg+xml",
          href: "/favicon.svg",
        },
      ],
      script: [
        {
          src: `https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places`,
          async: true,
          defer: true,
        },
      ],
    },
  },
  css: [
    "primeflex/primeflex.css",
    "primeicons/primeicons.css",
    "primevue/resources/themes/lara-light-blue/theme.css",
    "@/assets/styles/main.scss",
  ],
  vite: {
    plugins: [svgLoader()],
    css: {
      preprocessorOptions: {
        scss: {
          additionalData:
            '@import "@/assets/styles/_functions.scss";@import "@/assets/styles/_variables.scss";@import "@/assets/styles/_mixins.scss";',
        },
      },
    },
  },
  watch: [
    "src/assets/styles/_functions.scss",
    "src/assets/styles/_variables.scss",
    "src/assets/styles/_mixins.scss",
    "src/assets/styles/main.scss",
  ],
});
