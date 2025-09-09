# 2025-09-08T15:46:47.403423
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_txtlcd",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_txtlcd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_txtlcd",platform = "$COMPONENT_LOCATION/../platform_txtlcd/export/platform_txtlcd/platform_txtlcd.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

vitis.dispose()

