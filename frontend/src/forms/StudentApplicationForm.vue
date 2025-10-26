<template>
  <div class="bg-gray-50 min-h-screen pt-32 px-4 flex items-center justify-center">
    <div class="bg-uniscape-yellow rounded-md w-full max-w-4xl mb-4">
      <div class="p-6">
        <form @submit.prevent="createApplication" action="" method="post">
        <h3 class="text-center mt-4 mb-4 text-3xl">Apply Now</h3>
        <span v-if="errors.general" class="text-red-500 text-center text-sm">{{ errors.general }}</span>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 bg-white p-2 rounded-2xl ring-2 ring-uniscape-blue mb-2">
          <!-- fname -->
          <div class="">
            <label class="block text-xl mb-2" for="first_name">First name</label>
            <input v-model="first_name" class="rounded-md p-2 w-full mb-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300" type="text" name="first_name" id="first_name">
            <span v-if="errors.first_name" class="text-red-500 text-center text-sm">{{ errors.first_name }}</span>
          </div>

          <!-- lname -->
            <div class="">
              <label class="block text-xl mb-2" for="last_name">Last name</label>
              <input v-model="last_name" class="rounded-md w-full mb-2 p-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300" type="text" name="last_name" id="last_name">
              <span v-if="errors.last_name" class="text-red-500 text-center text-sm">{{ errors.last_name }}</span>
            </div>
        </div>

        <!-- email -->
         <div class="bg-white p-2 rounded-2xl ring-2 ring-uniscape-blue mb-2 mt-12">
          <div class="">
            <label class="block text-xl mb-2" for="email">Email</label>
            <input v-model="email" class="rounded-md w-full mb-2 p-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300" type="email" name="email" id="email">
            <span v-if="errors.email" class="text-red-500 text-center text-sm">{{ errors.email }}</span>
          </div>
         </div>

         <!-- phone -->
          <div class="bg-white rounded-2xl ring-2 ring-uniscape-blue mb-2 mt-12 p-2">
            <div class="">
              <label class="block text-xl mb-2" for="phone">Phone</label>
              <input v-model="phone" class="rounded-md w-full mb-2 p-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300" type="tel" name="phone" id="phone">
              <span v-if="errors.phone" class="text-red-500 text-center text-sm">{{ errors.phone }}</span>
            </div>
          </div>

          <!-- country -->
           <div class="bg-white rounded-2xl ring-2 ring-uniscape-blue mb-2 mt-12 p-2">
            <div class="">
              <label for="country" class="block text-xl mb-2">Country</label>
              <select
               name="country" 
               id="country" 
               v-model="country" 
               class="rounded-md w-full mb-2 p-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300">
               <option disabled value="">-- Select Country --</option>
               <option v-for="c in countrys" :value="c.id" :key="c.id">
                {{ c.name }}
               </option>
              </select>
              <span v-if="errors.country" class="text-red-500 text-center text-sm">{{ errors.country }}</span>
            </div>
           </div>

           <!-- program -->
            <div class="bg-white rounded-2xl ring-2 ring-uniscape-blue mb-2 mt-12 p-2">
              <div class="">
                <label class="block text-xl mb-2" for="program">Program</label>
                <select
                 v-model="program"
                 class="rounded-md w-full mb-2 p-2 bg-transparent ring-1 ring-uniscape-blue hover:ring-blue-300"
                 name="program" 
                 id="program"
                 >
                 <option disabled value="">-- Select Program --</option>
                 <option
                  v-for="p in programs"
                  :key="p.id"
                  :value="p.id">
                  {{ p.course_name }}
                </option>
                </select>
                <span v-if="errors.program" class="text-red-500 text-center text-sm">{{ errors.program }}</span>
              </div>
            </div>

            <!-- submit button -->
             <div class="flex items-center justify-center mt-4">
              <button class="bg-uniscape-blue rounded-md px-4 py-2 text-white font-bold">
                Submit
              </button>
             </div>
      </form>
      </div>
    </div>
  </div>
</template>

<script>
import api from '@/services/api';

export default {
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

      errors: {}
    }
  },

  methods: {

    async createApplication() {
      this.errors = {}
      const payload = {
        application: {
          first_name: this.first_name,
          last_name: this.last_name,
          email: this.email,
          phone: this.phone,
          country_id: this.country,
          course_id: this.program

        }
      }
      try {
        const response = await api.post('create_application', payload)
        console.log("Application ceated successfully!", response.data)
        alert('Your application has been submited successfully!')
  
        this.resetForm();
      } catch (error) {
        if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors
        } else {
          this.errors.general = "Something went wrong while submitting!"
        }
      }

    },

    resetForm() {
      this.first_name = '',
      this.last_name = '',
      this.email = '',
      this.phone = '',
      this.country = '',
      this.program = ''
    },

    async fetchCountrys() {
      this.errors = {}
      try {
        const response = await api.get('all_countrys');
        this.countrys = response.data
        console.log('Coutrys fethed sccessfuly!')
      } catch (error) {
        if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors
        }else {
          this.errors.general = "Something went wrong!"
        }
      }
    },

    async fetchCourses() {
      this.errors = {}
      try {
        const response = await api.get('all_courses');
        this.programs = response.data
        console.log('Programs fethed sccessfuly!')
      } catch (error) {
        if (error.response && error.response.data && error.response.data.errors) {
          this.errors = error.response.data.errors
        }else {
          this.errors.general = "Something went wrong!"
        }
      }
    },

  },

  mounted() {
    this.fetchCountrys();
    this.fetchCourses();
  }
}
</script>
