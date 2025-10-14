<template>
    <!-- program-section -->
     <section id="programs" class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Our Programmes</h3>

                <!-- featured courses -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div v-for="(course, index) in allCourses" :key="course.id" class="bg-gradient-to-b from-uniscape-yellow to-yellow-50 rounded-2xl shadow-lg p-6 hover:-translate-y-2 transition-transform duration-300">
                        <h4 class="text-2xl font-bold text-uniscape-blue mb-3">{{ course.course_name }}</h4>
                        <p class="text-gray-700 mb-2">
                            <span class="font-semibold text-uniscape-blue">Duration:</span> {{ course.duration }} months
                        </p>

                        <p class="text-gray-700 mb-4">
                            <span class="font-semibold text-uniscape-blue">Fees:</span> KES {{ course.fees }}
                        </p>

                        <p class="text-gray-600 mb-6">
                            Learn the latest tools and skills in {{ course.name }} with hands on projects, expert mentors, and a global-ready curriculum.
                        </p>

                        <button type="button" class="bg-uniscape-blue text-yellow-300 px-5 py-2 rounded-md font-semibold hover:bg-blue-900 transition">
                            Explore Course
                        </button>
                    </div>
                </div>
            </div>
        </section>
</template>

<script>
import api from '@/services/api';

export default {
    data() {
        return {
            allCourses: []
        }
    },

    methods: {
        async fetchAllCourses(){
            try {
                const response = await api.get('all_courses');
                console.log('Courses fetched: ', response.data);
                this.allCourses = response.data
            } catch (error) {
                console.error('Error fetching courses:', error);
            }
        }
    },

    mounted() {
        this.fetchAllCourses();
    }
}
</script>
