<template>
    <div class="bg-gray-100 min-h-screen">
        <!-- navbar -->
        <NavbarSection />

        <!-- router-view -->
         <router-view :key="$route.params.slug"/>

        <!-- footer -->
        <FooterSection />
    </div>
</template>

<script>
import FooterSection from '@/components/FooterSection.vue';
import NavbarSection from '@/components/NavbarSection.vue';
import ProgramSection from '@/components/ProgramSection.vue';
import api from '@/services/api';

export default {

    name: 'MainPage',
    components: {
        FooterSection,
        NavbarSection
    },

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