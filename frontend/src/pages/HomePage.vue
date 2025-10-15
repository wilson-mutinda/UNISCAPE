<template>
    <div class="bg-gray-100 min-h-screen">
        <!-- navbar -->
        <nav class="bg-white fixed inset-x-0 top-0 shadow-md z-50">
            <div class="container mx-auto w-full px-4">
                <!-- logo and menu -->
                <div class="flex items-center justify-between h-20">
                    <!-- logo -->
                    <div class="flex items-center gap-2">
                        <img
                            src="/uniscape-logo.png"
                            alt="uniscape-icon"
                            class="w-auto h-20 object-contain"
                        />
                    </div>

                    <!-- menu -->
                    <div class="hidden md:flex items-center gap-4">
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#home"
                            >Home</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#about"
                            >About Us</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#programs"
                            >Programs</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#community"
                            >Community</a
                        >
                        <a
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a
                         class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 transition" 
                         href="#faqs">FAQS</a>
                        <a
                            class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 transition"
                            href="#"
                            >Get Started</a
                        >
                    </div>

                    <!-- mobile menu -->
                    <div class="block md:hidden">
                        <button type="button" @click="toggleMenu">
                            <img src="/logs.png" alt="logs" width="30" />
                        </button>
                    </div>
                </div>

                <!-- mobile menu component -->
                <transition name="slide">
                    <div
                        v-if="showMenu"
                        class="fixed inset-0 left-0 w-64 bg-uniscape-yellow shadow-lg z-40 flex flex-col items-start p-6 space-y-3 md:hidden"
                    >
                        <button
                            @click="toggleMenu"
                            type="button"
                            class="self-end mb-4 text-uniscape-blue font-bold"
                        >
                            <img src="/close.png" alt="close" width="30" />
                        </button>

                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#home"
                            >Home</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#about"
                            >About Us</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#programs"
                            >Programs</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#community"
                            >Community</a
                        >
                        <a
                            @click="toggleMenu"
                            class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left"
                            href="#contacts"
                            >Contact Us</a
                        >
                        <a href="#faqs" class="text-uniscape-blue text-lg hover:text-uniscape-yellow rounded-md hover:bg-uniscape-blue px-4 py-2 w-full text-left">FAQS</a>
                        <a
                            @click="toggleMenu"
                            class="text-lg text-uniscape-yellow rounded-md bg-uniscape-blue px-4 py-2 w-full text-center"
                            href="#"
                            >Get Started</a
                        >
                    </div>
                </transition>
            </div>
        </nav>

        <!-- Hero Section with Background Carousel -->
        <HeroSection />


        <!-- about section -->
        <AboutSection />

        <!-- Learning Experience Section -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">How You'll Learn</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                    <div class="text-center p-6">
                        <div class="bg-uniscape-blue rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                            <img src="/live.png" alt="Live Sessions" width="30">
                        </div>
                        <h4 class="font-bold text-uniscape-blue mb-2">Live Sessions</h4>
                        <p class="text-gray-600">Interactive classes with industry experts</p>
                    </div>
                    
                    <div class="text-center p-6">
                        <div class="bg-uniscape-yellow rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                            <img src="/start-up.png" alt="Projects" width="30">
                        </div>
                        <h4 class="font-bold text-uniscape-blue mb-2">Real Projects</h4>
                        <p class="text-gray-600">Build portfolio with industry projects</p>
                    </div>

                    <div class="text-center p-6">
                        <div class="bg-uniscape-blue rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                            <img src="/opportunity.png" alt="Career Support" width="30">
                        </div>
                        <h4 class="font-bold text-uniscape-blue mb-2">Career Support</h4>
                        <p class="text-gray-600">Job preparation and interview coaching</p>
                    </div>
                    
                    <div class="text-center p-6">
                        <div class="bg-uniscape-yellow rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                            <img src="/mentorship(1).png" alt="Mentorship" width="30">
                        </div>
                        <h4 class="font-bold text-uniscape-blue mb-2">1:1 Mentorship</h4>
                        <p class="text-gray-600">Personalized guidance from professionals</p>
                    </div>
                    
                </div>
            </div>
        </section>

        <!-- programs section -->
        <ProgramSection />

        <!-- Student Success Stories -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Student Success Stories</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">Sarah K.</h4>
                                <p class="text-sm text-gray-600">Data Science Graduate</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"The hands-on projects prepared me perfectly for my role at Safaricom. Landed a job before graduation!"</p>
                    </div>
                    
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">James M.</h4>
                                <p class="text-sm text-gray-600">Full-Stack Developer</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"Mentorship and real-world projects made all the difference. Tripled my salary in 6 months!"</p>
                    </div>
                    
                    <div class="bg-gray-50 rounded-xl p-6 shadow-lg">
                        <div class="flex items-center mb-4">
                            <img src="" alt="Student" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-bold text-uniscape-blue">Grace W.</h4>
                                <p class="text-sm text-gray-600">Cyber Security Analyst</p>
                            </div>
                        </div>
                        <p class="text-gray-700">"The career support team helped me negotiate my current role. Best investment in my career!"</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Upcoming Cohorts -->
        <section class="py-16 bg-uniscape-blue text-white">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-yellow mb-12">Upcoming Cohorts</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
                    <div class="bg-blue-800 rounded-xl p-6 text-center">
                        <div class="text-2xl font-bold mb-2">March 2024</div>
                        <div class="text-uniscape-yellow mb-4">Early Admission</div>
                        <button class="bg-uniscape-yellow text-blue-900 px-6 py-2 rounded-lg font-semibold hover:bg-yellow-300 transition">
                            Apply Now
                        </button>
                    </div>
                    
                    <div class="bg-blue-800 rounded-xl p-6 text-center">
                        <div class="text-2xl font-bold mb-2">June 2024</div>
                        <div class="text-uniscape-yellow mb-4">Regular Admission</div>
                        <button class="border border-uniscape-yellow text-white px-6 py-2 rounded-lg font-semibold hover:bg-uniscape-yellow hover:text-blue-900 transition">
                            Notify Me
                        </button>
                    </div>
                    
                    <div class="bg-blue-800 rounded-xl p-6 text-center">
                        <div class="text-2xl font-bold mb-2">September 2024</div>
                        <div class="text-uniscape-yellow mb-4">Final Intake</div>
                        <button class="border border-uniscape-yellow text-white px-6 py-2 rounded-lg font-semibold hover:bg-uniscape-yellow hover:text-blue-900 transition">
                            Notify Me
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- our partners -->
        <PartnerSection />

        <!-- FAQ Section -->
        <section id="faqs" class="py-20 bg-white">
        <div class="container mx-auto px-4 max-w-7xl">
            <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">
            Frequently Asked Questions
            </h3>

            <!-- FAQ Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- FAQ Card -->
            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                What programs do you offer?
                </h4>
                <p class="text-gray-700 mb-3">
                We offer comprehensive bootcamps in high-demand tech fields:
                </p>
                <ul class="list-disc list-inside text-gray-700 space-y-1 ml-4">
                <li><span class="font-semibold">Data Science & Analytics</span> - Python, SQL, Machine Learning</li>
                <li><span class="font-semibold">Full-Stack Web Development</span> - JavaScript, React, Node.js</li>
                <li><span class="font-semibold">Cyber Security</span> - Ethical Hacking, Network Security</li>
                <li><span class="font-semibold">Mobile App Development</span> - React Native, Flutter</li>
                <li><span class="font-semibold">Cloud Computing</span> - AWS, Azure, DevOps</li>
                </ul>
            </div>

            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                What qualifications do your programs lead to?
                </h4>
                <p class="text-gray-700 mb-3">
                Upon successful completion, graduates receive:
                </p>
                <ul class="list-disc list-inside text-gray-700 space-y-1 ml-4">
                <li><span class="font-semibold">Uniscape Professional Certificate</span></li>
                <li><span class="font-semibold">Portfolio of Real Projects</span></li>
                <li><span class="font-semibold">Technical Skills Assessment</span></li>
                </ul>
            </div>

            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                What learning options are available?
                </h4>
                <p class="text-gray-700 mb-3">
                We offer flexible learning options to suit your schedule:
                </p>
                <ul class="list-disc list-inside text-gray-700 space-y-1 ml-4">
                <li><span class="font-semibold">Full-time(Hybrid) Classes</span> - Mon–Fri, 8am–5pm</li>
                <li><span class="font-semibold">Full-time(Remote) Classes</span> - Mon–Fri, 8am–5pm</li>
                <li><span class="font-semibold">Part-time(Remote) Classes</span> - Mon–Fri, 6pm–9pm, Saturday 9am - 1pm</li>
                </ul>
            </div>

            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                What industry placement support do you provide?
                </h4>
                <ul class="list-disc list-inside text-gray-700 space-y-2 ml-4">
                <li><span class="font-semibold">Career Coaching</span> - 1:1 mentorship</li>
                <li><span class="font-semibold">Interview Prep</span> - Technical and soft skills</li>
                <li><span class="font-semibold">Portfolio Review</span> - GitHub optimization</li>
                </ul>
                <p class="text-gray-700 mt-3 font-semibold">
                65% of our graduates secure tech roles within 4 - 8 months.
                </p>
            </div>

            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                When are your program intakes?
                </h4>
                <div class="space-y-2">
                <div class="bg-blue-50 p-3 rounded-lg text-center">
                    <span class="text-uniscape-blue font-bold">January Intake</span>
                </div>
                <div class="bg-blue-50 p-3 rounded-lg text-center">
                    <span class="text-uniscape-blue font-bold">April Intake</span>
                </div>
                <div class="bg-blue-50 p-3 rounded-lg text-center">
                    <span class="text-uniscape-blue font-bold">July Intake</span>
                </div>
                <div class="bg-blue-50 p-3 rounded-lg text-center">
                    <span class="text-uniscape-blue font-bold">October Intake</span>
                </div>
                </div>
                <p class="text-gray-700 mt-4 text-center text-sm">
                </p>
            </div>

            <div
                class="border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-lg hover:-translate-y-1 transition"
            >
                <h4 class="font-bold text-uniscape-blue text-lg mb-2">
                Why choose Uniscape over other bootcamps?
                </h4>
                <ul class="list-disc list-inside text-gray-700 space-y-2 ml-4">
                <li>Real Projects & Industry Experts</li>
                <li>Lifetime Career Support</li>
                <li>Strong Alumni Network</li>
                <li>Flexible Payment Options</li>
                </ul>
            </div>
            </div>
        </div>
        </section>

        <!-- community section -->
        <section id="community" class="bg-gray-50 py-16">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">Join Our Community</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
                    <div class="bg-white rounded-xl p-8 shadow-lg text-center">
                        <div class="bg-uniscape-blue rounded-full w-20 h-20 flex items-center justify-center mx-auto mb-6">
                            <img src="" alt="Network" width="40">
                        </div>
                        <h4 class="text-2xl font-bold text-uniscape-blue mb-4">Alumni Network</h4>
                        <p class="text-gray-600 mb-6">Connect with 500+ graduates working at top tech companies across Africa and beyond.</p>
                        <button class="bg-uniscape-yellow text-blue-900 px-6 py-3 rounded-lg font-semibold hover:bg-yellow-300 transition">
                            Join Network
                        </button>
                    </div>
                    
                    <div class="bg-white rounded-xl p-8 shadow-lg text-center">
                        <div class="bg-uniscape-blue rounded-full w-20 h-20 flex items-center justify-center mx-auto mb-6">
                            <img src="" alt="Events" width="40">
                        </div>
                        <h4 class="text-2xl font-bold text-uniscape-blue mb-4">Tech Events</h4>
                        <p class="text-gray-600 mb-6">Participate in hackathons, workshops, and networking events with industry leaders.</p>
                        <button class="bg-uniscape-blue text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-900 transition">
                            View Events
                        </button>
                    </div>
                </div>
            </div>
        </section>

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
        
    </div>
</template>

<script>
import AboutSection from '@/components/AboutSection.vue';
import HeroSection from '@/components/HeroSection.vue';
import PartnerSection from '@/components/PartnerSection.vue';
import ProgramSection from '@/components/ProgramSection.vue';
import router from '@/router';
import api from '@/services/api';

export default {
    name: 'HomePage',
    components: {
        AboutSection,
        ProgramSection,
        HeroSection,
        PartnerSection
    },

    data() {
        return {
            showMenu: false,

            images: [
                '/code1.jpg',
                '/code3.jpg',
                // '/code4.jpg',
                '/code5.jpg',
                '/code6.jpg',
                '/code7.jpg'
            ],

            currentIndex: 0,
            interval: null,
            allCourses: [],
            courseId: '',

            courseName: '',
            courseDuration: '',
            courseFee: '',
            courseDesc: '',
            courseMoreInfo: '',
            courseImage: '',
            errors: {},

            loadingCourseId: null
        }
    },
    methods: {

        async openSingleCoursePage(course){
            this.loadingCourseId = course.id
            try {
                this.courseId = course.id
    
                const response = await api.get(`single_course/${this.courseId}`);
                
                const data = response.data;

                localStorage.setItem('course_name', data.course_name);
                localStorage.setItem('course_duration', data.course_duration);
                localStorage.setItem('course_fee', data.course_fee);
                localStorage.setItem('course_desc', data.course_desc);
                localStorage.setItem('course_more_info', data.course_more_info);
                localStorage.setItem('course_image', data.course_image);

                this.$router.push({ name: 'course-page'});

                this.loadingCourseId = null

            } catch (error) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors
                } else {
                    this.errors.general = 'Something went wrong!'
                }
            }
        },

        async fetchAllCourses() {
            const response = await api.get('all_courses');
            this.allCourses = response.data;
        },

        scrollToSection(id) {
            const el = document.getElementById(id)
            if (el) {
                el.scrollIntoView({ behavior: 'smooth'});
            }
        },
        toggleMenu() {
            this.showMenu = !this.showMenu;
        },

        nextImage(){
            this.currentIndex = (this.currentIndex + 1) % this.images.length;
            this.restartAutoSlide();
        },

        prevImage(){
            this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length;
            this.restartAutoSlide();
        },

        startAutoSlide(){
            this.interval = setInterval(() => {
                this.nextImage();
            }, 5000);
        },

        restartAutoSlide(){
            clearInterval(this.interval);
            this.startAutoSlide();
        },
    },

    mounted() {
        this.fetchAllCourses();
        this.startAutoSlide();
    },

    beforeUnmount(){
        clearInterval(this.interval);
    }
};

</script>

<style scoped>
.slide-enter-active, .slide-leave-active {
    transition: transform 0.3s ease;
}
.slide-enter-from, .slide-leave-to {
    transform: translateX(-100%);
}

@keyframes marquee {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
}
.animate-marquee {
    animation: marquee 30s linear infinite;
}
</style>