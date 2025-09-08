import { defineStore } from 'pinia'

// Интерфейс состояния
interface CounterState {
  count: number
}

export const useCounterStore = defineStore('state', {
  state: (): CounterState => ({
    count: 0
  }),
  getters: {
    doubleCount: (state) => state.count * 2
  },
  actions: {
    increment() {
      this.count++
    },
    setCount(newValue: number) {
      this.count = newValue
    }
  }
})
