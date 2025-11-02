<template>
  <section id="programs" class="py-16 pt-28 bg-gray-50 font-futura">
    <div class="container mx-auto px-4">
      <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">
        Our Programmes
      </h3>

      <!-- Category selection -->
      <div class="flex flex-wrap justify-center gap-3 mb-8">
        <button
          v-for="(category, index) in allCategories"
          :key="index"
          @click="selectedCategory = category.id"
          :class="[
            'px-5 py-2 rounded-full text-lg font-semibold transition',
            selectedCategory === category.id
              ? 'bg-uniscape-blue text-yellow-300 shadow-lg'
              : 'bg-yellow-100 text-uniscape-blue hover:bg-yellow-200'
          ]"
        >
          {{ category.name }}
        </button>

        <!-- Clear filter button -->
        <button
          v-if="selectedCategory"
          @click="selectedCategory = null"
          class="px-5 py-2 rounded-full text-lg font-semibold bg-gray-200 text-gray-700 hover:bg-gray-300"
        >
          Show All
        </button>
      </div>

      <!-- Featured Courses -->
      <div
        v-if="filteredCourses.length"
        class="grid grid-cols-1 md:grid-cols-3 gap-6"
      >
        <router-link
          v-for="(course, index) in filteredCourses"
          :key="course.id"
          :to="`/programs/${course.slug}`"
          class="bg-gradient-to-b from-uniscape-yellow to-yellow-50 rounded-2xl shadow-lg p-6 hover:-translate-y-2 transition-transform duration-300 block"
        >
          <img
            :src="course.course_image"
            alt=""
            class="rounded-lg mb-4 object-cover h-48 w-full"
          />
          <h4 class="text-2xl font-bold text-uniscape-blue mb-3">
            {{ course.course_name }}
          </h4>
          <p class="text-gray-600 mb-6 line-clamp-3">
            Learn the latest tools and skills in {{ course.course_name }} with
            hands-on projects, expert mentors, and a global-ready curriculum.
          </p>
          <p class="text-gray-700 mb-4 flex items-center gap-2">
            <img src="/clock.png" alt="hour" width="20" />
            {{ course.course_duration }}
          </p>
          <span
            class="bg-uniscape-blue text-yellow-300 px-5 py-2 rounded-md font-semibold hover:bg-blue-900 transition block text-center"
          >
            Explore Program
          </span>
        </router-link>
      </div>

      <!-- No courses found -->
      <div v-else class="text-center text-gray-500 mt-10">
        No courses available in this category.
      </div>
    </div>
  </section>
</template>


<script>
import api from '@/services/api';

export default {
  data() {
    return {
      allCourses: [],
      allCategories: [],
      selectedCategory: null,  // currently selected category
      errors: {}
    };
  },

  computed: {
    // filters courses based on selected category
    filteredCourses() {
      if (!this.selectedCategory) {
        return this.allCourses; // show all if none selected
      }
      return this.allCourses.filter(
        (course) => course.category_id === this.selectedCategory
      );
    },
  },

  methods: {
    async fetchAllCourses() {
      try {
        const response = await api.get('all_courses');
        this.allCourses = response.data;
        console.log('Courses fetched:', this.allCourses);
      } catch (error) {
        console.error('Error fetching courses:', error);
        this.errors.general = 'Failed to load courses';
      }
    },

    async fetchAllCategories() {
      try {
        const response = await api.get('all_categories');
        this.allCategories = response.data;
        console.log('Categories fetched:', this.allCategories);
      } catch (error) {
        this.errors.general = "Something went wrong!";
      }
    },
  },

  mounted() {
    this.fetchAllCourses();
    this.fetchAllCategories();
  },
};
</script>
