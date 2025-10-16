<template>
  <div class="wrapper-game">
    {{ boardSize * cellSize }}
    <div
      class="dinosaur-board"
      :style="{
        width: `${boardSize * cellSize}px`,
        height: `${boardSize * cellSize}px`,
      }"
    >
      <div
        class="dino-element"
        :style="{
          left: `${dino.x * cellSize}px`,
          top: `${dino.y * cellSize}px`,
          width: `${cellSize * 2}px`,
          height: `${cellSize * 2}px`,
        }"
      >
        <img src="~/assets/images/dinosaur.png" alt="Динозавр" />
      </div>
    </div>
  </div>
</template>

<script setup>
  import { ref, onMounted, onUnmounted } from 'vue'
  const boardSize = 20
  const cellSize = 20
  const initialSpeed = 250
  const dino = ref({ x: 12, y: 15 })
</script>

<style scoped>
  .wrapper-game {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
  }

  .dinosaur-board {
    border: 2px solid #333;
    background: white;
    position: relative;
    overflow: hidden;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }

  .dinosaur-container {
    height: inherit;
    display: flex;
    justify-content: center;
    align-items: end;
  }

  .dino-element {
    position: absolute;
    transition: all 0.2s ease;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .dino-element img {
    width: 100%;
    height: 100%;
    object-fit: contain;
  }
</style>
