<template>
  <div class="bg-gray-50 min-h-screen pt-28 flex items-center justify-center px-4 font-futura">
    <!-- toast -->
     <Toast ref="toast" :message="toastMessage" :icon="true" />

    <!-- form div -->
     <div class="bg-white shadow-lg rounded-3xl w-full max-w-3xl border border-gray-100 overflow-hidden">

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
  </div>
</template>

<script>
import Toast from '@/components/Toast.vue';
import router from '@/router';
import api from '@/services/api';

export default {

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
        const response = await api.post('create_application', payload);
        console.log("Application created:", response.data);
        this.toastMessage = `Thanks @${this.first_name} for applying to Uniscape. We'll get to you in 24 hours`
        this.$refs.toast.show()
        this.showToast = true
        this.resetForm();

        // redirect to programs
        // this.$router.push('/courses')
      } catch (error) {
        if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors
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
    }
  },

  mounted() {
    this.fetchCountrys();
    this.fetchPrograms();
  }
}
</script>
