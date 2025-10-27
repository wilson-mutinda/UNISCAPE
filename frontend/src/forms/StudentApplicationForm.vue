<template>
  <div class="bg-gray-50 min-h-screen pt-28 flex justify-center items-center px-4">
    <div class="bg-white shadow-lg rounded-3xl w-full max-w-3xl border border-gray-100 overflow-hidden">
      <!-- Header -->
      <div class="bg-uniscape-blue text-white py-6 text-center">
        <h2 class="text-3xl font-bold tracking-wide">Apply to Uniscape</h2>
        <p class="text-lg opacity-80">Join our global learning community today</p>
      </div>

      <!-- Form -->
      <form @submit.prevent="createApplication" class="p-8 space-y-10">
        <!-- General error -->
        <p v-if="errors.general" class="text-red-500 text-center text-sm">{{ errors.general }}</p>

        <!-- Name fields -->
        <div class="grid md:grid-cols-2 gap-6">
          <div class="relative">
            <input
              v-model="first_name"
              id="first_name"
              type="text"
              placeholder=" "
              class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
            />
            <label
              for="first_name"
              class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
            >
              First Name
            </label>
            <p v-if="errors.first_name" class="text-red-500 text-sm mt-1">{{ errors.first_name }}</p>
          </div>

          <div class="relative">
            <input
              v-model="last_name"
              id="last_name"
              type="text"
              placeholder=" "
              class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
            />
            <label
              for="last_name"
              class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
            >
              Last Name
            </label>
            <p v-if="errors.last_name" class="text-red-500 text-sm mt-1">{{ errors.last_name }}</p>
          </div>
        </div>

        <!-- Email -->
        <div class="relative">
          <input
            v-model="email"
            id="email"
            type="email"
            placeholder=" "
            class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
          />
          <label
            for="email"
            class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
          >
            Email
          </label>
          <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
        </div>

        <!-- Phone -->
        <div class="relative">
          <input
            v-model="phone"
            id="phone"
            type="tel"
            placeholder=" "
            class="peer w-full border-b-2 border-gray-300 focus:border-uniscape-blue outline-none py-2 bg-transparent"
          />
          <label
            for="phone"
            class="absolute left-0 -top-3.5 text-gray-600 text-sm transition-all peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-placeholder-shown:top-2 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-uniscape-blue"
          >
            Phone Number
          </label>
          <p v-if="errors.phone" class="text-red-500 text-sm mt-1">{{ errors.phone }}</p>
        </div>

        <!-- Country and Program -->
        <div class="grid md:grid-cols-2 gap-6">
          <div>
            <label for="country" class="block mb-2 font-medium text-gray-700">Country</label>
            <select
              v-model="country"
              id="country"
              class="w-full border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-uniscape-blue focus:outline-none"
            >
              <option disabled value="">-- Select Country --</option>
              <option v-for="c in countrys" :key="c.id" :value="c.id">{{ c.name }}</option>
            </select>
            <p v-if="errors.country" class="text-red-500 text-sm mt-1">{{ errors.country }}</p>
          </div>

          <div>
            <label for="program" class="block mb-2 font-medium text-gray-700">Program</label>
            <select
              v-model="program"
              id="program"
              class="w-full border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-uniscape-blue focus:outline-none"
            >
              <option disabled value="">-- Select Program --</option>
              <option v-for="p in programs" :key="p.id" :value="p.id">{{ p.course_name }}</option>
            </select>
            <p v-if="errors.program" class="text-red-500 text-sm mt-1">{{ errors.program }}</p>
          </div>
        </div>

        <!-- Buttons -->
        <div class="flex justify-between items-center pt-6">
          <button
            type="button"
            class="text-gray-600 hover:text-gray-800 transition font-medium"
            @click="resetForm"
          >
            Cancel
          </button>

          <button
            type="submit"
            class="bg-uniscape-blue hover:bg-blue-800 text-white px-6 py-2 rounded-md font-semibold transition"
          >
            <span v-if="!isSubmitting">Submit</span>
            <span v-else>Submitting...</span>
          </button>
        </div>

        <!-- Success message -->
        <transition name="fade">
          <p v-if="successMessage" class="text-green-600 text-center mt-4 font-medium">
            {{ successMessage }}
          </p>
        </transition>
      </form>
    </div>
  </div>
</template>

<script>
import api from "@/services/api";

export default {
  data() {
    return {
      first_name: "",
      last_name: "",
      email: "",
      phone: "",
      country: "",
      program: "",
      countrys: [],
      programs: [],
      errors: {},
      successMessage: "",
      isSubmitting: false,
    };
  },

  methods: {
    async createApplication() {
      this.errors = {};
      this.successMessage = "";
      this.isSubmitting = true;

      const payload = {
        application: {
          first_name: this.first_name,
          last_name: this.last_name,
          email: this.email,
          phone: this.phone,
          country_id: this.country,
          course_id: this.program,
        },
      };

      try {
        const response = await api.post("create_application", payload);
        this.successMessage = "✅ Application submitted successfully!";
        console.log("Application created:", response.data);
        this.resetForm();
      } catch (error) {
        if (error.response?.data?.errors) {
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
    },

    async fetchCountrys() {
      try {
        const response = await api.get("all_countrys");
        this.countrys = response.data;
      } catch {
        this.errors.general = "Failed to fetch countries.";
      }
    },

    async fetchCourses() {
      try {
        const response = await api.get("all_courses");
        this.programs = response.data;
      } catch {
        this.errors.general = "Failed to fetch programs.";
      }
    },
  },

  mounted() {
    this.fetchCountrys();
    this.fetchCourses();
  },
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>
