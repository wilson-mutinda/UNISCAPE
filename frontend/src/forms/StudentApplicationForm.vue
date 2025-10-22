<template>
  <div class="pt-32 px-8 min-h-screen bg-gray-50">
    <form @submit.prevent="submitApplication" class="max-w-xl mx-auto bg-white shadow-lg p-6 rounded-2xl">
      <h2 class="text-2xl font-bold mb-4 text-center text-blue-700">Course Application Form</h2>

      <p class="text-gray-500 mb-4">Fill in your personal details below</p>

      <!-- Names -->
      <div class="grid grid-cols-2 gap-4 mb-4">
        <div>
          <label for="first_name" class="block text-sm text-gray-700">First Name</label>
          <input v-model="form.first_name" id="first_name" name="first_name" type="text" required class="w-full border px-3 py-2 rounded-md">
        </div>
        <div>
          <label for="last_name" class="block text-sm text-gray-700">Last Name</label>
          <input v-model="form.last_name" id="last_name" name="last_name" type="text" required class="w-full border px-3 py-2 rounded-md">
        </div>
      </div>

      <!-- Contact -->
      <div class="mb-4">
        <label for="phone" class="block text-sm text-gray-700">Phone</label>
        <input v-model="form.phone" id="phone" name="phone" type="tel" required class="w-full border px-3 py-2 rounded-md">
      </div>

      <div class="mb-4">
        <label for="email" class="block text-sm text-gray-700">Email</label>
        <input v-model="form.email" id="email" name="email" type="email" required class="w-full border px-3 py-2 rounded-md">
      </div>

      <!-- Country -->
      <div class="mb-4">
        <label for="country" class="block text-sm text-gray-700">Country</label>
        <select v-model="form.country_id" id="country" name="country" required class="w-full border px-3 py-2 rounded-md">
          <option value="">-- Select Country --</option>
          <option v-for="country in countries" :key="country.id" :value="country.id">{{ country.name }}</option>
        </select>
      </div>

      <!-- Course -->
      <div class="mb-4">
        <label for="course" class="block text-sm text-gray-700">Course</label>
        <select v-model="form.course_id" id="course" name="course" required class="w-full border px-3 py-2 rounded-md">
          <option value="">-- Select Course --</option>
          <option v-for="course in courses" :key="course.id" :value="course.id">{{ course.name }}</option>
        </select>
      </div>

      <!-- Submit -->
      <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700">Submit Application</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        first_name: '',
        last_name: '',
        phone: '',
        email: '',
        country_id: '',
        course_id: '',
      },
      countries: [],
      courses: []
    }
  },
  methods: {
    async submitApplication() {
      try {
        const res = await fetch('http://localhost:3000/api/students', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.form)
        })
        const data = await res.json()
        alert('Application submitted successfully!')
      } catch (err) {
        console.error(err)
      }
    }
  },
  mounted() {
    // Fetch country and course options
    fetch('http://localhost:3000/api/countries').then(res => res.json()).then(data => this.countries = data)
    fetch('http://localhost:3000/api/courses').then(res => res.json()).then(data => this.courses = data)
  }
}
</script>
