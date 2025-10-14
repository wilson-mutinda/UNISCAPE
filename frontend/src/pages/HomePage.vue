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
        <section
        id="home"
        class="relative w-full h-[90vh] flex items-center justify-center text-center text-white overflow-hidden"
        >
        <!-- Background Carousel -->
        <div class="absolute inset-0 w-full h-full overflow-hidden">
            <img
            v-for="(image, index) in images"
            :key="index"
            :src="image"
            :class="{ 'opacity-100': currentIndex === index, 'opacity-0': currentIndex !== index }"
            class="absolute inset-0 w-full h-full object-cover transition-opacity duration-1000 ease-in-out"
            alt="carousel background"
            />
        </div>

        <!-- Overlay -->
        <div class="absolute inset-0 bg-black/40"></div>

        <!-- Hero Content -->
        <div class="relative z-10 container mx-auto px-4">
            <h1 class="text-4xl md:text-6xl font-bold mb-6 animate-fadeIn">
            Empowering the Next Tech Generation
            </h1>
            <p class="text-lg md:text-xl mb-8 max-w-2xl mx-auto">
            Join Uniscape and master the skills to shape tomorrow's technology today.
            </p>

            <div class="flex items-center justify-center gap-4">
            <button
                type="button"
                class="bg-white text-uniscape-blue font-semibold px-6 py-3 rounded-full hover:bg-yellow-300 transition"
                @click="scrollToSection('programs')"
            >
                Get Started
            </button>
            </div>
        </div>

        <!-- Optional Controls -->
        <button
            type="button"
            @click="prevImage"
            class="absolute left-5 top-1/2 -translate-y-1/2 bg-white/50 hover:bg-white text-gray-800 p-2 rounded-full shadow-md z-10"
        >
            <img src="/back.png" alt="back" width="30" />
        </button>

        <button
            type="button"
            @click="nextImage"
            class="absolute right-5 top-1/2 -translate-y-1/2 bg-white/50 hover:bg-white text-gray-800 p-2 rounded-full shadow-md z-10"
        >
            <img src="/next.png" alt="next" width="30" />
        </button>
        
        
        </section>


        <!-- about section -->
        <section id="about" class="bg-gray-50 py-16">
            <div class="container mx-auto px-4">
                <h3 class="text-3xl text-center font-semibold text-uniscape-blue mb-12">About Us</h3>

                <!-- about info -->
                <div class="flex flex-col items-center justify-between gap-8 md:flex-row">
                    <!-- logo -->
                    <div class="bg-gradient-to-br from-uniscape-blue to-blue-900 rounded-xl w-full md:w-1/2 flex justify-center items-center p-6 shadow-lg">
                        <img src="/uniscape-icon.png" alt="library" width="300">
                    </div>
                    <!-- info -->
                    <div class="w-full md:w-1/2">
                        <h3 class="font-bold text-2xl text-center mb-4 text-uniscape-blue">Why Choose UNISCAPE?</h3>
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
        <section id="programs" class="py-16 bg-gray-50">
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
        <footer class="bg-uniscape-blue text-white py-12">
            <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8">

                <!-- Logo and description -->
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <img src="/uniscape-icon.png" alt="Uniscape logo" class="h-12">
                        <h3 class="text-2xl font-bold text-uniscape-yellow">Uniscape</h3>
                    </div>
                    <p class="text-gray-200 leading-relaxed text-sm">
                        Empowering Africa's next generation of tech talent through hands-on, 
                        project-based learning and global opportunities.
                    </p>
                </div>

                <!-- Quick Links -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Quick Links</h4>
                    <ul class="space-y-2">
                        <li><a href="#home" class="hover:text-uniscape-yellow transition">Home</a></li>
                        <li><a href="#about" class="hover:text-uniscape-yellow transition">About Us</a></li>
                        <li><a href="#programs" class="hover:text-uniscape-yellow transition">Programs</a></li>
                        <li><a href="#community" class="hover:text-uniscape-yellow transition">Community</a></li>
                        <li><a href="#contacts" class="hover:text-uniscape-yellow transition">Contact Us</a></li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Contact</h4>
                    <ul class="space-y-3 text-sm">
                        <li class="flex items-center gap-3">
                            <img src="/map-pin-house.png" width="28" alt="location" class="bg-uniscape-yellow rounded-full p-1">
                            <span>Blue Violets Plaza, Kindaruma Rd, Nairobi</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <img src="/phone.png" width="28" alt="phone" class="rounded-full bg-uniscape-yellow p-1">
                            <span>+254 700 223 222</span>
                        </li>
                        <li class="flex items-center gap-3">
                            <img src="/mail.png" width="28" alt="email" class="rounded-full bg-uniscape-yellow p-1">
                            <a href="mailto:info@uniscape.co.ke" class="hover:text-uniscape-yellow underline">info@uniscape.co.ke</a>
                        </li>
                    </ul>
                </div>

                <!-- Socials -->
                <div>
                    <h4 class="text-xl font-semibold text-uniscape-yellow mb-4">Follow Us</h4>
                    <div class="flex space-x-4">
                        <a href="#" aria-label="Facebook" class="hover:scale-110 transition transform">
                            <img src="/facebook.png" alt="Facebook" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="Twitter" class="hover:scale-110 transition transform">
                            <img src="/twitter.png" alt="Twitter" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="LinkedIn" class="hover:scale-110 transition transform">
                            <img src="/linkedin.png" alt="LinkedIn" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                        <a href="#" aria-label="Instagram" class="hover:scale-110 transition transform">
                            <img src="/instagram.png" alt="Instagram" width="28" class="bg-uniscape-yellow rounded-full p-1">
                        </a>
                    </div>
                </div>
            </div>

            <!-- Divider -->
            <div class="border-t border-yellow-400 my-8"></div>

            <!-- Bottom Copyright -->
            <div class="text-center text-sm text-gray-200">
                © {{ new Date().getFullYear() }} Uniscape Consulting. All rights reserved.
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
                { id: 1, name: "Data Science", duration: 6, fees: "85,000" },
                { id: 2, name: "Web Development", duration: 4, fees: "75,000" },
                { id: 3, name: "Cyber Security", duration: 5, fees: "90,000" },
                { id: 4, name: "Mobile Development", duration: 4, fees: "80,000" },
                { id: 5, name: "Cloud Computing", duration: 5, fees: "95,000" }
            ],
            partners: [
                { image: "/ajira.png" },
                { image: "/google.png" },
                { image: "/huawei.svg" },
                { image: "/icta.png" },
                { image: "/mastercard-foundation.png" },
                { image: "/microsoft.png" },
                { image: "/oracle.png" },
                { image: "/safaricom-foundation.jpg" }
            ],
            images: [
                '/code1.jpg',
                '/code3.jpg',
                // '/code4.jpg',
                '/code5.jpg',
                '/code6.jpg',
                '/code7.jpg'
            ],

            currentIndex: 0,
            interval: null
        }
    },
    methods: {

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