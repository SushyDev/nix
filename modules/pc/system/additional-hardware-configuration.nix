{ config, pkgs, ... }:

{
  # ... your other configurations
  boot.kernelParams = [ "pci=acpi"];

  # 1. Allow unfree packages (still needed for firmware)
  # 1.5. Turn this into a overlay that only allows unfree for nvidia firmware
  nixpkgs.config.allowUnfree = true;

  # 2. Enable OpenGL and the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  # REMOVED: The driSupport options are deprecated and no longer needed.
  # hardware.opengl.driSupport = true;
  # hardware.opengl.driSupport32Bit = true;

  # 3. Explicitly choose the open-source NVIDIA kernel module.
  # This is the recommended setting for your GPU (Turing architecture or newer).
  hardware.nvidia.open = true;

  # 4. Blacklist nouveau to prevent it from loading and conflicting.
  boot.blacklistedKernelModules = [ "nouveau" ];

  # ... rest of your configurations
  hardware.nvidia.modesetting.enable = true;
}
