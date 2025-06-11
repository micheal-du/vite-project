<template>
  <div class="content-container">
    <div class="page-header">
      <h2 class="page-title">首页</h2>
    </div>

    <el-row :gutter="20">
      <el-col :xs="24" :sm="12" :md="6">
        <el-card shadow="hover" class="data-card">
          <template #header>
            <div class="card-header">
              <span>总访问量</span>
              <el-tag size="small">月</el-tag>
            </div>
          </template>
          <div class="card-content">
            <div class="data-value">12,345</div>
            <div class="data-info">
              <span>同比增长</span>
              <span class="growth-rate positive">+15%</span>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 更多数据卡片 -->
    </el-row>

    <el-row :gutter="20">
      <el-col :xs="24" :lg="16">
        <el-card class="chart-card">
          <template #header>
            <div class="card-header">
              <span>数据统计</span>
            </div>
          </template>
          <div class="chart-content">
            <!-- 图表内容 -->
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :lg="8">
        <el-card class="list-card">
          <template #header>
            <div class="card-header">
              <span>最新动态</span>
            </div>
          </template>
          <div class="list-content">
            <!-- 列表内容 -->
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { useCounterStore } from "@/stores/counter";

const store = useCounterStore();
</script>

<style scoped>
.data-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-content {
  text-align: center;
  padding: 10px 0;
}

.data-value {
  font-size: 24px;
  font-weight: bold;
  color: var(--text-color);
  margin-bottom: 10px;
}

.data-info {
  font-size: 14px;
  color: #666;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.growth-rate {
  font-weight: 500;
  &.positive {
    color: #67c23a;
  }
  &.negative {
    color: #f56c6c;
  }
}

.chart-content {
  height: 350px;
}

.list-content {
  height: 350px;
  overflow-y: auto;
}

@media screen and (max-width: 768px) {
  .data-card {
    margin-bottom: 15px;
  }

  .data-value {
    font-size: 20px;
  }

  .chart-content,
  .list-content {
    height: 300px;
  }
}
</style>
