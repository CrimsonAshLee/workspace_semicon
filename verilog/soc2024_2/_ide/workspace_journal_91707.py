# 2025-09-15T14:25:03.313619
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.create_platform_component(name = "platform_stopwatch_intc",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_stopwatch_intc_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stopwatch_intc",platform = "$COMPONENT_LOCATION/../platform_stopwatch_intc/export/platform_stopwatch_intc/platform_stopwatch_intc.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

platform = client.get_component(name="platform_stopwatch_intc")
status = platform.build()

comp = client.get_component(name="app_stopwatch_intc")
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

