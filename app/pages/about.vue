<script setup>
  import {
    ref,
    computed,
    watch,
    onBeforeMount,
    onMounted,
    onBeforeUpdate,
    onUpdated,
    onBeforeUnmount,
    onUnmounted,
  } from 'vue'
  import { storeToRefs } from 'pinia'
  import { useCounterStore } from '~/store/state'

  /* -------------------------------------------
  Options API: data() { return { inputValue: 3 } }
------------------------------------------- */
  const inputValue = ref(3)

  /* -------------------------------------------
  Options API: props: { initialValue: Number }
  В Composition API через defineProps
------------------------------------------- */
  const props = defineProps({
    initialValue: Number,
  })

  if (props.initialValue !== undefined) {
    inputValue.value = props.initialValue
  }

  /* -------------------------------------------
  Options API: emits: ['update']
------------------------------------------- */
  const emit = defineEmits(['update'])

  /* -------------------------------------------
  Options API: methods: { addOne() { this.inputValue++ } }
------------------------------------------- */
  const addOne = () => {
    inputValue.value++
    console.log('Текущее значение inputValue:', inputValue.value)
    emit('update', inputValue.value)
  }

  /* -------------------------------------------
  Options API: computed: { doubleCount() { return this.inputValue * 2 } }
------------------------------------------- */
  const doubleCount = computed(() => inputValue.value * 2)

  /* -------------------------------------------
  Options API: watch: { inputValue(newVal) { ... } }
------------------------------------------- */
  watch(inputValue, (newValue, oldValue) => {
    console.log('Watcher: новое значение inputValue:', newValue)
  })

  /* -------------------------------------------
  Options API: жизненный цикл
------------------------------------------- */
  onBeforeMount(() => console.log('beforeMount'))
  onMounted(() => console.log('mounted'))
  onBeforeUpdate(() => console.log('beforeUpdate'))
  onUpdated(() => console.log('updated'))
  onBeforeUnmount(() => console.log('beforeUnmount'))
  onUnmounted(() => console.log('unmounted'))

  /* -------------------------------------------
  Options API: работа с Pinia store
------------------------------------------- */
  const counter = useCounterStore()
  const { count, doubleCount: storeDoubleCount } = storeToRefs(counter)
</script>

<template>
  <div>
    <h1 class="mt-4">Счётчик: {{ inputValue }}</h1>
    <h2>Удвоенное значение: {{ doubleCount }}</h2>
    <h2>Store count: {{ count }}</h2>
    <h2>Store doubleCount: {{ storeDoubleCount }}</h2>
    <button
      class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600"
    >
      Красивая кнопка с Tailwind
    </button>
    <input
      type="number"
      v-model.number="inputValue"
      placeholder="Введите число"
      class="border p-2 rounded"
    />
    <button @click="addOne" class="bg-blue-500 text-white p-2 rounded ml-2">
      +
    </button>

    <div class="bg-gray-100 p-8 mt-4">
      <h1 class="text-3xl font-bold text-blue-600">
        Tailwind + Nuxt UI работает!
      </h1>
      <UButton class="mt-4" color="primary">Кнопка от Nuxt UI</UButton>
    </div>
  </div>
</template>
