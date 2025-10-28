<script setup lang="ts">
import HeroSection from '@/components/HeroSection.vue';
import PartnerSection from '@/components/PartnerSection.vue';
import ProgramSection from '@/components/ProgramSection.vue';

</script>

<template>
    <section>
        <HeroSection />
        <ProgramSection />
        <PartnerSection />
        <!-- Student Success Stories -->
        <section class="py-16 bg-white font-futura">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Our Success Stories</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="/user.png" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">Sarah K.</h4>
                                <p class="text-sm text-gray-600">Data Science Graduate</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"The hands-on projects prepared me perfectly for my role at Safaricom. Landed a job before graduation!"</p>
                    </div>
                    
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="/user.png" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">James M.</h4>
                                <p class="text-sm text-gray-600">Full-Stack Developer</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"Mentorship and real-world projects made all the difference. Tripled my salary in 6 months!"</p>
                    </div>
                    
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="/user.png" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">Grace W.</h4>
                                <p class="text-sm text-gray-600">Cyber Security Analyst</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"The career support team helped me negotiate my current role. Best investment in my career!"</p>
                    </div>
                </div>
            </div>
        </section>
    </section>
</template>