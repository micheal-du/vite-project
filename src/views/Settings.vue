<template>
  <div class="settings">
    <h1>设置页面</h1>
    <el-card class="settings-card">
      <template #header>
        <div class="card-header">
          <span>系统设置</span>
        </div>
      </template>
      <div class="settings-content">
        <!-- 设置内容 -->
      </div>
    </el-card>
  </div>
</template>

<script setup>
// 设置页面逻辑
</script>

<style scoped>
.settings-card {
  max-width: 800px;
  margin: 20px auto;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
