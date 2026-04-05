# =============================================================================
# MetaHub — Multi-Stage Dockerfile
# Builds the Spring Boot backend + React frontend into a single deployable image.
# Nginx serves the SPA and reverse-proxies /api to the Java backend.
# =============================================================================

# ── Stage 1: Build the React frontend ────────────────────────────────────────
FROM node:20-alpine AS frontend-build

WORKDIR /app/frontend

# Install dependencies first (layer cache)
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install --frozen-lockfile 2>/dev/null || npm install

# Copy source and build
COPY frontend/ ./
RUN npm run build


# ── Stage 2: Build the Spring Boot backend ───────────────────────────────────
FROM maven:3.9-eclipse-temurin-17-alpine AS backend-build

WORKDIR /app

# Cache Maven dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copy source and build (skip tests for faster Docker build)
COPY src/ ./src/
RUN mvn package -DskipTests -B && \
    mv target/metahub-*.jar target/metahub.jar


# ── Stage 3: Production runtime ─────────────────────────────────────────────
FROM eclipse-temurin:17-jre-alpine AS runtime

RUN apk add --no-cache nginx supervisor curl

WORKDIR /app

# Copy the built JAR
COPY --from=backend-build /app/target/metahub.jar ./metahub.jar

# Copy the built frontend
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html

# Nginx configuration
COPY docker/nginx.conf /etc/nginx/http.d/default.conf

# Supervisord configuration (runs both Nginx + Java)
COPY docker/supervisord.conf /etc/supervisord.conf

# Expose ports: 80 (Nginx → frontend + API proxy)
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:80/api/v1/datasets?page=0\&size=1 || exit 1

# Start both services via supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

