require_relative "TaskConfig"
require_relative "VmManager"

class UbuntuVmCreationTask
    def initialize(config: TaskConfig.new)
        @config = config
    end

    def run
        with do |vm_manager|
            vm_manager.destroy_existing_vm

            vm_manager.create_ubuntu_vm(
                @config.os_variant,
                @config.base_image_filename,
                @config.mac_address,
                @config.bridge_adapter,
                @config.ram_mb,
                @config.cpu_count,
                @config.vnc_port
            )

            vm_manager.autostart_vm
        end
    end

    def with
        vm_manager = VmManager.new(@config.vm_name, @config.storage_folder)
        yield vm_manager
    end
end