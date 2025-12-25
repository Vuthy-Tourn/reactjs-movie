# Stage 1: Build React app
FROM node:20 AS build

WORKDIR /app

# Copy package files first for caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy all source files
COPY . .

# Build the app (Vite will output to /app/dist)
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy Vite build output to Nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]