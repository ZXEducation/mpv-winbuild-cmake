ExternalProject_Add(libxml2
    DEPENDS
        zlib
        libiconv
    GIT_REPOSITORY https://github.com/GNOME/libxml2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !result !test"
    UPDATE_COMMAND ""
    GIT_RESET 66fdf94c5518547c12311db1e4dc0485acf2a2f8
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
        -DCMAKE_FIND_ROOT_PATH=${MINGW_INSTALL_PREFIX}
        -DBUILD_SHARED_LIBS=OFF
        -DLIBXML2_WITH_ZLIB=ON
        -DLIBXML2_WITH_ICONV=ON
        -DLIBXML2_WITH_LZMA=OFF
        -DLIBXML2_WITH_PYTHON=OFF
        -DLIBXML2_WITH_TESTS=OFF
        -DLIBXML2_WITH_HTTP=OFF
        -DLIBXML2_WITH_TREE=ON
        -DLIBXML2_WITH_THREADS=ON
        -DLIBXML2_WITH_THREAD_ALLOC=ON
        -DLIBXML2_WITH_PROGRAMS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libxml2)
cleanup(libxml2 install)
