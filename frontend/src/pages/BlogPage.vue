<template>
  <section class="pt-28 py-20 bg-gray-50">
    <div class="container mx-auto px-4">
      <router-link to="/blog" class="text-uniscape-yellow font-semibold hover:underline mb-5 inline-block">
        ← Back to Blog
      </router-link>

      <div v-if="post" class="bg-white rounded-2xl shadow-md p-8">
        <img
          :src="post.image"
          :alt="post.title"
          class="w-full h-64 object-cover rounded-xl mb-6"
        />
        <h2 class="text-3xl font-bold text-uniscape-blue mb-4">
          {{ post.title }}
        </h2>
        <p class="text-gray-700 leading-relaxed">
          {{ post.content }}
        </p>
      </div>

      <div v-else class="text-center text-gray-500 text-lg mt-10">
        Loading post...
      </div>
    </div>
  </section>
</template>

<script>
import { blogPosts } from '@/data/BlogPost';

export default {
  name: "BlogPost",
  data() {
    return {
      post: null,
    };
  },
  created() {
    const slug = this.$route.params.slug;
    this.post = blogPosts.find((p) => p.slug === slug);
  },
};
</script>
