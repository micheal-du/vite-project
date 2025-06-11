import { defineStore } from "pinia";
import { ElMessage } from "element-plus";

export const useCounterStore = defineStore({
  id: "counter",

  state: () => ({
    count: 0,
    name: "Counter",
    loading: false,
  }),

  getters: {
    doubleCount: (state) => state.count * 2,
  },

  actions: {
    async increment() {
      try {
        this.loading = true;
        await new Promise((resolve) => setTimeout(resolve, 1000));
        this.count++;
      } catch (error) {
        console.error("增加计数失败:", error);
        ElMessage.error("操作失败");
      } finally {
        this.loading = false;
      }
    },

    reset() {
      this.$reset();
    },
  },

  persist: {
    enabled: true,
    strategies: [
      {
        key: "counter",
        storage: localStorage,
      },
    ],
  },
});
