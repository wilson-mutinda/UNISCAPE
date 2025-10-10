<template>
    <div class="bg-gray-100 min-h-screen">
        <!-- navbar -->
        <nav class="bg-white fixed right-0 left-0 top-0 shadow-md z-50" style="max-height: 60px;">

            <div class="container mx-auto w-full px-4">
                <!-- logo and menu -->
                 <div class="flex items-center justify-between">
                    <!-- logo -->
                     <div class="flex items-center gap-2">
                        <img src="/uniscape-icon.png" alt="uniscape-icon" class="h-12 scale-150 object-contain -translate-y-1">
                     </div>
                     <!-- menu -->
                      <div class="hidden md:flex items-center gap-4">
                        <a class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2" href="#">Home</a>
                        <a class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2" href="#about">About Us</a>
                        <a class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2" href="#programs">Programs</a>
                        <a class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2" href="#community">Community</a>
                        <a class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2" href="#contacts">Contact Us</a>
                        <a class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2" href="#">Get Started</a>
                      </div>

                      <!-- mobile menu -->
                       <div class="block md:hidden">
                        <button type="button" @click="toggleMenu">
                            <img src="/logs.png" alt="logs" width="30">
                        </button>
                       </div>
                 </div>

                 <!-- mobile menu component -->
                  <transition name="slide">
                    <div v-if="showMenu" class="fixed inset-0 left-0 w-64 bg-uniscape-yellow shadow-lg z-40 flex flex-col items-start p-6 space-y-3 md:hidden">
                        <button @click="toggleMenu" type="button" class="self-end mb-4 text-uniscape-blue font-bold">
                            <img src="/close.png" alt="close" width="30">
                        </button>

                        <a @click="toggleMenu" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left" href="#">Home</a>
                        <a @click="toggleMenu" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left" href="#about">About Us</a>
                        <a @click="toggleMenu" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left" href="#programs">Programs</a>
                        <a @click="toggleMenu" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left" href="#community">Community</a>
                        <a @click="toggleMenu" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left" href="#contacts">Contact Us</a>
                        <a @click="toggleMenu" class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 w-full text-center" href="#">Get Started</a>
                    </div>
                  </transition>
            </div>
        </nav>

        <!-- hero section -->
        <section id="#" class="py-16 bg-gradient-to-r from-uniscape-blue to-blue-900 pt-24">
            <div class="container mx-auto px-4">
                <h1 class="text-uniscape-yellow text-center text-5xl font-bold mb-4 mt-4">Empowering Next Tech Talent</h1>
                <p class="text-white text-center mx-auto max-w-2xl text-xl mb-4">Data-driven insights, digital transformation, hands-on training programs designed for real-world success</p>

                <!-- buttons -->
                 <div class="flex items-center justify-center gap-4">
                    <button type="button" class="bg-uniscape-yellow text-blue-900 px-5 py-3 rounded-md font-semibold shadow-lg hover:bg-yellow-300 transition">Get Started</button>
                    <button type="button" class="border border-uniscape-yellow text-white px-5 py-3 rounded-md font-semibold hover:bg-uniscape-yellow hover:text-blue-900 transition">Learn More</button>
                 </div>
            </div>
        </section>

        <!-- about section -->
        <section id="about" class="bg-gray-50 py-16">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">About Us</h3>

                <!-- about info -->
                 <div class="flex flex-col items-center justify-between gap-8 md:flex-row">
                    <!-- logo -->
                     <div class="bg-gradient-to-br from-uniscape-blue to-blue-900 rounded-xl w-full md:w-1/2 flex justify-center items-center p-6 shadow-lg">
                        <img src="/library.png" alt="library" width="300">
                     </div>
                     <!-- info -->
                      <div class="w-full md:w-1/2">
                        <h3 class="font-bold text-2xl text-center mb-4 text-uniscape-blue">Why Choose NETSCAPE?</h3>
                        <p class="text-lg text-gray-600 mb-4">Uniscape Consulting is a professional training and technology 
                            solutions company dedicated to bridging Africa&apos;s digital skill gap. Through 
                            hands-on bootcamps, mentorship, and project-based learning, we empower learners 
                            to master in-demand digital skills that prepare them for the global market.
                        </p>
                        <div class="">
                            <ul class="space-y-3">
                                <li class="flex items-center gap-2">
                                    <img src="/checked.png" alt="checked" width="20">
                                    <span>Hands-on training</span>
                                </li>

                                <li class="flex items-center gap-2">
                                    <img src="/checked.png" alt="checked" width="20">
                                    <span>Project-based learning</span>
                                </li>

                                <li class="flex gap-2 items-center">
                                    <img src="/checked.png" alt="checked" width="20">
                                    <span>Career Mentorship</span>
                                </li>

                                <li class="flex gap-2 items-center">
                                    <img src="/checked.png" alt="checked" width="20">
                                    <span>Online/Physical learning</span>
                                </li>

                                <li class="flex gap-2 items-center">
                                    <img src="/checked.png" alt="checked" width="20">
                                    <span>Full-time/Part-time classes</span>
                                </li>
                            </ul>
                        </div>
                      </div>
                 </div>
            </div>
        </section>

        <!-- programs section -->
        <section id="programs" class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Our Programmes</h3>

                <!-- featured courses -->
                 <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div v-for="(course, index) in featured" :key="course.id" class="bg-gradient-to-b from-uniscape-yellow to-yellow-50 rounded-2xl shadow-lg p-6 hover:-translate-y-2 transition-transform duration-300">
                        <h4 class="text-2xl font-bold text-uniscape-blue mb-3">{{ course.name }}</h4>
                        <p class="text-gray-700 mb-2">
                            <span class="font-semibold text-uniscape-blue">Duration:</span> {{ course.duration }} months
                        </p>

                        <p class="text-gray-700 mb-4">
                            <span class="font-semibold text-uniscape-blue">Fees:</span> KES {{ course.fees }}
                        </p>

                        <p class="text-gray-600 mb-6">
                            Learn the latest tools and skills in {{ course.name }} with hands on projects, expert mentors, and a global-ready curriculum.
                        </p>

                        <button type="button" class="bg-uniscape-blue text-yellow-300 px-5 py-2 rounded-md font-semibold hover:bg-blue-900 transition">
                            Explore Course
                        </button>
                    </div>
                 </div>
            </div>
        </section>

        <!-- our partners -->
         <section class="bg-gray-50 py-16">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-4">Our Partners</h3>

                <!-- partners -->
                 <div class="flex items-center space-x-10 animate-marquee">
                    <div v-for="(partner, index) in partners" :key="index" class="flex-shrink-0 flex items-center justify-center">
                        <img :src="partner.image" :alt="partner.image" class="h-20 object-contain">
                    </div>
                 </div>
            </div>
         </section>

        <!-- community section -->
        <section id="#"></section>

        <!-- contact section -->
        <section id="contacts" class="bg-gray-50 py-20">
        <div class="container mx-auto px-4">
            <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">
            Contact Us
            </h3>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- contact form -->
            <div class="bg-white shadow-lg rounded-lg p-6">
                <h3 class="font-bold text-2xl mb-4 text-uniscape-blue">
                Send us a message
                </h3>

                <form action="" method="post" class="space-y-4">
                <!-- name -->
                <div>
                    <label class="block text-lg mb-1 font-medium" for="name">Name</label>
                    <input
                    class="w-full p-3 rounded-md ring-1 outline-none ring-gray-300 hover:ring-uniscape-blue focus:ring-uniscape-blue"
                    type="text"
                    name="name"
                    id="name"
                    placeholder="Your full name"
                    />
                </div>

                <!-- email -->
                <div>
                    <label class="block text-lg mb-1 font-medium" for="email">Email</label>
                    <input
                    class="w-full p-3 rounded-md ring-1 outline-none ring-gray-300 hover:ring-uniscape-blue focus:ring-uniscape-blue"
                    type="email"
                    name="email"
                    id="email"
                    placeholder="you@example.com"
                    />
                </div>

                <!-- message -->
                <div>
                    <label class="block text-lg mb-1 font-medium" for="message">Message</label>
                    <textarea
                    class="w-full p-3 rounded-md ring-1 outline-none ring-gray-300 hover:ring-uniscape-blue focus:ring-uniscape-blue"
                    name="message"
                    id="message"
                    rows="4"
                    placeholder="Write your message here..."
                    ></textarea>
                </div>

                <!-- submit button -->
                <button
                    class="w-full rounded-md bg-uniscape-blue hover:bg-[#27457D] p-3 text-white font-semibold transition duration-300"
                >
                    Send Message
                </button>
                </form>
            </div>

            <!-- contact info -->
            <div class="bg-white shadow-lg rounded-lg p-6">
                <h3 class="font-bold text-2xl mb-6 text-uniscape-blue">Get in Touch</h3>

                <div class="space-y-6">
                <!-- Address -->
                <div class="flex gap-4 items-start">
                    <img src="/map-pin-house.png" alt="address" width="30" class="mt-1" />
                    <div>
                    <h4 class="font-semibold text-lg text-uniscape-blue mb-1">Address</h4>
                    <p class="text-gray-700 leading-relaxed">
                        Blue Violets Plaza, Ground Floor, Kindaruma Road (off Ngong Road)<br />
                        P.O. Box 56936 - 00200, Nairobi, Kenya
                    </p>
                    </div>
                </div>

                <!-- Phone -->
                <div class="flex gap-4 items-start">
                    <img src="/phone.png" alt="phone" width="30" class="mt-1" />
                    <div>
                    <h4 class="font-semibold text-lg text-uniscape-blue mb-1">Phone</h4>
                    <p class="text-gray-700">+254 700 223 222</p>
                    <p class="text-gray-700">+254 729 146 152</p>
                    </div>
                </div>

                <!-- Email -->
                <div class="flex gap-4 items-start">
                    <img src="/mail.png" alt="email" width="30" class="mt-1" />
                    <div>
                    <h4 class="font-semibold text-lg text-uniscape-blue mb-1">Email</h4>
                    <a
                        href="mailto:info@uniscape.co.ke"
                        class="text-gray-700 hover:text-uniscape-blue underline"
                    >
                        info@uniscape.co.ke
                    </a>
                    </div>
                </div>
                </div>
            </div>

            <!-- Google Map -->
            <div class="shadow-lg rounded-lg overflow-hidden h-80">
                <iframe
                class="w-full h-full border-0"
                loading="lazy"
                allowfullscreen
                referrerpolicy="no-referrer-when-downgrade"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3988.806581841831!2d36.78989487404218!3d-1.299163135633436!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x182f10e6a2f531a1%3A0x61d4a52d44cc2433!2sBlue%20Violets%20Plaza%2C%20Kindaruma%20Rd%2C%20Nairobi!5e0!3m2!1sen!2ske!4v1696162440903!5m2!1sen!2ske"
                ></iframe>
            </div>
            </div>
        </div>
        </section>

        <!-- footer -->
        <footer class="py-14 bg-uniscape-blue">
            <div class="container px-4 mx-auto">
                <!-- copyright -->
                 <p class="text-lg text-uniscape-yellow">© {{ new Date().getFullYear()}} Uniscape Consulting. All rights reserved.</p>
            </div>
        </footer>

    </div>
</template>

<script>
export default {
    data() {
        return {
            showMenu: false,

            featured: [
                { name: 'CyberSecurity', duration: "6", fees: "200, 000"},
                { name: 'Data Science', duration: "6", fees: "200, 000"},
                { name: "Software Engineering", duration: "6", fees: "200, 000"},
                { name: "Data Analytics", duration: "6", fees: "200, 000"},
                { name: "AI Essentials", duration: "3", fees: "120, 000"}
            ],

            contacts: [
                { title: 'Address', desc: ['Blue Violets Plaza, Ground Floor, Kindaruma Road (off Ngong Road) P.O. Box 56936 - 00200, Nairobi'], img: '/map-pin-house.png' },
                { title: 'Phone', desc: '[+254 700 223 222, +254 729 146 152]', img: '/phone.png' },
                { title: 'Email', desc: ['info@uniscape.co.ke'], img: '/mail.png' },
            ],

            partners: [
                { image: '/ajira.png'},
                { image: '/google.png'},
                { image: '/huawei.svg'},
                { image: '/icta.png'},
                { image: '/mastercard-foundation.png'},
                { image: '/microsoft.png'},
                { image: '/oracle.png'},
                { image: '/safaricom-foundation.jpg'},
            ]
        }
    },

    methods: {
        toggleMenu() {
            this.showMenu = !this.showMenu
        }
    }
}
</script>

<style scoped>
    @keyframes marquee {
    0% {
        transform: translateX(0%);
    }
    100% {
        transform: translateX(-50%);
    }
    }

    .animate-marquee {
    display: flex;
    width: max-content;
    animation: marquee 18s linear infinite;
    }

    .animate-marquee:hover {
    animation-play-state: paused;
    }

    .slide-enter-active,
    .slide-leave-active {
        transition: transform 0.4s ease, opacity 0.3s ease;
    }

    .slide-enter-from {
        transform: translateX(-100%);
        opacity: 0;
    }

    .slide-enter-to {
        transform: translateX(0);
        opacity: 1;
    }

    .slide-leave-from {
        transform: translateX(0);
        opacity: 1;
    }

    .slide-leave-to {
        transform: translateX(-100%);
        opacity: 0;
    }

</style>
