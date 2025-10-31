<script setup lang="ts">
import { isOnline, isSlowNetwork, networkError } from '@/services/api';

</script>

<template>
    <transition name="fade">
        <div v-if="!isOnline" class="bg-red-600 text-white text-center py-3 fixed top-0 left-0 right-0 z-50">
            You are offline. Please check your internet connection.
        </div>

        <div v-else-if="isSlowNetwork" class="bg-yellow-500 text-black text-center py-3 fixed top-0 left-0 right-0 z-50">
            Slow network detected. Loading is slow!
        </div>

        <div v-else-if="networkError" class="bg-gray-800 text-white text-center py-3 fixed top-0 left-0 right-0 z-50">
            {{ networkError }}
        </div>

        <div v-else-if="isOnline && networkError === null" class="bg-green-600 text-white text-center py-3 fixed top-0 left-0 right-0 z-50">
            Connection restored. Reloading...
        </div>
    </transition>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s;
}
.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}
</style>