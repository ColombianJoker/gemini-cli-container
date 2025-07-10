# Use the official Node.js 20 image as the base
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Install git, which is needed to clone the repository
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

# Clone the gemini-cli repository into a temporary directory
RUN git clone https://github.com/google-gemini/gemini-cli.git /tmp/gemini-cli

# Change to the cloned directory to build the project
WORKDIR /tmp/gemini-cli

# Install all dependencies (including devDependencies needed for bundling)
# and then run the bundle script.
# The 'bundle' script in gemini-cli typically handles generating and building.
RUN npm install
RUN npm run bundle

# Change back to the application working directory
WORKDIR /app

# Install gemini-cli globally from the locally built package
RUN npm install -g /tmp/gemini-cli

# Clean up the cloned repository to reduce image size
RUN rm -rf /tmp/gemini-cli

# Set the entrypoint to gemini-cli.
# This makes it so that when you run the container, it automatically executes 'gemini-cli'.
# The 'CMD' part can be overridden by arguments passed to 'docker run'.
ENTRYPOINT ["gemini-cli"]

# Set a default command if no arguments are provided (e.g., show help)
CMD ["--help"]