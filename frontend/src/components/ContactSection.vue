<template>
    <section id="contacts" class="bg-gray-50 py-20 pt-28 font-futura">
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

                    <form @submit.prevent="createContact" action="" method="post" class="space-y-4">
                        <!-- name -->
                        <div>
                            <label class="block text-lg mb-1 font-medium" for="name">Name</label>
                            <input
                                class="w-full p-3 rounded-md ring-1 outline-none ring-gray-300 hover:ring-uniscape-blue focus:ring-uniscape-blue"
                                type="text"
                                name="name"
                                id="name"
                                placeholder="Your full name"
                                v-model="name"
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
                                v-model="email"
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
                                v-model="message"
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
                                    Blue Violets Plaza, Ground Floor, <br />
                                    Kindaruma Road (off Ngong Road)<br />
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

                        <!-- Whatsapp -->
                         <div class="flex gap-4 items-start">
                            <img src="/whatsapp.png" alt="whatsapp" width="30" class="mt-1" />
                            <div class="">
                                <h4 class="font-semibold text-lg text-uniscape-blue mb-1">WhatsApp</h4>
                                <a
                                href="https://wa.me/254729146152"
                                target="_blank"
                                class="text-gray-700 hover:text-uniscape-yellow">
                                +254 729 146 152
                                </a>
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
</template>

<script>
import api from '@/services/api';

export default {
    data() {
        return {
            email: '',
            name: '',
            message: '',

            errors: {}
        }
    },

    methods: {
        async createContact() {
            this.errors = {};
            try {
                const payload = {
                    contact: {
                        email: this.email,
                        name: this.name,
                        message: this.message
                    }
                };
                const response = await api.post('create_contact', payload);
                console.log("Contact created successfully!");
                alert("Contact created!");
                this.clearForm();
                this.errors = {}
            } catch (error) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors
                } else {
                    this.errors.general = "Something went wrong!"
                }
            }
        },

        clearForm() {
            this.name = '',
            this.email = '',
            this.message = ''
        }
    }
}
</script>
