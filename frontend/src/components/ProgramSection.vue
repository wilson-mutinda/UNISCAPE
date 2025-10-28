<template>
    <!-- program-section -->
     <section id="programs" class="py-16 pt-28 bg-gray-50 font-futura">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Our Programmes</h3>

                <!-- featured courses -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <router-link v-for="(course, index) in allCourses" :key="course.id" :to="`/programs/${course.slug}`"
                    class="bg-gradient-to-b from-uniscape-yellow to-yellow-50 rounded-2xl shadow-lg p-6 hover:-translate-y-2 transition-transform duration-300 block">
                    <!-- course iage -->
                     <img :src="course.course_image" alt="" class="rounded-lg mb-4">

                     <h4 class="text-2xl font-bold text-uniscape-blue mb-3">{{ course.course_name }}</h4>

                     <p class="text-gray-600 mb-6">Learn the latest tools and skills in {{ course.course_name }} with hands-on projects, expert mentors, and a global-ready curriculum.</p>

                     <p class="text-gray-700 mb-4 flex items-center gap-2">
                        <img src="/clock.png" alt="hour" width="20">
                        {{ course.course_duration }}
                     </p>

                     <!-- button -->
                      <span class="bg-uniscape-blue text-yellow-300 px-5 py-2 rounded-md font-semibold hover:bg-blue-900 transition block text-center">
                        Explore Program
                      </span>
                </router-link>
                </div>
            </div>
        </section>
</template>

<script>
import router from '@/router';
import api from '@/services/api';

export default {
    data() {
        return {
            allCourses: [],
            errors: {}
        }
    },

    methods: {

        async fetchAllCourses(){
            try {
                const response = await api.get('all_courses');
                console.log('Courses fetched: ', response.data);
                this.allCourses = response.data;

                // debug
                if (this.allCourses.length > 0) {
                    console.log('First course structure:', this.allCourses[0]);
                }
            } catch (error) {
                console.error('Error fetching courses:', error);
                this.errors.general = 'Failed to load courses';
            }
        }
    },

    mounted() {
        this.fetchAllCourses();
    }
}
</script>
