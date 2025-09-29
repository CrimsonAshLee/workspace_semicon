# 2025-09-29T16:31:51.933363
import vitis

client = vitis.create_client()
client.set_workspace(path="SoC_elevator")

platform = client.create_platform_component(name = "platform_elevator",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/SoC_EV_BD_wrapper_final.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_elevator",platform = "$COMPONENT_LOCATION/../platform_elevator/export/platform_elevator/platform_elevator.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_elevator")
status = platform.build()

comp = client.get_component(name="app_elevator")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

