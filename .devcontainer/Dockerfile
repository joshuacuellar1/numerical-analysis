FROM debian:bookworm-slim AS cmake
ADD --checksum=sha256:d66c11c010588c8256ee20a26b45977cd5b2f4aee2b742d4b8a353769940d147 \
    https://github.com/Kitware/CMake/releases/download/v4.0.1/cmake-4.0.1-linux-x86_64.tar.gz /cmake.tar.gz
RUN mkdir -p /cmake ; \
    tar -xzf /cmake.tar.gz --directory /cmake --strip-components=1

FROM debian:bookworm-slim AS ninja
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    unzip; \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*;
ADD https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip /ninja.zip
RUN mkdir -p /ninja ; \
    unzip -j /ninja.zip -d /ninja


FROM debian:bookworm-slim

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    zip unzip \
    curl \
    git \
    pkgconf

ADD --chown=_apt:nogroup https://apt.llvm.org/llvm-snapshot.gpg.key /etc/apt/trusted.gpg.d/apt.llvm.org.asc
RUN echo "deb https://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main" >> /etc/apt/sources.list ; \
    echo "deb-src https://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main" >> /etc/apt/sources.list ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
    clang-20 \
    llvm-20 \
    lld-20 \
    lldb-20 \
    clang-tidy-20 \
    clang-format-20 \
    clang-tools-20 \
    libclang-rt-20-dev \
    openssh-client \
    cppcheck \
    valgrind \
    linux-perf ; \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*;
COPY --from=cmake /cmake /usr/share/cmake
RUN ln -s /usr/share/cmake/bin/cmake /usr/bin/cmake ; \
    ln -s /usr/share/cmake/bin/cpack /usr/bin/cpack ; \
    rm /usr/bin/ld && ln -s /usr/lib/llvm-20/bin/ld.lld /usr/bin/ld

RUN groupadd -g 1000 devcontainer && \
    useradd -m -u 1000 -g devcontainer debian && \
    chown -R debian:devcontainer /home/debian


USER debian:devcontainer

ADD --keep-git-dir=true --chown=debian:devcontainer https://github.com/microsoft/vcpkg.git /usr/local/vcpkg
ADD --chmod=500 --chown=debian:devcontainer https://github.com/microsoft/vcpkg-tool/releases/download/2025-04-16/vcpkg-glibc /usr/local/vcpkg/vcpkg
ENV PATH="$PATH:/usr/local/vcpkg:/usr/lib/llvm-20/bin"
ENV VCPKG_ROOT=/usr/local/vcpkg

COPY --from=ninja --chmod=500 --chown=debian:devcontainer /ninja/ninja /usr/bin/ninja
