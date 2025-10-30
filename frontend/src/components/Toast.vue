<template>
    <transition name="fade">
        <div class="">
            <!-- close button -->
             <button type="button" @click="closeModal">
                <!-- <img src="/close.png" alt="close" width="20"> -->
             </button>
            <div v-if="visible" class="fixed top-10 right-6 bg-green-600 text-white px-6 py-3 rounded-lg shadow-lg text-sm font-medium flex items-center gap-3 z-50">
                <img src="/check.png" alt="check" width="20" v-if="icon">
                <span>{{ message }}</span>
            </div>
        </div>
    </transition>
</template>

<script>
export default {
    props: {
        message: String,
        icon: Boolean
    },

    data() {
        return {
            visible: false,
        };
    },

    methods: {
        show() {
            this.visible = true;
            setTimeout(() => {
                this.visible = false
            }, 5000);
        },

        closeModal() {
            this.visible = false
        }
    }
}
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}
</style>
