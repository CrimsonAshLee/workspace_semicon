# 2025-09-03T14:13:10.178166
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

client.delete_component(name="app_btn_fnd")

client.delete_component(name="app_btn_fnds")

platform = client.create_platform_component(name = "platform_btn_fnd",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_btn_fnd_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_btn_fnd",platform = "$COMPONENT_LOCATION/../platform_btn_fnd/export/platform_btn_fnd/platform_btn_fnd.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

