# pinenote_debian_mutter

Packaging mutter for the Pine64 Pinenote arm64 device

# Patches

These patches are applied by default on top of the Debian patchtes:

* 0001-Add-META_CONNECTOR_TYPE_DPI.patch : Make sure the Pinenote display is
  detected as a built-in display with DPI connector

There are some experimental patches that should, for now, only be used for
testing:

* patches_very_experimental/

	* p_refresh_rate_05_Hz.patch : hard code the panel refresh rate to 5 Hz.
	  This will not affect the actual ebc hardware, but mutter will reduce the
	  framebuffer refreshes accordingly. The idea here is to reduce the memory
	  pressure on the drm/ebc system, which should reduce/limit visible
	  artifacting. Note that the patch could be overkill at certain locations.
	* p_refresh_rate_15_Hz.patch : same for 15 Hz
	* p_refresh_rate_9Hz.patch : same for 20 Hz


# TODO:

* Use Debian-specific tools to handle patches (quilt?)

