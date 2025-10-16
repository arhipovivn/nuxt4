<template>
  <div class="wrapper">
    <nuxt-link to="/snake" class="btn">Змейка</nuxt-link>
    <nuxt-link to="/dinosaur" class="btn">Динозавр</nuxt-link>
  </div>
</template>
<script setup>
import { ref, onMounted, onUnmounted } from "vue";
</script>

<style>
.wrapper {
  margin-top: 20px !important;
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-direction: column;
}

.btn {
  width: 200px;
  background: #4caf50;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 5px;
  font-size: 1rem;
  cursor: pointer;
  margin-top: 1rem;
  transition: background 0.3s ease;
  margin: 0 auto;
  text-align: center;
}
</style>
