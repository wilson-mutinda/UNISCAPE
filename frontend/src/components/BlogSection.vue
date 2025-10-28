<template>
  <section id="blog" class="pt-28 py-20 bg-gray-50 font-futura">
    <div class="container mx-auto px-4">
      <h2 class="text-3xl font-bold text-uniscape-blue mb-8 text-center">
        Uniscape Blog
      </h2>

      <!-- Blog posts grid -->
       <div class="grid md:grid-cols-3 sm:grid-cols-2 grid-cols-1 gap-8">
        <router-link
          v-for="post in blogPosts"
          :key="post.id"
          :to="`/blog/${post.slug}`"
          class="bg-white rounded-2xl shadow-md hover:shadow-lg transition overflow-hidden block cursor-pointer hover:-translate-y-1 duration-300"
        >
        <img
         :src="post.image"
         :alt="post.title"
         class="w-full h-48 object-cover" 
         />
         <div class="p-5">
          <h3 class="text-xl font-semibold text-uniscape-blue mb-2 truncate">
            {{ post.title }}
          </h3>
          <p class="text-gray-600 text-sm line-clamp-3 mb-4">{{ post.excerpt }}</p>

          <span class="inline-block text-uniscape-yellow font-semibold hover:underline">
            Read more →
          </span>
         </div>
      </router-link>
       </div>

      <!-- Loading or empty state -->
      <div v-if="blogPosts.length === 0" class="text-center text-gray-500 text-lg mt-10">
        Loading blog posts...
      </div>
    </div>
  </section>
</template>

<script>
import { blogPosts } from '@/data/BlogPost';

export default {
  data() {
    return {
      blogPosts
    };
  }
};
</script>
