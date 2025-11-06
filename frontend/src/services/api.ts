import axios from "axios";
import { ref } from "vue";

export const isOnline = ref(navigator.onLine);
export const isSlowNetwork = ref(false);
export const networkError = ref<string | null>(null);
export const wasOffline = ref(false);

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
    if (wasOffline.value) {
        isOnline.value = true;
        networkError.value = null;
    }
    wasOffline.value = false;
})

window.addEventListener("offline", () => {
    wasOffline.value = true;
    isOnline.value = false;
    networkError.value = "You are offline. Please check your internet connection."
});

// request interceptor
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('access_token');
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }

        if (!navigator.onLine) {
            networkError.value = "No internet connection."
            return Promise.reject(new Error("offline"));
        }
        return config;
    },
    (error) => Promise.reject(error)
);

// Response interceptor
api.interceptors.response.use(
    (response) => {
        // Clear network errors on successful response
        networkError.value = null;
        isSlowNetwork.value = false;
        return response;
    },
    
    async (error) => {
        if (error.response && error.response.status === 401) {
            const originalRequest = error.config;

            // prevent infinite loop
            if (!originalRequest._retry) {
                originalRequest._retry = true;

                try {
                    const refreshToken = localStorage.getItem('refresh_token');
                    if (!refreshToken) {
                        throw new Error("No refresh token found!");
                    }
                    const refreshResponse = await api.post('refresh_token', {}, {
                        headers: {
                            Authorization: `Bearer ${refreshToken}`
                        }
                    } );
    
                    const newAccessToken = refreshResponse.data.new_access_token;
    
                    localStorage.setItem('access_token', newAccessToken);
    
                    originalRequest.headers['Authorization'] = `Bearer ${newAccessToken}`;
                    return api(originalRequest);
                } catch (refreshError) {
                    console.error("Refresh token failed:", refreshError);
                    localStorage.clear();
                    window.location.href = '/login'
                }
            }
        }

        // network errors
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
