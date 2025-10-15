<template>
    <!-- navbar -->
     <nav class="bg-white fixed inset-x-0 top-0 shadow-md z-50">
            <div class="container mx-auto w-full px-4">
                <!-- logo and menu -->
                <div class="flex items-center justify-between h-20">
                    <!-- logo -->
                    <div class="flex items-center gap-2">
                        <img
                            src="/uniscape-logo.png"
                            alt="uniscape-icon"
                            class="w-auto h-20 object-contain"
                        />
                    </div>

                    <!-- menu -->
                    <div class="hidden md:flex items-center gap-4">
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#home"
                            >Home</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#about"
                            >About Us</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#programs"
                            >Programs</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#community"
                            >Community</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a
                         class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition" 
                         href="#faqs">FAQS</a>
                        <a
                            class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition"
                            href="#"
                            >Get Started</a
                        >
                    </div>

                    <!-- mobile menu -->
                    <div class="block md:hidden">
                        <button type="button" @click="toggleMenu">
                            <img src="/logs.png" alt="logs" width="30" />
                        </button>
                    </div>
                </div>

                <!-- mobile menu component -->
                <transition name="slide">
                    <div
                        v-if="showMenu"
                        class="fixed inset-0 left-0 w-64 bg-uniscape-yellow shadow-lg z-40 flex flex-col items-start p-6 space-y-3 md:hidden"
                    >
                        <button
                            @click="toggleMenu"
                            type="button"
                            class="self-end mb-4 text-uniscape-blue font-bold"
                        >
                            <img src="/close.png" alt="close" width="30" />
                        </button>

                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#home"
                            >Home</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#about"
                            >About Us</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#programs"
                            >Programs</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#community"
                            >Community</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a href="#faqs" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left">FAQS</a>
                        <a
                            @click="toggleMenu"
                            class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 w-full text-center"
                            href="#"
                            >Get Started</a
                        >
                    </div>
                </transition>
            </div>
        </nav>
</template>

<script>
export default {
    data() {
        return {
            showMenu: false
        }
    },

    methods: {
        toggleMenu() {
            this.showMenu = !this.showMenu
        }
    }
}
</script>
