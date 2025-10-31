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
      { path: 'home', name: 'home', component: HomePage, meta: { title: 'Home'} },

      // single course page
      {
        path: 'programs/:slug',
        name: 'course',
        component: CoursePage,
        props: true,
        meta: { title: 'Program Deatils' }
      },

      // standalone application form
      {
        path: '/programs/:slug/apply',
        name: 'course-apply',
        component: StudentApplicationForm,
        props: true,
        meta: { title: 'Apply' }
      },

      // blog routes
      {
        path: 'blog',
        name: 'blog',
        component: BlogSection,
        meta: { title: 'Blog'}
      },

      {
        path: 'blog/:slug',
        name: 'blog-post',
        component: BlogPage,
        props: true,
        meta: { title: 'Blog'},
      },

      {
        path: 'courses',
        name: 'courses',
        component: ProgramSection,
        meta: { title: 'Courses' },
      },

      {
        path: 'about',
        name: 'about',
        component: AboutPage,
        meta: { title: 'About Us'}
      },

      {
        path: 'welcome-page',
        name: 'welcome-page',
        component: WelcomePage,
        meta: { title: 'Welcome'}
      },

      { path: 'login', name: 'login', component: LoginForm, meta: { title: 'Login' } },
      { path: 'apply', name: 'apply', component: StudentApplicationForm, meta: { title: 'Application'} },
      { path: 'contact', name: 'contact', component: ContactPage, meta: { title: 'Contact' } },
      { path: 'faqs', name: 'faqs', component: FAQPage, meta: { title: 'FAQS' } }
    ] },
  ],
});

router.beforeEach((to, from, next) => {
  if (!navigator.onLine) {
    alert("You are offline. Navigation is disabled until you reconnect.");
    next(false);
  } else {
    next();
  }
});


router.beforeEach((to, from, next) => {
  const baseTitle = 'Uniscape Technology'

  if (to.name === 'course' && typeof to.params.slug === 'string') {
  const slugParam = to.params.slug;

  const courseName = slugParam
    .replace(/-/g, ' ')
    .replace(/\b\w/g, (l: string) => l.toUpperCase());

  document.title = `${courseName} – ${baseTitle}`;
} else {
  const routeTitle = to.meta.title || 'Uniscape Technology';
  document.title = `${routeTitle} – ${baseTitle}`;
}

next()

})

export default router
