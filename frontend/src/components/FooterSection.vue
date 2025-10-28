<template>
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
                    <li><a @click.prevent="goToSection('home')" href="#home" class="hover:text-uniscape-yellow transition">Home</a></li>
                    <li><a @click.prevent="goToSection('about')" href="#about" class="hover:text-uniscape-yellow transition">About Us</a></li>
                    <li><a @click.prevent="goToSection('programs')" href="#programs" class="hover:text-uniscape-yellow transition">Programs</a></li>
                    <li><a @click.prevent="goToSection('community')" href="#community" class="hover:text-uniscape-yellow transition">Community</a></li>
                    <li><a @click.prevent="goToSection('contacts')" href="#contacts" class="hover:text-uniscape-yellow transition">Contact Us</a></li>
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
                        <a
                         href="https://wa.me/254729146152"
                         target="_blank"
                         rel="noopener noreferrer"
                         class="flex items-center gap-3 hover:text-uniscape-yellow transition"
                         >
                         <img
                          src="/whatsapp.png" 
                          width="20"
                          alt="whatsapp"
                          class="rounded-full bg-uniscape-blue p-1" />
                          <span>+254 729 146 152</span>
                        </a>
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
</template>

<script>
export default {
    data() {
        return {}
    },

    methods: {
        goToSection(id) {
            if (this.$route.path !== '/home' && this.$route.path !== '/')
            this.$router.push('/home').then(() => {
                setTimeout(() => {
                    const el = document.getElementById(id);
                    if (el) el.scrollIntoView({ behavior: 'smooth'});
                }, 500);
        });
        else {
            const el = document.getElementById(id);
            if (el) el.scrollIntoView({ behavior: 'smooth'});
        }
        },
    }
}
</script>