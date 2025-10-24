import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import HomePage from '@/pages/HomePage.vue'
import MainPage from '@/pages/MainPage.vue'
import CoursePage from '@/pages/CoursePage.vue'
import StudentApplicationForm from '@/forms/StudentApplicationForm.vue'
import LoginForm from '@/forms/LoginForm.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', component: MainPage, children: [
      { path: '', redirect: 'home' },
      { path: 'home', name: 'home', component: HomePage },
      { path: 'programs/:slug', name: 'course', component: CoursePage, props: true },
      { path: 'apply', name: 'apply', component: StudentApplicationForm },
      { path: 'login', name: 'login', component: LoginForm }
    ] },
  ],
})

export default router
