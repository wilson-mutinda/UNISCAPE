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
                        <a @click.prevent="goToSection('home')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#home"
                            >Home</a
                        >
                        <a @click.prevent="goToSection('about')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#about"
                            >About Us</a
                        >
                        <a @click.prevent="goToSection('programs')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#programs"
                            >Programs</a
                        >
                        <a @click.prevent="goToSection('community')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#community"
                            >Community</a
                        >
                        <a @click.prevent="goToSection('contacts')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a @click.prevent="goToSection('faqs')"
                         class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition" 
                         href="#faqs">FAQS</a>
                        <a @click="goToSection('programs')"
                            class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition"
                            href="#programs"
                            >Login</a
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
                            @click.prevent="toggleMenu"
                            type="button"
                            class="self-end mb-4 text-uniscape-blue font-bold"
                        >
                            <img src="/close.png" alt="close" width="30" />
                        </button>

                        <a
                            @click.prevent="goToMobileSection('home')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#home"
                            >Home</a
                        >
                        <a
                            @click.prevent="goToMobileSection('about')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#about"
                            >About Us</a
                        >
                        <a
                            @click.prevent="goToMobileSection('programs')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#programs"
                            >Programs</a
                        >
                        <a
                            @click.prevent="goToMobileSection('community')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#community"
                            >Community</a
                        >
                        <a
                            @click.prevent="goToMobileSection('contacts')"
                            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a
                         @click.prevent="goToMobileSection('faqs')" 
                         href="#faqs" 
                         class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left">
                         FAQS</a>
                        <a
                            @click.prevent="goToMobileSection('programs')"
                            class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 w-full text-center"
                            href="#programs"
                            >Login</a
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
        },

        goToSection(id) {
            if (this.$route.path !== '/home' && this.$route.path !== '/')
            this.$router.push('/home').then(() => {
                setTimeout(() => {
                    const el = document.getElementById(id);
                    if (el) el.scrollIntoView({ behavior: 'smooth'});
                }, 500);
        });
        else {
            const el = document.getElementById(id);
            if (el) el.scrollIntoView({ behavior: 'smooth'});
        }
        },

        goToMobileSection(id) {
            this.toggleMenu();
            setTimeout(() => {
                this.goToSection(id);
            }, 300);
        }
    }
}
</script>
