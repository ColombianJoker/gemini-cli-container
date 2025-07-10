# Use the official Node.js 20 image as the base
FROM node:20

# Set the working directory inside the container
# This is where your local host directory will be mounted
WORKDIR /app

# Install git, which is needed by npm to install packages directly from GitHub URLs
# apt-get update and apt-get install are used for Debian-based images like node:20
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

# Install gemini-cli globally.
# npm will clone the repository and install it.
# The --unsafe-perm flag might be needed for some native modules, but try without it first.
# If you face issues, you might add it back: npm install -g https://github.com/google-gemini/gemini-cli --unsafe-perm
RUN npm install -g https://github.com/google-gemini/gemini-cli --unsafe-perm

# Set the entrypoint to gemini-cli.
# This makes it so that when you run the container, it automatically executes 'gemini-cli'.
# The 'CMD' part can be overridden by arguments passed to 'docker run'.
# For interactive use, we want to run the CLI directly.
ENTRYPOINT ["gemini-cli"]

# If you want to specify a default command if no arguments are provided, you can use CMD.
# For interactive CLI, this is often left empty or points to a help command.
# CMD ["--help"]