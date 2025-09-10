# 2025-09-10T09:29:34.720129
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

platform = client.get_component(name="platform_stopwatch")
status = platform.build()

comp = client.get_component(name="app_stopwatch")
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

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

platform = client.create_platform_component(name = "platform_stopwatch_addmin",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stopwatch_addmin",platform = "$COMPONENT_LOCATION/../platform_stopwatch_addmin/export/platform_stopwatch_addmin/platform_stopwatch_addmin.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

vitis.dispose()

