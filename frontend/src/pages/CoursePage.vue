<template>
    <section class="py-20 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="max-w-4xl mx-auto bg-white rounded-2xl shadow-md p-8">
                <img v-if="course_image" :src="course_image" alt="course_image" class="w-full h-64 object-cover rounded-lg mb-6">
                <h2 class="text-3xl font-bold text-uniscape-blue mb-4">{{ course_name }}</h2>

                <p class="text-gray-700 mb-2">
                    <strong>Fees:</strong> KES {{ course_fee }}
                </p>

                <p class="text-gray-600 mb-6">{{ course_desc }}</p>

                <p class="text-gray-600 mb-6">
                    <strong>More Info:</strong> {{ course_more_info }}
                </p>

                <router-link to="/home" class="text-blue-600 font-semibold hover:underline">Back</router-link>
            </div>
        </div>
    </section>
</template>

<script>
export default {
    data() {
        return {
            course_name: '',
            course_duration: '',
            course_fee: '',
            course_desc: '',
            course_more_info: '',
            course_image: ''
        }
    },

    mounted() {
        this.course_name = localStorage.getItem('course_name');
        this.course_duration = localStorage.getItem('course_duration');
        this.course_fee = localStorage.getItem('course_fee');
        this.course_desc = localStorage.getItem('course_desc');
        this.course_more_info = localStorage.getItem('course_more_info');
        this.course_image = localStorage.getItem('course_image')
    }
}
</script>

