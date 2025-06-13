import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { ElementPlusResolver } from "unplugin-vue-components/resolvers";

export default defineConfig({
  base:'/myproject/',
  plugins: [
    vue(),
    // 自动导入 Element Plus 相关 API
    AutoImport({
      // 自动导入 Vue 相关函数，如：ref, reactive, toRef 等
      imports: ["vue", "vue-router", "pinia"],
      resolvers: [ElementPlusResolver()],
      // 生成 TypeScript 声明文件
      dts: "src/auto-imports.d.ts",
      eslintrc: {
        enabled: true,
      },
    }),
    // 自动导入 Element Plus 组件
    Components({
      resolvers: [ElementPlusResolver()],
      dts: "src/components.d.ts",
    }),
  ],
  server: {
    allowedHosts:['.ngrok-free.app', 'localhost', '127.0.0.1']
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  // 构建优化配置
  build: {
    // 代码分割配置
    rollupOptions: {
      output: {
        // 分包策略
        manualChunks: (id) => {
          if (id.includes('node_modules')) {
            if (id.includes('element-plus')) {
              return 'element-plus';
            }
            if (id.includes('vue') || id.includes('pinia') || id.includes('vue-router')) {
              return 'vue-vendor';
            }
            return 'vendor';
          }
        },
      },
    },
    // 启用 CSS 代码分割
    cssCodeSplit: true,
    // 设置块大小警告限制
    chunkSizeWarningLimit: 1000,
    // 启用压缩
    minify: "terser",
    terserOptions: {
      compress: {
        // 生产环境移除 console
        drop_console: true,
        drop_debugger: true,
      },
    },
  },
  // CSS 相关优化
  css: {
    preprocessorOptions: {
      scss: {
        // 如果需要自定义 Element Plus 主题，可以在这里添加变量文件
        // additionalData: `@use "@/styles/element/index.scss" as *;`
      },
    },
  },
});
