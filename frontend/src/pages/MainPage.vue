<template>
    <div class="bg-gray-100 min-h-screen">
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

        <!-- router-view -->
         <router-view/>

        <!-- footer -->
        <footer class="bg-uniscape-blue text-white py-12">
            <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8">

                <!-- Logo and description -->
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <img src="/uniscape-icon.png" alt="Uniscape logo" class="h-12">
                        <h3 class="text-2xl font-bold text-uniscape-yellow">Uniscape</h3>
                    </div>
                    <p class="text-gray-200 leading-relaxed text-sm">
                        Empowering Africa's next generation of tech talent through hands-on, 
                        project-based learning and global opportunities.
                    </p>
                </div>

                <!-- Quick Links -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Quick Links</h4>
                    <ul class="space-y-2">
                        <li><a href="#home" class="hover:text-uniscape-yellow transition">Home</a></li>
                        <li><a href="#about" class="hover:text-uniscape-yellow transition">About Us</a></li>
                        <li><a href="#programs" class="hover:text-uniscape-yellow transition">Programs</a></li>
                        <li><a href="#community" class="hover:text-uniscape-yellow transition">Community</a></li>
                        <li><a href="#contacts" class="hover:text-uniscape-yellow transition">Contact Us</a></li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Contact</h4>
                    <ul class="space-y-3 text-sm">
                        <li class="flex items-center gap-3">
                            <img src="/map-pin-house.png" width="28" alt="location" class="bg-uniscape-yellow rounded-full p-1">
                            <span>Blue Violets Plaza, Kindaruma Rd, Nairobi</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <img src="/phone.png" width="28" alt="phone" class="rounded-full bg-uniscape-yellow p-1">
                            <span>+254 700 223 222</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <img src="/mail.png" width="28" alt="email" class="rounded-full bg-uniscape-yellow p-1">
                            <a href="mailto:info@uniscape.co.ke" class="hover:text-uniscape-yellow underline">info@uniscape.co.ke</a>
                        </li>
                    </ul>
                </div>

                <!-- Socials -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Follow Us</h4>
                    <div class="flex space-x-4">
                        <a href="#" aria-label="Facebook" class="hover:scale-110 transition transform">
                            <img src="/facebook.png" alt="Facebook" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="Twitter" class="hover:scale-110 transition transform">
                            <img src="/twitter.png" alt="Twitter" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="LinkedIn" class="hover:scale-110 transition transform">
                            <img src="/linkedin.png" alt="LinkedIn" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="Instagram" class="hover:scale-110 transition transform">
                            <img src="/instagram.png" alt="Instagram" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                    </div>
                </div>
            </div>

            <!-- Divider -->
            <div class="border-t border-yellow-400 my-8"></div>

            <!-- Bottom Copyright -->
            <div class="text-center text-sm text-gray-200">
                © {{ new Date().getFullYear() }} Uniscape Consulting. All rights reserved.
            </div>
        </footer>
    </div>
</template>

<script>
import ProgramSection from '@/components/ProgramSection.vue';
import api from '@/services/api';

export default {
    data() {
        return {
            showMenu: false,
            partners: [
                { image: "/ajira.png" },
                { image: "/google.png" },
                { image: "/huawei.svg" },
                { image: "/icta.png" },
                { image: "/mastercard-foundation.png" },
                { image: "/microsoft.png" },
                { image: "/oracle.png" },
                { image: "/safaricom-foundation.jpg" }
            ],
            images: [
                '/code1.jpg',
                '/code3.jpg',
                // '/code4.jpg',
                '/code5.jpg',
                '/code6.jpg',
                '/code7.jpg'
            ],

            currentIndex: 0,
            interval: null,
            allCourses: []
        }
    },
    methods: {

        async fetchAllCourses() {
            const response = await api.get('all_courses');
            this.allCourses = response.data;
        },

        scrollToSection(id) {
            const el = document.getElementById(id)
            if (el) {
                el.scrollIntoView({ behavior: 'smooth'});
            }
        },
        toggleMenu() {
            this.showMenu = !this.showMenu;
        },

        nextImage(){
            this.currentIndex = (this.currentIndex + 1) % this.images.length;
            this.restartAutoSlide();
        },

        prevImage(){
            this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length;
            this.restartAutoSlide();
        },

        startAutoSlide(){
            this.interval = setInterval(() => {
                this.nextImage();
            }, 5000);
        },

        restartAutoSlide(){
            clearInterval(this.interval);
            this.startAutoSlide();
        },
    },

    mounted() {
        this.fetchAllCourses();
        this.startAutoSlide();
    },

    beforeUnmount(){
        clearInterval(this.interval);
    }
};

</script>

<style scoped>
.slide-enter-active, .slide-leave-active {
    transition: transform 0.3s ease;
}
.slide-enter-from, .slide-leave-to {
    transform: translateX(-100%);
}

@keyframes marquee {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
}
.animate-marquee {
    animation: marquee 30s linear infinite;
}
</style>