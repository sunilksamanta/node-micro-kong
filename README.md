# Microservices with NodeJS & API Kong Gateway

This project demonstrates how to build a microservices architecture using Node.js and Kong API Gateway. It includes two services: a `product` service and an `order service. The services are managed by Kong, which acts as an API Gateway to route requests, apply security policies, and manage traffic.

## Project Structure

- `product-service`: A simple RESTful service to manage products.
- `order-service`: A simple RESTful service to manage orders.
- `kong`: Kong configuration files to set up the API Gateway.
- `docker-compose.yml`: Docker Compose file to run the services.
- `scripts`: Bash scripts to automate common tasks.
- `config`: Configuration files.

## Directory Structure

```bash
    Root
    ├── common
    ├── middlewares
    ├── utils
    ├── config
    ├── gateway
    │   └──kong.yml
    ├── scripts
    ├── services
    │   ├── order
    │   │   ├── src
    │   │   ├── Dockerfile
    │   │   ├── package.json
    │   │   └── .env
    │   └── product
    │   │   ├── src
    │   │   ├── Dockerfile
    │   │   ├── package.json
    │   │   └── .env
    ├── readme.md
    └── docker-compose.yml
    
```

## Prerequisites

- Docker
- Docker Compose

## Kong Declarative Configuration

```yaml
_format_version: "2.1"
services:
- name: product-service
  url: http://product:3000
  routes:
  - name: product-route
    paths:
    - /products
  plugins:
  - name: jwt

- name: order-service
  url: http://order:3000
  routes:
  - name: order-route
    paths:
    - /orders
# Disable JWT for order service for testing
#  plugins:
#  - name: jwt

consumers:
- username: demo
  jwt_secrets:
  - key: yourkey
    secret: your_secret
    algorithm: HS256
```

## Docker Compose Configuration

```yaml
version: '3.8'
services:
  kong:
    image: kong:2.5
    environment:
      KONG_DATABASE: "off"
      KONG_DECLARATIVE_CONFIG: /etc/kong/kong.yml
      KONG_PROXY_ACCESS_LOG: /dev/stdout
      KONG_ADMIN_ACCESS_LOG: /dev/stdout
      KONG_PROXY_ERROR_LOG: /dev/stderr
      KONG_ADMIN_ERROR_LOG: /dev/stderr
      KONG_ADMIN_LISTEN: 0.0.0.0:8001
    volumes:
      - ./gateway/kong.yml:/etc/kong/kong.yml
    ports:
      - "8000:8000"
      - "8443:8443"
      - "8001:8001"
      - "8444:8444"
    networks:
      - kong-network

  product:
    build:
      context: ./services/product
    ports:
      - "3001:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
      - MONGO_URI=mongodb://host.docker.internal:27017/product
    networks:
      - kong-network

  order:
    build:
      context: ./services/order
    ports:
      - "3002:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
      - MONGO_URI=mongodb://host.docker.internal:27017/order
    networks:
      - kong-network

networks:
  kong-network:
    driver: bridge

```

## Running the Project

```bash
docker-compose up -d
```
## Verify Kong Configuration:

```bash
curl -i -X GET http://localhost:8001/services
```

## Customization

- Modify Services: Edit the Docker Compose file to add more services or change existing ones.
- Update Kong Configuration: Edit gateway/kong.yml to update the API routes, plugins, or other settings.
- Add Plugins: Add more plugins to Kong by updating the Kong configuration file.
- Update Environment Variables: Modify the environment variables in the Docker Compose file to change service configurations.

## License

This project is open-source and available under the [MIT License](LICENSE).

## Contributing

Feel free to contribute to this project and create a pull request with your changes.

## Support

For support or questions, please create an issue in this repository.

## Author

[Sunil Kumar Samanta](https://github.com/sunilksamanta)

