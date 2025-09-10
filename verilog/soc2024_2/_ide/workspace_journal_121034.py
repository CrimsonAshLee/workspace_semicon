# 2025-09-10T18:33:54.046964
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_stopwatch_min",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stopwatch_min",platform = "$COMPONENT_LOCATION/../platform_stopwatch_min/export/platform_stopwatch_min/platform_stopwatch_min.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

vitis.dispose()

