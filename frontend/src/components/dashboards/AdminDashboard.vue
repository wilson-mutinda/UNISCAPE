<template>
  <div class="bg-gray-50 min-h-screen flex">
    <!-- Sidebar -->
    <aside class="w-64 bg-uniscape-blue text-white flex flex-col min-h-screen">
      <div class="p-6 text-center border-b border-blue-400">
        <h1 class="text-2xl font-bold">Admin Panel</h1>
      </div>

      <!-- Navigation -->
      <nav class="flex-1 p-4 space-y-3">
        <button @click="currentTab = 'dashboard'" :class="navClass('dashboard')">
          <i class="fas fa-home mr-2"></i> Dashboard
        </button>
        <button @click="currentTab = 'applications'" :class="navClass('applications')">
          <i class="fas fa-file-alt mr-2"></i> Applications
        </button>
        <button @click="currentTab = 'courses'" :class="navClass('courses')">
          <i class="fas fa-book mr-2"></i> Courses
        </button>
        <button @click="currentTab = 'settings'" :class="navClass('settings')">
          <i class="fas fa-cog mr-2"></i> Settings
        </button>
      </nav>

      <!-- Logout -->
      <div class="p-4 border-t border-blue-400">
        <button @click="logout" class="w-full bg-blue-700 hover:bg-blue-600 py-2 rounded-md font-semibold">
          Logout
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 p-6 overflow-y-auto">
      <!-- Dashboard -->
      <section v-if="currentTab === 'dashboard'">
        <h2 class="text-3xl font-bold text-uniscape-blue mb-4">Dashboard Overview</h2>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="bg-white rounded-xl shadow-md p-6 text-center">
            <p class="text-gray-500">Total Applications</p>
            <p class="text-2xl font-bold text-uniscape-blue">{{ stats.totalApplications }}</p>
          </div>
          <div class="bg-white rounded-xl shadow-md p-6 text-center">
            <p class="text-gray-500">Approved</p>
            <p class="text-2xl font-bold text-green-600">{{ stats.approved }}</p>
          </div>
          <div class="bg-white rounded-xl shadow-md p-6 text-center">
            <p class="text-gray-500">Pending</p>
            <p class="text-2xl font-bold text-yellow-500">{{ stats.pending }}</p>
          </div>
        </div>
      </section>

      <!-- Applications -->
      <section v-if="currentTab === 'applications'">
        <h2 class="text-3xl font-bold text-uniscape-blue mb-4">Student Applications</h2>

        <div class="bg-white rounded-xl shadow-md p-4 overflow-x-auto">
          <table class="w-full border-collapse">
            <thead class="bg-uniscape-blue text-white">
              <tr>
                <th class="p-3 text-left">Name</th>
                <th class="p-3 text-left">Course</th>
                <th class="p-3 text-left">Status</th>
                <th class="p-3 text-left">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(app, index) in applications" :key="index" class="border-b hover:bg-gray-100">
                <td class="p-3">{{ app.name }}</td>
                <td class="p-3">{{ app.course }}</td>
                <td class="p-3">
                  <span :class="statusClass(app.status)">{{ app.status }}</span>
                </td>
                <td class="p-3 flex gap-2">
                  <button @click="approve(app)" class="bg-green-600 text-white px-3 py-1 rounded-md">Approve</button>
                  <button @click="reject(app)" class="bg-red-600 text-white px-3 py-1 rounded-md">Reject</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <!-- Courses -->
      <section v-if="currentTab === 'courses'">
        <h2 class="text-3xl font-bold text-uniscape-blue mb-4">Courses</h2>
        <div class="bg-white rounded-xl shadow-md p-4">
          <ul>
            <li v-for="(course, index) in courses" :key="index" class="border-b py-2">
              {{ course.name }}
            </li>
          </ul>
        </div>
      </section>

      <!-- Settings -->
      <section v-if="currentTab === 'settings'">
        <h2 class="text-3xl font-bold text-uniscape-blue mb-4">Settings</h2>
        <p>Admin profile and configuration options go here.</p>
      </section>
    </main>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentTab: 'dashboard',
      stats: {
        totalApplications: 120,
        approved: 75,
        pending: 45
      },
      applications: [
        { name: "John Doe", course: "Computer Science", status: "Pending" },
        { name: "Jane Kim", course: "Business IT", status: "Approved" },
        { name: "Brian Otieno", course: "Cyber Security", status: "Rejected" },
      ],
      courses: [
        { name: "Computer Science" },
        { name: "Business IT" },
        { name: "Cyber Security" }
      ]
    }
  },
  methods: {
    navClass(tab) {
      return this.currentTab === tab
        ? "w-full text-left bg-blue-700 p-2 rounded-md"
        : "w-full text-left hover:bg-blue-600 p-2 rounded-md";
    },
    statusClass(status) {
      return {
        'text-green-600 font-bold': status === 'Approved',
        'text-yellow-600 font-bold': status === 'Pending',
        'text-red-600 font-bold': status === 'Rejected'
      };
    },
    approve(app) {
      app.status = "Approved";
    },
    reject(app) {
      app.status = "Rejected";
    },
    logout() {
      localStorage.clear();
      this.$router.push('/login');
    }
  }
}
</script>
