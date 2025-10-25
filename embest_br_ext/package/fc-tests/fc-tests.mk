################################################################################
# fc-tests (FIFO Control tests)
################################################################################

# Pin a commit so downloads are reproducible
FC_TESTS_VERSION = 98bbbbc5bad1811af708482396de83f69932c7af
FC_TESTS_SITE = https://github.com/kbader94/fc_tests.git
FC_TESTS_SITE_METHOD = git

# Build modules against the kernel we build
FC_TESTS_DEPENDENCIES = linux

# Build the userspace test and the kernel module(s)
define FC_TESTS_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -Wall -O2 \
		-o $(@D)/rtt_test $(@D)/rtt_test.c

	$(TARGET_MAKE_ENV) $(MAKE) -C $(LINUX_DIR) \
		ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" \
		M=$(@D) modules
endef

# Install the userspace test and the module(s) into the target rootfs
define FC_TESTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rtt_test \
		$(TARGET_DIR)/usr/bin/rtt_test

	$(TARGET_MAKE_ENV) $(MAKE) -C $(LINUX_DIR) \
		ARCH=$(KERNEL_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" \
		M=$(@D) INSTALL_MOD_PATH="$(TARGET_DIR)" modules_install
endef

$(eval $(generic-package))

