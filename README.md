# Microservices with API Gateway Kong

This project sets up an API Gateway using Kong with declarative configuration to manage `product` and `order` microservices. Kong handles routing and JWT-based authorization.

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
