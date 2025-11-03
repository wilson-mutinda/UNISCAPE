import axios from "axios";
import { ref } from "vue";

export const isOnline = ref(navigator.onLine);
export const isSlowNetwork = ref(false);
export const networkError = ref<string | null>(null);

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL || 'http://127.0.0.1:3000/api/v1/',
    headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
    },
    timeout: 15000,
});

// handle browser online/offline events
window.addEventListener("online", () => {
    isOnline.value = true;
    isSlowNetwork.value = false;
    networkError.value = null;

    // automatically reload
    setTimeout(() => {
        window.location.reload();
    }, 1500);
});

window.addEventListener("offline", () => {
    isOnline.value = false;
    networkError.value = "You are offline. Please check your internet connection."
});

// request interceptor
api.interceptors.request.use(
    (config) => {
        if (!navigator.onLine) {
            networkError.value = "No internet connection."
            return Promise.reject(new Error("offline"));
        }
        return config;
    },
    (error) => Promise.reject(error)
);

// Response interceptor - FIXED
api.interceptors.response.use(
    (response) => {
        // Clear network errors on successful response
        networkError.value = null;
        isSlowNetwork.value = false;
        return response;
    },
    (error) => {
        console.error("API Error:", error);
        
        if (error.code === "ECONNABORTED") {
            isSlowNetwork.value = true;
            networkError.value = "Slow network detected. Please try again later.";
        } else if (error.response) {
            networkError.value = `Server Error: ${error.response.status} - ${error.response.statusText}`;
        } else if (error.request) {
            networkError.value = "No response from server. Please check your connection.";
        } else {
            networkError.value = "Network error occurred.";
        }
        return Promise.reject(error);
    }
);

export default api;
