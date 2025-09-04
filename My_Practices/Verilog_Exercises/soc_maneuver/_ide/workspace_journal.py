# 2025-09-04T11:08:22.274934
import vitis

client = vitis.create_client()
client.set_workspace(path="soc_maneuver")

platform = client.create_platform_component(name = "platform_hello",hw_design = "$COMPONENT_LOCATION/../../basys3_maneuver/soc_hello_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

vitis.dispose()

