<template>
  <div class="bg-gray-50 min-h-screen pt-28 flex items-center flex-col px-4 font-futura">
    <!-- toast -->
     <Toast ref="toast" :message="toastMessage" :icon="true" />

    <!-- form div -->
     <div class="bg-white shadow-lg rounded-3xl w-full max-w-3xl border border-gray-100 overflow-hidden mb-20">

      <!-- header -->
       <div class="bg-uniscape-blue text-white py-6 text-center">
        <h2 class="text-3xl font-bold tracking-wide">Apply to Uniscape</h2>
        <p class="text-lg opacity-80">Join our global learning community today</p>
       </div>

       <!-- intro section -->
        <div class="text-center mb-8 px-6 pt-6">
          <h2 class="text-2xl font-bold text-uniscape-blue">Start Your Learning Journey</h2>
          <p class="text-gray-600 mt-2 text-sm md:text-base">Fill in your details below to apply for a Uniscape program, or 
            <router-link to="/courses" class="text-uniscape-blue underline hover:text-blue-600 transition">Explore Programs</router-link> first.
          </p>
        </div>

        <!-- Form -->
         <form @submit.prevent="createApplication" action="" method="post" class="p-8 space-y-10">

          <!-- General Error -->
           <p v-if="errors.general" class="text-red-500 text-center text-sm">{{ errors.general }}</p>

          <!-- name fields -->
           <div class="grid md:grid-cols-2 gap-6">
            <div class="relative">
              <input
               @input="clearError('first_name')"
               v-model="first_name"
               class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent" 
               type="text" 
               name="first_name" 
               id="first_name" 
               placeholder=" " />

              <label
               class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue" 
               for="first_name">
               First Name
              </label>

              <!-- error -->
               <p v-if="errors.first_name" class="text-red-500 text-sm mt-1">{{ errors.first_name }}</p>
            </div>

            <div class="relative">
              <input 
               @input="clearError('last_name')"
               v-model="last_name"
               class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
               type="text" 
               name="last_name" 
               id="last_name"
               placeholder=" " />

               <label
                class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
                for="last_name">
                Last Name
              </label>

              <!-- error -->
              <p v-if="errors.last_name" class="text-red-500 text-sm mt-1">{{ errors.last_name }}</p>
            </div>
           </div>

           <!-- Email -->
            <div class="relative">
              <input
               @input="clearError('email')"
               v-model="email"
               class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
               type="email" 
               name="email" 
               id="email"
               placeholder=" " />

               <label
                class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
                for="email">
                Email
              </label>

              <!-- error -->
              <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
            </div>

            <!-- country and phone -->
            <div class="grid md:grid-cols-2 gap-6">
              <div class="">
                <label for="country" class="block mb-2 font-medium text-gray-700"> Country </label>
                <div class="flex items-center gap-3">
                  <!-- image -->
                  <img
                    v-if="selectedCountryFlag"
                    :src="selectedCountryFlag" 
                    alt="flag" 
                    class="w-8 h-5 rounded border"
                    />

                  <select
                  @input="clearError('country')"
                  v-model="country"
                  @change="updatePhonePrefix"
                  name="country" 
                  id="country"
                  class="w-full border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-uniscape-blue focus:outline-none">
                    <option disabled value="">-- Select Country --</option>
                    <option v-for="country in countrys" :key="country.id" :value="country.id">{{ country.name }}</option>
                  </select>
                </div>

                <!-- error -->
                  <p v-if="errors.country" class="text-red-500 text-sm mt-1">{{ errors.country }}</p>
              </div>

            <!-- Phone -->
            <div class="relative">

              <input 
                @input="clearError('phone')"
                v-model="phone"
                :disabled="!country"
                class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
                type="tel" 
                name="phone" 
                id="phone"
                placeholder=" " />

              <label
                class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
                for="phone">
                Phone
              </label>

              <!-- error -->
              <p v-if="errors.phone" class="text-red-500 text-sm mt-1">{{ errors.phone }}</p>
            </div>
          </div>

            <div class="">
              <label class="block mb-2 font-medium text-gray-700" for="program">Program </label>
              <select
                @input="clearError('program')"
                v-model="program"
                name="program" 
                id="program"
                class="w-full border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-uniscape-blue focus:outline-none">
                <option disabled value="">-- Select Program --</option>
                <option v-for="course in programs" :key="course.id" :value="course.id">{{ course.course_name }}</option>
              </select>

              <!-- error -->
                <p v-if="errors.program" class="text-red-500 text-sm mt-1">{{ errors.program }}</p>
            </div>

              <!-- Buttons -->
               <div class="flex justify-between items-center pt-6">
                <button @click="resetForm" type="button" class="text-gray-600 hover:text-gray-800 transition font-medium">Cancel</button>
                <button type="submit" class="bg-uniscape-blue hover:bg-blue-800 text-white px-6 py-2 rounded-md font-semibold transition">
                  <span v-if="!isSubmitting">Submit</span>
                  <span v-else>Submitting...</span>
                </button>
               </div>
         </form>
     </div>

     <!-- Featured Course Section -->
    <!-- <section
      v-if="featuredCourse"
      class="w-full max-w-5xl relative rounded-3xl overflow-hidden shadow-2xl"
    >
      <img
        :src="featuredCourse.course_image"
        :alt="featuredCourse.course_name"
        class="w-full h-[400px] object-cover"
      /> -->

      <!-- Overlay -->
      <!-- <div
        class="absolute inset-0 bg-gradient-to-t from-black/80 to-black/30 flex flex-col justify-end p-10 text-white"
      >
        <h3 class="text-3xl md:text-4xl font-bold mb-3">
          {{ featuredCourse.course_name }}
        </h3>

        <p class="text-gray-200 mb-6 text-sm md:text-base max-w-2xl">
          {{ featuredCourse.course_desc }}
        </p>

        <div class="flex flex-wrap items-center gap-4">
          <router-link
            :to="`/programs/${featuredCourse.slug}`"
            class="bg-uniscape-blue hover:bg-blue-700 transition text-white px-6 py-3 rounded-lg font-semibold"
          >
            Learn More
          </router-link>

          <span class="text-gray-300 text-sm">
            Duration: {{ featuredCourse.course_duration }} |
            Fee: {{ featuredCourse.course_fee }}
          </span>
        </div>
      </div> -->
    <!-- </section> -->
  </div>
</template>

<script>
import Toast from '@/components/Toast.vue';
import router from '@/router';
import api from '@/services/api';

export default {

  props: ['slug'],

  components: {
    Toast
  },

  data() {
    return {
      first_name: '',
      last_name: '',
      email: '',
      phone: '',
      country: '',
      program: '',

      countrys: [],
      programs: [],

      selectedCountryFlag: '',

      errors: {},
      isSubmitting: false,

      showToast: false,
      toastMessage: '',

      courseSlug: this.slug || '',

      featuredCourse: null
    }
  },

  methods: {

    async createApplication() {
      this.errors = {}
      this.isSubmitting = true;

      const payload = {
        application: {
          first_name: this.first_name,
          last_name: this.last_name,
          email: this.email,
          phone: this.phone,
          country_id: this.country,
          course_id: this.program
        },
      };

      try {
        console.log("Sending payload:", payload);
        const response = await api.post('create_application', payload);
        console.log("Full response:", response);
        console.log("Response status:", response.status);
        console.log("Response data:", response.data);
        
        // Check if response indicates success
        if (response.status === 201 || (response.data && response.data.message)) {
          this.toastMessage = `Thanks @${this.first_name} for applying to Uniscape. We'll get to you in 24 hours`;
          this.$refs.toast.show();
          this.showToast = true;
          this.resetForm();

          if (this.courseSlug) {
          this.$router.push({ name: 'course', params: { slug: this.courseSlug}});
        } else {
          this.$router.push({ name: 'courses'});
        }

        } else {
          this.errors.general = "Unexpected response from server";
        }
        
      } catch (error) {
        console.error("Full error object:", error);
        console.error("Error response:", error.response);
        console.error("Error message:", error.message);
        console.error("Error code:", error.code);
        
        // Check if it's a network error from our interceptor
        if (error.message === "offline") {
          this.errors.general = "You are offline. Please check your internet connection.";
        } else if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors;
        } else {
          this.errors.general = "Something went wrong while submitting!";
        }
      } finally {
        this.isSubmitting = false;
      }
    },

    resetForm() {
      this.first_name = "";
      this.last_name = "";
      this.email = "";
      this.phone = "";
      this.country = "";
      this.program = "";
      this.selectedCountryFlag = "";
    },

    async fetchCountrys() {
      try {
        const response = await api.get('all_countrys');
        this.countrys = response.data;
      } catch {
          this.errors.general = "Failed to fetch countrys!"
      }
    },

    async fetchPrograms() {
      try {
        const response = await api.get('all_courses')
        this.programs = response.data
        console.log('Programs successfully fetched!')
      } catch (error) {
        this.errors.general = "Failed to fetch programs!"
      }
    },

    updatePhonePrefix() {
      const selected = this.countrys.find(c => c.id === this.country);
      if (selected) {
        this.phone = selected.phone_code + ' ';
        this.selectedCountryFlag = selected.flag_url;
      }
    },

    clearError(field) {
      if (this.errors[field]) {
        this.errors = ''
      }
    },

    async fetchFeaturedCourse() {
      try {
        const response = await api.get('single_course/tech-for-kids');
        this.featuredCourse = response.data;
        console.log('Fatured course fetched successfully!')
      } catch (error) {
        if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors
        } else {
          this.errors.general = "Error while fetching program!"
        }
      }
    }
  },

  async mounted() {
    await this.fetchCountrys();
    await this.fetchPrograms();

    await this.fetchFeaturedCourse();

    if (this.courseSlug) {
      const selected = this.programs.find(p => p.slug === this.courseSlug);

      if (selected) {
        this.program = selected.id
      }
    }
  }
}
</script>
