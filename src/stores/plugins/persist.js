import { watch } from "vue";

export function createPersistedState() {
  return ({ store }) => {
    // 检查 store 的 persist 配置是否存在
    const persist = store.$options?.persist;
    if (!persist?.enabled) return;

    try {
      // 获取持久化配置
      const { strategies = [] } = persist;

      // 从本地存储恢复状态
      strategies.forEach(({ key, storage = localStorage }) => {
        try {
          const savedState = storage.getItem(key);
          if (savedState) {
            store.$patch(JSON.parse(savedState));
          }

          // 监听状态变化自动持久化
          watch(
            () => store.$state,
            (state) => {
              storage.setItem(key, JSON.stringify(state));
            },
            { deep: true }
          );
        } catch (error) {
          console.error(`持久化存储错误 (${key}):`, error);
        }
      });
    } catch (error) {
      console.error("Pinia 持久化插件错误:", error);
    }
  };
}
