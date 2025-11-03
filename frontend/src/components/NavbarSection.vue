<template>
  <nav class="bg-white fixed inset-x-0 top-0 shadow-md z-50">
    <div class="container mx-auto w-full px-4">
      <!-- logo + desktop menu -->
      <div class="flex items-center justify-between h-20 relative">
        <!-- logo -->
        <div class="flex items-center gap-2">
          <img
            src="/uniscape-tech-logo2.png"
            alt="uniscape-icon"
            class="w-auto h-20 object-contain"
          />
        </div>

        <!-- desktop menu -->
        <div class="hidden md:flex items-center gap-4">
          <router-link
            to="/welcome-page"
            class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition"
            >Home</router-link
          >
          <router-link
            to="/about"
            class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition"
            >About</router-link
          >

          <!-- Programs dropdown -->
          <div
            class="relative flex items-center gap-2"
            @mouseenter="showPrograms = true"
            @mouseleave="showPrograms = false"
          >
            <button
              class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition flex items-center gap-2 cursor-pointer"
            >
              Programs
              <img
                src="/down.png"
                alt="down"
                width="18"
                class="ml-1 transition-transform duration-200"
                :class="{ 'rotate-180': showPrograms }"
              />
            </button>

            <!-- Dropdown -->
            <transition name="fade">
              <div
                v-if="showPrograms"
                class="absolute top-14 left-0 w-[40rem] bg-white border border-gray-200 rounded-2xl shadow-xl z-50 p-4"
              >
                <h4 class="text-uniscape-blue text-lg font-semibold mb-3">
                  Available Programs
                </h4>

                <div
                  v-if="Object.keys(groupedCourses).length"
                  class="max-h-80 overflow-y-auto space-y-3"
                >
                  <div
                    v-for="(courses, categoryName) in groupedCourses"
                    :key="categoryName"
                    class="flex flex-col border-b border-gray-100 pb-2 mb-2"
                  >
                    <!-- Category Header -->
                    <div
                      class="flex items-center justify-between cursor-pointer hover:bg-gray-50 px-2 py-1 rounded-lg transition"
                      @click="toggleCategory(categoryName)"
                    >
                      <div class="flex items-center gap-2">
                        <h5 class="font-bold text-uniscape-blue">{{ categoryName }}</h5>
                      </div>
                      <img
                        src="/right-arrow.png"
                        alt="arrow-right"
                        width="20"
                        class="transition-transform duration-200"
                        :class="{ 'rotate-90': openCategory === categoryName }"
                      />
                    </div>

                    <!-- Courses shown only when arrow clicked -->
                    <transition name="fade">
                      <div
                        v-if="openCategory === categoryName"
                        class="flex flex-wrap gap-2 mt-2 pl-6"
                      >
                        <router-link
                          v-for="course in courses"
                          :key="course.id"
                          :to="`/programs/${course.slug}`"
                          class="px-3 py-1 text-gray-700 hover:bg-uniscape-blue hover:text-yellow-300 rounded-md transition"
                          @click="showPrograms = false"
                        >
                          {{ course.course_name }}
                        </router-link>
                      </div>
                    </transition>
                  </div>
                </div>

                <div v-else class="text-gray-500 text-center py-3">
                  Loading courses...
                </div>
              </div>
            </transition>
          </div>

          <router-link
            to="/blog"
            class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition"
            >Blog</router-link
          >
          <router-link
            to="/contact"
            class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition"
            >Contact Us</router-link
          >
          <router-link
            to="/faqs"
            class="text-uniscape-blue text-lg font-roboto font-semibold hover:text-uniscape-yellow hover:bg-uniscape-blue px-4 py-2 rounded-md transition"
            >FAQs</router-link
          >

          <router-link
            to="/apply"
            class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition"
          >
            Get Started
          </router-link>
        </div>

        <!-- mobile toggle -->
        <div class="block md:hidden">
          <button type="button" @click="toggleMenu">
            <img src="/logs.png" alt="logs" width="30" />
          </button>
        </div>
      </div>

      <!-- mobile menu -->
      <transition name="slide">
        <div
          v-if="showMenu"
          class="fixed font-futura inset-0 left-0 w-72 bg-uniscape-yellow shadow-lg z-40 flex flex-col items-start p-6 space-y-3 md:hidden"
        >
          <button
            @click.prevent="toggleMenu"
            type="button"
            class="self-end mb-4 text-uniscape-blue font-bold"
          >
            <img src="/close.png" alt="close" width="30" />
          </button>

          <router-link
            to="/welcome-page"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            >Home</router-link
          >
          <router-link
            to="/about"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            >About Us</router-link
          >

          <!-- Programs dropdown (mobile) -->
          <div class="w-full">
            <button
              @click="togglePrograms"
              class="flex justify-between items-center w-full text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            >
              <span>Programs</span>
              <img src="/down.png" alt="down" width="20" />
            </button>

            <transition name="fade">
              <div v-if="showPrograms" class="pl-6 mt-2 space-y-2">
                <div
                  v-for="(courses, categoryName) in groupedCourses"
                  :key="categoryName"
                >
                  <h5 class="font-bold text-uniscape-blue">{{ categoryName }}</h5>
                  <router-link
                    v-for="course in courses"
                    :key="course.id"
                    :to="`/programs/${course.slug}`"
                    class="block text-uniscape-blue text-base hover:text-yellow-300"
                    @click="toggleMenu(); showPrograms = false"
                  >
                    • {{ course.course_name }}
                  </router-link>
                </div>
              </div>
            </transition>
          </div>

          <router-link
            to="/contact"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            >Contact Us</router-link
          >
          <router-link
            to="/faqs"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            >FAQs</router-link
          >
          <router-link
            to="/apply"
            class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition"
          >
            Get Started
          </router-link>
        </div>
      </transition>
    </div>
  </nav>
</template>

<script>
import api from "@/services/api";

export default {
  name: "Navbar",
  data() {
    return {
      showMenu: false,
      showPrograms: false,
      allCourses: [],
      allCategories: [],
      openCategory: null, // 👈 added to track which arrow is open
      errors: {},
    };
  },
  computed: {
    groupedCourses() {
      const grouped = {};
      this.allCategories.forEach((cat) => {
        grouped[cat.name] = this.allCourses.filter(
          (course) => course.category_id === cat.id
        );
      });
      return grouped;
    },
  },
  methods: {
    toggleMenu() {
      this.showMenu = !this.showMenu;
    },
    togglePrograms() {
      this.showPrograms = !this.showPrograms;
    },
    toggleCategory(categoryName) {
      // 👇 toggle courses visibility for that category
      this.openCategory =
        this.openCategory === categoryName ? null : categoryName;
    },
    async fetchAllCourses() {
      try {
        const response = await api.get("all_courses");
        this.allCourses = response.data;
      } catch (error) {
        this.errors.general = "Failed to load courses.";
      }
    },
    async fetchAllCategories() {
      try {
        const response = await api.get("all_categories");
        this.allCategories = response.data;
      } catch (error) {
        this.errors.general = "Failed to load categories.";
      }
    },
  },
  mounted() {
    this.fetchAllCategories();
    this.fetchAllCourses();
  },
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: all 0.25s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.rotate-90 {
  transform: rotate(90deg);
  transition: transform 0.3s ease;
}
</style>
