/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'uniscape-blue': '#1B325E',
        'uniscape-yellow': '#E5A233'
      }
    },
  },
  plugins: [],
}

