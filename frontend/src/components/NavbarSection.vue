<template>
  <!-- navbar -->
  <nav class="bg-white fixed inset-x-0 top-0 shadow-md z-50">
    <div class="container mx-auto w-full px-4">
      <!-- logo and menu -->
      <div class="flex items-center justify-between h-20 relative">
        <!-- logo -->
        <div class="flex items-center gap-2">
          <img
            src="/uniscape-logo.png"
            alt="uniscape-icon"
            class="w-auto h-20 object-contain"
          />
        </div>

        <!-- desktop menu -->
        <div class="hidden md:flex items-center gap-4">
          <a
            @click.prevent="goToSection('home')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#home"
          >Home</a>

          <a
            @click.prevent="goToSection('about')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#about"
          >About Us</a>

          <!-- Programs dropdown -->
            <div
            class="relative flex items-center gap-2"
            @mouseenter="showPrograms = true"
            @mouseleave="showPrograms = false"
            >
            <!-- Main Programs link -->
            <a
                @click.prevent="goToSection('programs')"
                class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition flex items-center gap-2 cursor-pointer"
                href="#programs"
            >
                Programs
                <img
                src="/down.png"
                alt="down"
                width="18"
                class="ml-1 transition-transform duration-200"
                :class="{ 'rotate-180': showPrograms }"
                />
            </a>

            <!-- Dropdown -->
            <transition name="fade">
                <div
                v-if="showPrograms"
                class="absolute top-14 left-0 w-80 bg-white border border-gray-200 rounded-2xl shadow-xl z-50 p-4"
                >
                <!-- Header -->
                <div class="flex justify-between items-center mb-3">
                    <h4 class="text-uniscape-blue text-lg font-semibold">
                    Available Programs
                    </h4>
                </div>

                <!-- Program list -->
                <div v-if="courses.length > 0" class="max-h-60 overflow-y-auto pr-2 space-y-1">
                    <router-link
                    v-for="(course, index) in courses"
                    :key="course.id"
                    :to="`/programs/${course.slug}`"
                    class="block px-3 py-2 text-gray-700 hover:bg-uniscape-blue hover:text-yellow-300 rounded-lg transition"
                    @click="showPrograms = false"
                    >
                    <div class="font-semibold">{{ course.course_name }}</div>
                    <p class="text-sm text-gray-500 truncate">
                        {{ course.course_duration }}
                    </p>
                    </router-link>
                </div>

                <!-- Loading state -->
                <div v-else class="px-4 py-3 text-gray-500 text-center">
                    Loading courses...
                </div>
                </div>
            </transition>
            </div>
          <!-- <a
            @click.prevent="goToSection('community')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#community"
          >Community</a> -->

          <a
            @click.prevent="goToSection('blog')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#blog"
          >Blog</a>

          <a
            @click.prevent="goToSection('contacts')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#contacts"
          >Contact Us</a>

          <a
            @click.prevent="goToSection('faqs')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
            href="#faqs"
          >FAQS</a>
          <router-link to="/apply" class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition">
            Get Started
        </router-link>
        </div>

        <!-- mobile menu toggle -->
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
          class="fixed inset-0 left-0 w-72 bg-uniscape-yellow shadow-lg z-40 flex flex-col items-start p-6 space-y-3 md:hidden"
        >
          <button
            @click.prevent="toggleMenu"
            type="button"
            class="self-end mb-4 text-uniscape-blue font-bold"
          >
            <img src="/close.png" alt="close" width="30" />
          </button>

          <a
            @click.prevent="goToMobileSection('home')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            href="#home"
          >Home</a>

          <a
            @click.prevent="goToMobileSection('about')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            href="#about"
          >About Us</a>

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
            </transition>
          </div>

          <a
            @click.prevent="goToMobileSection('community')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            href="#community"
          >Community</a>

          <a
            @click.prevent="goToMobileSection('contacts')"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
            href="#contacts"
          >Contact Us</a>

          <a
            @click.prevent="goToMobileSection('faqs')"
            href="#faqs"
            class="text-uniscape-blue text-lg font-semibold hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
          >FAQS</a>

          <router-link to="/apply" class="text-lg font-semibold text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition">Get Started</router-link>
        </div>
      </transition>
    </div>
  </nav>
</template>

<script>
import api from '@/services/api';

export default {
    name: "ProgramDetails",

    data() {
        return {
            showMenu: false,
            showPrograms: false,
            courses: [],
            errors: {}
        }
    },

    methods: {
        async allCourses() {
            try {
                const response = await api.get('all_courses')
                this.courses = response.data
            } catch (error) {
                if (error.response && error.response.data && error.response.data.errors){
                    this.errors = error.response.data.errors
                } else {
                    this.errors.general = "Something went wrong!"
                }
            }
        },

        toggleMenu() {
            this.showMenu = !this.showMenu
        },

        togglePrograms() {
            this.showPrograms = !this.showPrograms
        },

        goToSection(id) {
            if (this.$route.path !== '/home' && this.$route.path !== '/')
            this.$router.push('/home').then(() => {
                setTimeout(() => {
                    const el = document.getElementById(id);
                    if (el) el.scrollIntoView({ behavior: 'smooth'});
                }, 500);
        });
        else {
            const el = document.getElementById(id);
            if (el) el.scrollIntoView({ behavior: 'smooth'});
        }
        },

        goToMobileSection(id) {
            this.toggleMenu();
            setTimeout(() => {
                this.goToSection(id);
            }, 300);
        },
    },

    mounted() {
        this.allCourses();
    },
}
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

/* Optional: shadow polish */
.shadow-xl {
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}
</style>

