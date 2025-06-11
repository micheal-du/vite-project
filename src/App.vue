<template>
  <el-container class="layout-container">
    <!-- 顶部导航栏 -->
    <el-header class="header">
      <div class="header-left">
        <el-button type="text" class="collapse-btn" @click="toggleCollapse">
          <el-icon :size="20">
            <Fold v-if="!isCollapse" />
            <Expand v-else />
          </el-icon>
        </el-button>
        <div class="logo">
          <h2>后台管理系统</h2>
        </div>
      </div>
      <div class="header-right">
        <el-dropdown>
          <span class="user-info">
            管理员 <el-icon><CaretBottom /></el-icon>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item>个人信息</el-dropdown-item>
              <el-dropdown-item>修改密码</el-dropdown-item>
              <el-dropdown-item divided>退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </el-header>

    <el-container class="main-container">
      <!-- 左侧导航菜单 -->
      <el-aside :width="isCollapse ? '64px' : '200px'" class="aside-menu">
        <el-menu
          :default-active="activeMenu"
          class="side-menu"
          router
          :collapse="isCollapse"
          :collapse-transition="false"
        >
          <el-menu-item index="/">
            <el-icon><House /></el-icon>
            <template #title>首页</template>
          </el-menu-item>
          <el-sub-menu index="1">
            <template #title>
              <el-icon><Document /></el-icon>
              <span>系统管理</span>
            </template>
            <el-menu-item index="/about">关于</el-menu-item>
            <el-menu-item index="/settings">设置</el-menu-item>
          </el-sub-menu>
        </el-menu>
      </el-aside>

      <!-- 右侧内容区 -->
      <el-main class="main-content">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import {
  House,
  Document,
  CaretBottom,
  Fold,
  Expand,
} from "@element-plus/icons-vue";
import { useRoute } from "vue-router";

// 菜单折叠状态
const isCollapse = ref(false);
// 当前激活的菜单
const activeMenu = computed(() => {
  const route = useRoute();
  return route.path;
});

// 切换菜单折叠状态
const toggleCollapse = () => {
  isCollapse.value = !isCollapse.value;
};
</script>

<style scoped>
.layout-container {
  height: 100vh;
  width: 100vw;
  overflow: hidden;
}

.header {
  background-color: #409eff;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0;
  height: 60px;
  position: relative;
  z-index: 1;
}

.header-left {
  display: flex;
  align-items: center;
}

.collapse-btn {
  padding: 0 15px;
  height: 60px;
  color: #fff;
  cursor: pointer;
  border: none;
  &:hover {
    background-color: rgba(255, 255, 255, 0.1);
  }
}

.logo {
  padding: 0 15px;
}

.logo h2 {
  margin: 0;
  font-size: 18px;
  white-space: nowrap;
}

.header-right {
  padding-right: 20px;
}

.user-info {
  color: #fff;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}

.main-container {
  height: calc(100vh - 60px);
}

.aside-menu {
  transition: width 0.3s;
  overflow: hidden;
}

.side-menu {
  height: 100%;
  border-right: none;
}

.el-aside {
  background-color: #fff;
  border-right: 1px solid #e6e6e6;
  overflow-x: hidden;
}

.main-content {
  padding: var(--el-main-padding);
  background-color: var(--bg-color);
  overflow-y: auto;
  min-height: calc(100vh - var(--header-height));
}

/* 内容区域布局容器 */
.content-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
}

/* 页面标题样式 */
.page-header {
  margin-bottom: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.page-title {
  font-size: 24px;
  font-weight: 500;
  color: var(--text-color);
}

/* 响应式布局 */
@media screen and (max-width: 768px) {
  .header .logo h2 {
    font-size: 16px;
  }

  .el-aside {
    position: fixed;
    height: calc(100vh - 60px);
    z-index: 1000;
    transform: translateX(0);
    transition: transform 0.3s;
  }

  .el-aside.collapsed {
    transform: translateX(-200px);
  }

  .content-container {
    padding: 0 10px;
  }

  .page-header {
    margin-bottom: 15px;
  }

  .page-title {
    font-size: 20px;
  }
}

/* 自定义滚动条样式 */
::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 3px;
}

::-webkit-scrollbar-track {
  background: #f5f7fa;
}
</style>
