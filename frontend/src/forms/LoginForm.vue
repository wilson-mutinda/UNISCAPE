<template>
    <div class="pt-32 min-h-screen bg-gray-50 px-8 flex items-center justify-center font-futura">
        <div class="p-8 bg-uniscape-yellow rounded-md w-full max-w-md">
            <form @submit.prevent="userLogin" action="" method="post">

                <!-- email -->
                <div class="">
                    <label class="block text-uniscape-blue font-bold mb-2 text-xl" for="email">Email</label>
                    <input v-model="email" class="rounded-md p-2 w-full outline-none mb-2" type="email" name="email" id="email">
                </div>

                <!-- password -->
                <div class="relative">
                    <label class="block text-uniscape-blue font-bold mb-2 text-xl" for="password">Password</label>
                    <input v-model="password" class="rounded-md p-2 w-full outline-none mb-2" :type="showPassword ? 'text' : 'password'" name="password" id="password">

                    <!-- show and hide button -->
                     <button @click="togglePassword" type="button" class="absolute right-2 top-12">
                        <img :src="showPassword ? '/show.png' : '/hide.png'" alt="show" width="20">
                     </button>
                </div>

                <!-- forgot password -->
                 <div class="text-end mt-2 font-bold">
                    <a class="text-uniscape-blue" href="">Forgot password?</a>
                 </div>

                <!-- login button -->
                 <div class="">
                    <button type="submit" class="font-bold text-white rounded-md bg-uniscape-blue w-full mt-4 p-2">Sign in</button>
                 </div>

                 <!-- or divider -->
                  <div class="flex items-center mt-4">
                    <div class="bg-uniscape-blue flex-grow h-px"></div>
                    <span class="p-2 text-uniscape-blue font-bold">OR</span>
                    <div class="bg-uniscape-blue flex-grow h-px"></div>
                  </div>

                  <!-- google login -->
                   <div class="">
                    <button type="button" class="flex gap-2 items-center justify-center w-full bg-uniscape-blue rounded-md p-2">
                        <img src="/google.png" alt="google" width="30">
                        <p class="text-white font-bold">Continue with Google</p>
                    </button>
                   </div>

                   <!-- divider -->
                    <div class="flex-grow bg-uniscape-blue h-px mt-8"></div>

                   <!-- sign-up -->
                    <div class="text-center mt-4">
                        <p>Don't have an account? <a class="text-uniscape-blue font-bold text-lg" href="">Sign Up</a></p>
                    </div>
            </form>
        </div>
    </div>
</template>

<script>
import api from '@/services/api';

export default {
    data() {
        return {
            email: '',
            password: '',

            errors: {},

            showPassword: false
        }
    },
    methods: {
        async userLogin() {
            this.errors = {}

            try {
                const payload = {
                    email: this.email,
                    password: this.password
                }
                const response = await api.post('user_login', payload)
                console.log("Login Successful.")

                this.clearForm();

            } catch (error) {
                if (error.response && error.response.data && error.response.data.errors) {
                    this.errors = error.response.data.errors
                } else {
                    this.errors.general = "Something went wrong!"
                }
            }
        },

        togglePassword() {
            this.showPassword = !this.showPassword
        },

        clearForm() {
            this.email = '',
            this.password = ''
        }
    }
}
</script>
