import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import pinia from "./stores";
import "element-plus/dist/index.css";
import "./style.css";

const app = createApp(App);

// 注册 pinia 和 router
app.use(pinia);
app.use(router);

app.mount("#app");
