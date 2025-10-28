import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import HomePage from '@/pages/HomePage.vue'
import MainPage from '@/pages/MainPage.vue'
import CoursePage from '@/pages/CoursePage.vue'
import StudentApplicationForm from '@/forms/StudentApplicationForm.vue'
import LoginForm from '@/forms/LoginForm.vue'
import BlogPage from '@/pages/BlogPage.vue'
import BlogSection from '@/components/BlogSection.vue'
import ProgramSection from '@/components/ProgramSection.vue'
import AboutPage from '@/pages/AboutPage.vue'
import WelcomePage from '@/pages/WelcomePage.vue'
import ContactPage from '@/pages/ContactPage.vue'
import FAQPage from '@/pages/FAQPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', component: MainPage, children: [
      { path: '', redirect: 'home' },
      { path: 'home', name: 'home', component: HomePage },

      // single course page
      {
        path: 'programs/:slug',
        name: 'course',
        component: CoursePage,
        props: true,
      },

      // standalone application form
      {
        path: '/programs/:slug/apply',
        name: 'course-apply',
        component: StudentApplicationForm,
        props: true
      },

      // blog routes
      {
        path: 'blog',
        name: 'blog',
        component: BlogSection
      },

      {
        path: 'blog/:slug',
        name: 'blog-post',
        component: BlogPage,
        props: true
      },

      {
        path: 'courses',
        name: 'courses',
        component: ProgramSection
      },

      {
        path: 'about',
        name: 'about',
        component: AboutPage
      },

      {
        path: 'welcome-page',
        name: 'welcome-page',
        component: WelcomePage
      },

      { path: 'login', name: 'login', component: LoginForm },
      { path: 'apply', name: 'apply', component: StudentApplicationForm },
      { path: 'contact', name: 'contact', component: ContactPage },
      { path: 'faqs', name: 'faqs', component: FAQPage }
    ] },
  ],
})

export default router
