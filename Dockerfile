# Use nginx as base image for serving static files
FROM nginx:alpine

# Copy the HTML file and assets to nginx html directory
COPY khabir.html /usr/share/nginx/html/index.html
COPY logo-04.png /usr/share/nginx/html/
COPY apple-store-icon.png /usr/share/nginx/html/
COPY google-play-store-icon.png /usr/share/nginx/html/

# Create custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
