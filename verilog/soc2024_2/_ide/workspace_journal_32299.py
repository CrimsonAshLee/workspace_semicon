# 2025-09-04T09:36:18.086964
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_fnd_cntr",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_fnd_cntr_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

platform = client.get_component(name="platform_fnd_cntr")
status = platform.update_desc(desc="")

comp = client.create_app_component(name="app_fnd_cntr",platform = "$COMPONENT_LOCATION/../platform_fnd_cntr/export/platform_fnd_cntr/platform_fnd_cntr.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="app_fnd_cntr")
comp.build()

vitis.dispose()

