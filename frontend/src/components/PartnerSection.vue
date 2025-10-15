<template>
    <!-- our partners -->
        <section class="bg-gray-50 py-16">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-4">Our Partners</h3>

                <!-- partners -->
                <div class="flex items-center space-x-10 animate-marquee">
                    <div v-for="(partner, index) in partners" :key="index" class="flex-shrink-0 flex items-center justify-center">
                        <img :src="partner.image" :alt="partner.image" class="h-20 object-contain">
                    </div>
                </div>
            </div>
        </section>
</template>

<script>
export default {
    data() {
        return {
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
        }
    }
}
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
