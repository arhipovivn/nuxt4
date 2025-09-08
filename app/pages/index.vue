<template>
  <div>
    <div class="snake-game">
      <div class="game-container">
        <div
          class="game-board bg-blue-500"
          :style="{
            width: `${boardSize * cellSize}px`,
            height: `${boardSize * cellSize}px`,
          }"
        >
          <div
            v-if="food"
            class="food"
            :style="{
              left: `${food.x * cellSize}px`,
              top: `${food.y * cellSize}px`,
              width: `${cellSize}px`,
              height: `${cellSize}px`,
            }"
          ></div>
          <div
            v-for="(segment, index) in snake"
            :key="index"
            class="snake-segment"
            :class="{ 'snake-head': index === 0 }"
            :style="{
              left: `${segment.x * cellSize}px`,
              top: `${segment.y * cellSize}px`,
              width: `${cellSize}px`,
              height: `${cellSize}px`,
            }"
          ></div>
        </div>
      </div>
      <button
        type="button"
        class="start-btn"
        @click="startGame"
        v-if="!isGameActive"
      >
        Начать игру
      </button>
    </div>

    <div class="popup-overlay" v-if="isGameOver">
      <div class="popup-gameOver">
        <h2>Игра окончена</h2>
        <p>Ваш результат: {{ snake.length }} очков</p>
        <button @click="newGame" class="new-game-btn">Начать новую игру</button>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { ref, onMounted, onUnmounted } from 'vue'

  const boardSize = 20
  const cellSize = 20
  const initialSpeed = 250
  const isGameOver = ref(false)
  const isGameActive = ref(false)
  const gameInterval = ref(null)
  const snake = ref([
    { x: 10, y: 10 },
    { x: 9, y: 10 },
    { x: 8, y: 10 },
  ])
  const food = ref(null)
  const direction = ref('right')

  onMounted(() => {
    generateFood()
    window.addEventListener('keydown', handleKeyDown)
  })

  onUnmounted(() => {
    stopGame()
    window.removeEventListener('keydown', handleKeyDown)
  })

  const newGame = () => {
    stopGame()
    isGameOver.value = false
    isGameActive.value = true
    direction.value = 'right'
    snake.value = [
      { x: 10, y: 10 },
      { x: 9, y: 10 },
      { x: 8, y: 10 },
    ]
    generateFood()
    startGame()
  }

  const startGame = () => {
    if (isGameOver.value) return
    isGameActive.value = true
    if (gameInterval.value) {
      clearInterval(gameInterval.value)
    }
    gameInterval.value = setInterval(moveSnake, initialSpeed)
  }

  const stopGame = () => {
    if (gameInterval.value) {
      clearInterval(gameInterval.value)
      gameInterval.value = null
    }
    isGameActive.value = false
  }

  const moveSnake = () => {
    if (isGameOver.value) return

    const newHead = { ...snake.value[0] }

    switch (direction.value) {
      case 'up':
        newHead.y -= 1
        break
      case 'down':
        newHead.y += 1
        break
      case 'left':
        newHead.x -= 1
        break
      case 'right':
        newHead.x += 1
        break
    }

    if (newHead.x === food.value.x && newHead.y === food.value.y) {
      snake.value.unshift(newHead)
      generateFood()
      return
    }

    if (
      newHead.x < 0 ||
      newHead.x >= boardSize ||
      newHead.y < 0 ||
      newHead.y >= boardSize
    ) {
      endGame()
      return
    }

    snake.value.unshift(newHead)
    snake.value.pop()
  }

  const handleKeyDown = event => {
    if (isGameOver.value) return

    switch (event.key) {
      case 'ArrowUp':
        if (direction.value !== 'down') direction.value = 'up'
        break
      case 'ArrowDown':
        if (direction.value !== 'up') direction.value = 'down'
        break
      case 'ArrowLeft':
        if (direction.value !== 'right') direction.value = 'left'
        break
      case 'ArrowRight':
        if (direction.value !== 'left') direction.value = 'right'
        break
    }
  }

  const generateFood = () => {
    let newFood
    do {
      newFood = {
        x: Math.floor(Math.random() * boardSize),
        y: Math.floor(Math.random() * boardSize),
      }
    } while (
      snake.value.some(
        segment => segment.x === newFood.x && segment.y === newFood.y
      )
    )

    food.value = newFood
  }

  const endGame = () => {
    isGameOver.value = true
    stopGame()
  }
</script>

<style>
  .snake-game {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    gap: 20px;
    margin: 42px;
  }
  .snake-segment {
    position: absolute;
    background: #4caf50;
    border: 1px solid #388e3c;
    border-radius: 2px;
  }
  .snake-head {
    background: #065108;
  }
  .food {
    position: absolute;
    background: #ff5722;
    border-radius: 50%;
  }

  .popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.7);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .popup-gameOver {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    min-width: 300px;
  }

  .popup-gameOver h2 {
    color: #d32f2f;
    margin-bottom: 1rem;
    font-size: 1.5rem;
  }

  .popup-gameOver p {
    color: #666;
    margin-bottom: 1.5rem;
    font-size: 1.1rem;
  }

  .new-game-btn {
    background: #4caf50;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s ease;
  }

  .new-game-btn:hover {
    background: #388e3c;
  }

  .start-btn {
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
  }

  .start-btn:hover {
    background: #388e3c;
  }

  .game-board {
    position: relative;
    margin: 0 auto;
  }
</style>
