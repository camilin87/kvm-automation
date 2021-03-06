require_relative "VmTask"

class UbuntuVmCreationTask < VmTask
  def run_with(vm_manager)
    vm_manager.destroy_existing_vm

    vm_manager.create_vm_hdd_container_folder

    vm_manager.create_ubuntu_vm(
      @config.os_variant,
      @config.base_image_filename,
      @config.mac_address,
      @config.bridge_adapter,
      @config.ram_mb,
      @config.cpu_count,
      @config.hdd_gb,
      @config.vnc_port,
      @config.vnc_ip
      )

    vm_manager.autostart_vm unless @config.autostart == "false"
    vm_manager.read_vnc_information
    vm_manager.read_mac_address
  end
end