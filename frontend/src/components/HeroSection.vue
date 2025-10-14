<template>
    <!-- Hero Section with Background Carousel -->
        <section
        id="home"
        class="relative w-full h-[90vh] flex items-center justify-center text-center text-white overflow-hidden"
        >
        <!-- Background Carousel -->
        <div class="absolute inset-0 w-full h-full overflow-hidden">
            <img
            v-for="(image, index) in images"
            :key="index"
            :src="image"
            :class="{ 'opacity-100': currentIndex === index, 'opacity-0': currentIndex !== index }"
            class="absolute inset-0 w-full h-full object-cover transition-opacity duration-1000 ease-in-out"
            alt="carousel background"
            />
        </div>

        <!-- Overlay -->
        <div class="absolute inset-0 bg-black/40"></div>

        <!-- Hero Content -->
        <div class="relative z-10 container mx-auto px-4">
            <h1 class="text-4xl md:text-6xl font-bold mb-6 animate-fadeIn">
            Empowering the Next Tech Generation
            </h1>
            <p class="text-lg md:text-xl mb-8 max-w-2xl mx-auto">
            Join Uniscape and master the skills to shape tomorrow's technology today.
            </p>

            <div class="flex items-center justify-center gap-4">
            <button
                type="button"
                class="bg-white text-uniscape-blue font-semibold px-6 py-3 rounded-full hover:bg-yellow-300 transition"
                @click="scrollToSection('programs')"
            >
                Get Started
            </button>
            </div>
        </div>

        <!-- Optional Controls -->
        <button
            type="button"
            @click="prevImage"
            class="absolute left-5 top-1/2 -translate-y-1/2 bg-white/50 hover:bg-white text-gray-800 p-2 rounded-full shadow-md z-10"
        >
            <img src="/back.png" alt="back" width="30" />
        </button>

        <button
            type="button"
            @click="nextImage"
            class="absolute right-5 top-1/2 -translate-y-1/2 bg-white/50 hover:bg-white text-gray-800 p-2 rounded-full shadow-md z-10"
        >
            <img src="/next.png" alt="next" width="30" />
        </button>
        
        
        </section>
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

