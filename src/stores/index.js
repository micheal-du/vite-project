import { createPinia } from "pinia";
import { createPersistedState } from "./plugins/persist";

const pinia = createPinia();

// 注册持久化插件
pinia.use(createPersistedState());

export default pinia;
