<template>
    <section class="py-20 bg-gray-50 pt-24 font-futura">
        
        <div class="container mx-auto px-4">
            <!-- go back button -->
             <button 
                @click="$router.back()" 
                class="fixed top-24 left-2 sm:left-4 md:left-6 z-50 bg-uniscape-yellow shadow-md p-2 rounded-full hover:bg-gray-100 transition"
                >
                <img src="/back.png" alt="back" width="20">
            </button>

            <div v-if="course" class="max-w-4xl mx-auto bg-white rounded-2xl shadow-md p-8">
                <img v-if="course.course_image" :src="course.course_image" alt="course image" class="w-full h-64 object-cover rounded-lg mb-6">
                <h2 class="text-3xl font-bold text-uniscape-blue mb-4">{{ course.course_name }}</h2>

                <p class="text-gray-700 mb-2">
                    <strong>Duration:</strong> {{ course.course_duration }}
                </p>

                <p class="text-gray-700 mb-2">
                    <strong>Fees:</strong> KES {{ course.course_fee }}
                </p>

                <p class="text-gray-600 mb-6">{{ course.course_desc }}</p>

                <div v-if="course.course_more_info" class="text-gray-700 mb-6 whitespace-pre-line leading-relaxed" v-html="formattedMoreInfo"></div>

                <div class="flex items-center justify-between">
                    <button type="button" @click="$router.back()" class="bg-uniscape-blue text-white px-6 py-2 rounded-md font-semibold hover:bg-blue-900 transition">
                        Back to Programs
                    </button>
                    <button @click="showFlyer = true" type="button" class="bg-uniscape-blue text-white px-6 py-2 rounded-md font-semibold hover:bg-blue-900 transition">
                        View Bronchure
                    </button>

                    <!-- enroll button -->
                     <router-link :to="`/programs/${course.slug}/apply`" class="bg-uniscape-blue text-white px-6 py-2 rounded-md font-semibold hover:bg-blue-900 transition">Enroll</router-link>
                     <!-- <button type="button" class="bg-uniscape-blue text-white px-6 py-2 rounded-md font-semibold hover:bg-blue-900 transition">
                        Enroll
                     </button> -->
                </div>
            </div>
            
            <!-- Loading State -->
            <div v-else-if="loading" class="text-center text-gray-500">
                <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-uniscape-blue"></div>
                <p class="mt-2">Loading course details...</p>
            </div>
            
            <!-- Error State -->
            <div v-else-if="error" class="text-center text-red-600">
                <p class="text-lg font-semibold">{{ error }}</p>
                <button @click="loadCourse" class="mt-4 bg-uniscape-blue text-white px-4 py-2 rounded-md hover:bg-blue-900 transition">
                    Try Again
                </button>
                <p class="mt-2 text-sm text-gray-600">Course ID: {{ id }}</p>
            </div>

            <!-- Flyer modal -->
             <!-- Flyer modal -->
            <transition name="fade">
            <div
                v-if="showFlyer && course.course_flyer"
                class="fixed inset-0 bg-black/70 flex items-center justify-center z-50"
            >
                <div class="relative max-w-3xl w-full mx-4">
                <!-- Flyer container -->
                <div class="relative">
                    <!-- Flyer image -->
                    <img
                    :src="course.course_flyer"
                    alt="course_flyer"
                    class="w-full h-auto rounded-lg object-contain"
                    />

                    <!-- Button container (top-right) -->
                    <div class="absolute top-4 right-4 flex items-center gap-3">
                    <!-- Download button -->
                    <button
                        @click="downloadBronchure(course)"
                        class="bg-white/90 hover:bg-white p-2 rounded-full shadow-md transition"
                    >
                        <img src="/download.png" alt="download" width="28" />
                    </button>

                    <!-- Close button -->
                    <button
                        type="button"
                        @click="closeFlyer"
                        class="bg-white/90 hover:bg-white p-2 rounded-full shadow-md transition"
                    >
                        <img src="/close.png" alt="close" width="24" />
                    </button>
                    </div>
                </div>
                </div>
            </div>
            </transition>
             <router-view/>
        </div>
    </section>
</template>

<script>
import api from '@/services/api';

export default {
    props: ['slug'],
    data() {
        return {
            course: null,
            error: null,
            loading: true,

            courseId: '',
            courseSlug: '',

            showFlyer: false,

            errors: []
        }
    },
    methods: {
        async loadCourse() {
            this.loading = true;
            this.error = null;
            this.course = null;
            
            try {
                console.log('Loading course with ID:', this.id);
                const response = await api.get(`single_course/${this.slug}`);
                console.log('Course API response:', response);
                this.course = response.data;

                // if (this.course.course_flyer) {
                //     this.showFlyer = true;
                // }
            } catch (err) {
                console.error('Error loading course:', err);
                this.error = 'Failed to load course details. Please try again.';
                
                // More specific error messages
                if (err.response) {
                    console.error('Response status:', err.response.status);
                    console.error('Response data:', err.response.data);
                    
                    if (err.response.status === 404) {
                        this.error = 'Course not found.';
                    } else if (err.response.status === 500) {
                        this.error = 'Server error. Please try again later.';
                    }
                } else if (err.request) {
                    this.error = 'Network error. Please check your connection.';
                }
            } finally {
                this.loading = false;
            }
        },

        closeFlyer() {
            this.showFlyer = false;
        },

        async downloadBronchure(course) {
            this.courseId = course.id
            this.courseSlug = course.slug
            
            try {
                const response = await api.get(`download_flyer/${this.courseSlug}`)
    
                // create a temporary anchor tag to trigger download
                const downloadUrl = response.data.download_url;
                const fileName = response.data.filename;
    
                const link = document.createElement('a');
                link.href = downloadUrl;
                link.download = fileName;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
    
                console.log("Course downloaded successfully!")
                this.closeFlyer();
            } catch (error) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors
                } else {
                    this.errors.general = "Sowmthing went wrong!"
                }
            }
        }
    },

    computed: {
        formattedMoreInfo() {
            if (!this.course || !this.course.course_more_info) return '';

            // Convert escaped newlines (\\n) to actual newlines, then to <br>
            let text = this.course.course_more_info
            .replace(/\\n/g, '\n') // First unescape them
            .replace(/\n/g, '<br>'); // Then render as HTML line breaks

            // Then, add your headings
            text = text
            .replace(/Overview:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Overview</h3>')
            .replace(/Duration:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Duration</h3>')
            .replace(/Prerequisites:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Prerequisites</h3>')
            .replace(/Fees:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Fees</h3>')
            .replace(/Target Group:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Target Group</h3>')
            .replace(/Certification:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Certification</h3>')
            .replace(/Career Outcomes:?/g, '<h3 class="font-semibold text-lg mt-4 mb-1">Career Outcomes</h3>');

            return text;
        }
    },


    async mounted() {
        await this.loadCourse();
    },
    watch: {
        id: {
            immediate: true,
            handler(newId) {
                if (newId) {
                    this.loadCourse();
                }
            }
        }
    }
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
    transition: opacity 0.4s;
}
.fade-enter, .fade-leave-to {
    opacity: 0;
}
</style>
