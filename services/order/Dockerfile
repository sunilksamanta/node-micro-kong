# Specify the base node image from the Docker Hub
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./
# If you are using yarn, you might want to copy the yarn.lock file
# COPY package.json yarn.lock ./

# Install dependencies
RUN npm install
# For production, you might want to use:
# RUN npm ci --only=production

# Copy the rest of your application's code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run your app using Node.js
CMD ["node", "src/index.js"]
