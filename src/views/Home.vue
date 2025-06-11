<template>
  <div class="home">
    <h1>首页</h1>
    <div class="counter">
      <p>当前计数: {{ counter.count }}</p>
      <p>双倍计数: {{ counter.doubleCount }}</p>
      <button @click="counter.increment">+1</button>
      <button @click="counter.decrement">-1</button>
    </div>
  </div>
</template>

<script setup>
import { useCounterStore } from "@/stores/counter";

const counter = useCounterStore();
</script>

<style scoped>
.counter {
  margin-top: 20px;
}

button {
  margin: 0 5px;
  padding: 5px 10px;
}
</style>
