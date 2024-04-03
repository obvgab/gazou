# Building
FROM swift AS build

# Name of project right now is "画像" or "image(s)"
ENV NAME "Gazou"

# Copying and caching server files
WORKDIR /build
COPY ./Package.* ./
RUN swift package resolve
COPY . .

# Build frontend

# Build backend
RUN swift build -c release --static-swift-stdlib

# Switch to staging and copy resources
WORKDIR /staging
RUN export ARTIFACTS="$(swift build --package-path /build -c release --show-bin-path)" \
    && cp "$ARTIFACTS/$NAME" ./ \
    && ln -s "./$NAME" "./start" \
    && find -L "$ARTIFACTS" -regex '.*\.resources$' -exec cp -Ra {} ./ \;

# Add static swift backtrace binary
RUN cp "/usr/libexec/swift/linux/swift-backtrace-static" ./

# Copy static files

# Running, should be a smaller, lighter, container
FROM swift:slim

# Create our user and move into the running directory
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /running swift
WORKDIR /running

# Copy over files and prepare backtrace support
COPY --from=build --chown=swift:swift /staging /running
ENV SWIFT_BACKTRACE=enable=yes,sanitize=yes,threads=all,images=all,interactive=no,swift-backtrace=./swift-backtrace-static

# Swap users and expose our application
USER swift:swift
EXPOSE 8080

# Start application
ENTRYPOINT ["./start"]
