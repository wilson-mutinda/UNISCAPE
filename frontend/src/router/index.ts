import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import HomePage from '@/pages/HomePage.vue'
import MainPage from '@/pages/MainPage.vue'
import CoursePage from '@/pages/CoursePage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', component: MainPage, children: [
      { path: '', redirect: 'home' },
      { path: 'home', name: 'home', component: HomePage },
      { path: 'course-page', name: 'course-page', component: CoursePage },
    ] },
  ],
})

export default router
