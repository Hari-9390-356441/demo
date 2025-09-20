# Use official nginx base image
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/hari

# Remove default nginx index page
RUN rm -rf ./*

# Copy project files (HTML, CSS, images) into nginx public folder
COPY . .

# Expose port 80 for the web server
EXPOSE 80

# Start nginx (default CMD already in base image)

