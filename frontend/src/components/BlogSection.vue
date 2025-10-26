<template>
  <section id="blog" class="pt-28 py-20 bg-gray-50">
    <div class="container mx-auto px-4">
      <h2 class="text-3xl font-bold text-uniscape-blue mb-8 text-center">
        Uniscape Blog
      </h2>

      <!-- Blog posts grid -->
      <div class="grid md:grid-cols-3 sm:grid-cols-2 grid-cols-1 gap-8">
        <div
          v-for="post in blogPosts"
          :key="post.id"
          class="bg-white rounded-2xl shadow-md hover:shadow-lg transition overflow-hidden"
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
            <p class="text-gray-600 text-sm line-clamp-3 mb-4">
              {{ post.excerpt }}
            </p>
            <router-link
              :to="`/blog/${post.slug}`"
              class="inline-block text-uniscape-yellow font-semibold hover:underline"
            >
              Read more →
            </router-link>
          </div>
        </div>
      </div>

      <!-- Loading or empty state -->
      <div v-if="blogPosts.length === 0" class="text-center text-gray-500 text-lg mt-10">
        Loading blog posts...
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      blogPosts: [
        {
          id: 1,
          title: "Exploring the Future of AI in Education",
          excerpt:
            "Artificial Intelligence is transforming the way we learn and teach. Discover the latest trends and how AI is shaping education.",
          slug: "future-of-ai-education",
          image: "https://source.unsplash.com/600x400/?education,ai"
        },
        {
          id: 2,
          title: "Top 10 Programming Languages to Learn in 2025",
          excerpt:
            "Stay ahead in the tech world! We cover the most in-demand programming languages you should consider learning this year.",
          slug: "top-programming-languages-2025",
          image: "https://source.unsplash.com/600x400/?programming,code"
        },
        {
          id: 3,
          title: "How to Balance University and Personal Projects",
          excerpt:
            "Managing your time effectively is key to success. Learn practical tips to balance academic life with personal projects.",
          slug: "balance-university-projects",
          image: "https://source.unsplash.com/600x400/?student,study"
        },
        {
          id: 4,
          title: "The Importance of Cybersecurity Awareness",
          excerpt:
            "Cyber threats are increasing every day. Discover why staying informed about cybersecurity is crucial for students and professionals.",
          slug: "importance-cybersecurity-awareness",
          image: "https://source.unsplash.com/600x400/?cybersecurity,tech"
        },
        {
          id: 5,
          title: "Design Thinking: Innovation in Problem Solving",
          excerpt:
            "Learn how design thinking can help you approach problems creatively and come up with innovative solutions.",
          slug: "design-thinking-innovation",
          image: "https://source.unsplash.com/600x400/?design,innovation"
        },
        {
          id: 6,
          title: "Remote Learning: Tips for Staying Motivated",
          excerpt:
            "Remote learning has its challenges. Here are practical tips to stay motivated and productive while studying online.",
          slug: "remote-learning-tips",
          image: "https://source.unsplash.com/600x400/?remote,learning"
        }
      ]
    };
  }
};
</script>
