# Stage 1: Build React app
FROM node:20 AS build

WORKDIR /app

# Set environment variables for build (must start with VITE_ for Vite)
ENV VITE_TMDB_API_KEY=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTY0YWQxZjYxZGVjZThiMDFmODI4Y2QxNmYzOTY4MyIsIm5iZiI6MTc2NjU5NDYxNy42NTYsInN1YiI6IjY5NGMxODM5NmRkYzY1ZGFmMjgxMTViZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lJlnKZJdTmrLFbRSuJ0SHGVUXwuz_kFVRzhOK16WodM
ENV NODE_ENV=production

# Copy package files first for caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy all source files
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Set runtime environment variables if needed
ENV NGINX_HOST=0.0.0.0
ENV NGINX_PORT=80

# Copy Vite build output to Nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom Nginx config if you have one (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
