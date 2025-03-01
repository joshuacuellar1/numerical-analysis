FROM debian:bookworm-slim AS cmake
ADD --checksum=sha256:2984e70515ff60c5e4a41922b5d715a8168a696a89721e3b114e36f453244f72 \
    https://github.com/Kitware/CMake/releases/download/v3.31.5/cmake-3.31.5-linux-x86_64.tar.gz /cmake.tar.gz
RUN mkdir -p /cmake ; \
    tar -xzf /cmake.tar.gz --directory /cmake --strip-components=1

FROM debian:bookworm-slim
ARG USERNAME="debian"

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    ca-certificates

ADD --chown=_apt:nogroup https://apt.llvm.org/llvm-snapshot.gpg.key /etc/apt/trusted.gpg.d/apt.llvm.org.asc
RUN echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-18 main" >> /etc/apt/sources.list ; \
    echo "deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-18 main" >> /etc/apt/sources.list ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
    clang-18 \
    lld-18 \
    lldb-18 \
    clangd-18 \
    clang-tidy-18 \
    clang-format-18 \
    clang-tools-18 \
    libc++-18-dev \
    libc++abi-18-dev \
    git \
    openssh-client \
    ninja-build \
    cppcheck \
    valgrind; \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*;
COPY --from=cmake /cmake /usr/share/cmake
RUN ln -s /usr/share/cmake/bin/cmake /usr/bin/cmake ; \
    ln -s /usr/share/cmake/bin/cpack /usr/bin/cpack ; \
    rm /usr/bin/ld && ln -s /usr/lib/llvm-18/bin/ld.lld /usr/bin/ld

RUN groupadd -g 1000 devcontainer && \
    useradd -m -u 1000 -g devcontainer $USERNAME && \
    chown -R $USERNAME:devcontainer /home/$USERNAME

USER $USERNAME:devcontainer
ADD --chmod=770 --chown=$USERNAME:devcontainer https://github.com/microsoft/vcpkg-tool/releases/download/2025-02-11/vcpkg-glibc /usr/local/bin/vcpkg
