# Khabir Portfolio - Docker Deployment Guide

This guide will help you deploy the Khabir Portfolio website to your VPS using Docker.

## 📋 Prerequisites

- VPS with Docker and Docker Compose installed ✅ (Already confirmed on your VPS)
- SSH access to your VPS ✅ (Already connected)
- Available ports: 8080 (recommended) or 8081, 8082, etc.

## 🔍 VPS Analysis

Based on the port scan, your VPS has the following ports in use:

- **Port 80**: Already in use (likely Apache/Nginx)
- **Port 3000**: Already in use
- **Port 8443**: CloudPanel admin interface
- **Port 8080**: Available ✅ (Recommended for deployment)

## 🚀 Deployment Steps

### 1. Upload Files to VPS

First, upload all the project files to your VPS:

```bash
# From your local machine, upload files to VPS
scp -r . khabeer:/root/khabir-portfolio/
```

### 2. Connect to VPS and Deploy

```bash
# SSH into your VPS
ssh khabeer

# Navigate to project directory
cd /root/khabir-portfolio

# Make deployment script executable
chmod +x deploy.sh

# Run deployment
./deploy.sh
```

### 3. Manual Deployment (Alternative)

If you prefer manual deployment:

```bash
# Create logs directory
mkdir -p logs

# Build and start the container
docker-compose up -d --build

# Check container status
docker-compose ps

# View logs
docker-compose logs -f
```

## 🌐 Access Your Website

After successful deployment, your portfolio will be available at:

- **Local VPS**: `http://localhost:8080`
- **External**: `http://YOUR_VPS_IP:8080`

## 📊 Monitoring

### Check Container Status

```bash
docker-compose ps
```

### View Logs

```bash
# All logs
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# Last 50 lines
docker-compose logs --tail=50
```

### Health Check

```bash
# Check if website is responding
curl http://localhost:8080/health
```

## 🔧 Management Commands

### Stop the Application

```bash
docker-compose down
```

### Restart the Application

```bash
docker-compose restart
```

### Update the Application

```bash
# Pull latest changes and rebuild
git pull
docker-compose down
docker-compose up -d --build
```

### View Resource Usage

```bash
docker stats khabir-portfolio
```

## 🔒 Security Features

The deployment includes several security features:

- Security headers (X-Frame-Options, X-XSS-Protection, etc.)
- Content Security Policy
- Gzip compression
- Static asset caching
- Health check endpoint

## 📁 File Structure

```
khabir-portfolio/
├── khabir.html              # Main website file
├── logo-04.png             # Logo image
├── apple store icon.png    # App Store icon
├── google play store icon.png # Google Play icon
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── nginx.conf              # Nginx configuration
├── deploy.sh               # Deployment script
├── .dockerignore           # Docker ignore file
└── logs/                   # Log files directory
```

## 🐛 Troubleshooting

### Container Won't Start

```bash
# Check logs for errors
docker-compose logs

# Check if port is already in use
netstat -tuln | grep 8080
```

### Website Not Loading

```bash
# Check container status
docker-compose ps

# Check nginx configuration
docker exec khabir-portfolio nginx -t

# Restart container
docker-compose restart
```

### Permission Issues

```bash
# Fix file permissions
chmod +x deploy.sh
chmod 644 *.html *.png *.conf
```

## 🔄 Updates

To update your website:

1. Make changes to `khabir.html` or other files
2. Run: `docker-compose up -d --build`
3. The changes will be live immediately

## 📈 Performance

The setup includes:

- Nginx for high-performance static file serving
- Gzip compression for faster loading
- Browser caching for static assets
- Optimized Docker image based on Alpine Linux

## 🆘 Support

If you encounter any issues:

1. Check the logs: `docker-compose logs`
2. Verify container status: `docker-compose ps`
3. Test health endpoint: `curl http://localhost:8080/health`

---

**Note**: This deployment uses port 8080 to avoid conflicts with existing services on your VPS. If you need to use a different port, update the `docker-compose.yml` file accordingly.
