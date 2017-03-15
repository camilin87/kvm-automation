class TaskConfig
    attr_reader(
        :storage_folder,
        :public_key_filename,
        :base_image_filename,
        :vm_name,
        :mac_address,
        :bridge_adapter,
        :ram_mb,
        :cpu_count
    )

    def initialize(input=ARGV)
        @input_arr = input

        @storage_folder = File.expand_path read_param("path", "~/vms")
        @public_key_filename = File.expand_path read_param("key", "~/.ssh/id_rsa.pub")

        _base_image_filename = read_param("img")
        if not _base_image_filename then
            _base_image_filename = ""
        else
            _base_image_filename = File.expand_path(_base_image_filename)
        end
        @base_image_filename = _base_image_filename

        @vm_name = read_param("name", "vm01")
        @mac_address = read_param("mac", "54:36:E2:84:5A:C0")
        @bridge_adapter = read_param("br", "br0")
        @ram_mb = read_param("ram", "1024")
        @cpu_count = read_param("cpu", "1")
    end

    def read_param(name, default_value = nil)
        result = default_value

        idx = @input_arr.index("--#{name}")
        if idx != nil and idx >= 0 then
            result = @input_arr[idx + 1]
        end

        result
    end
end