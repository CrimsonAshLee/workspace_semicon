# 2025-09-09T09:41:08.545288
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

status = comp.clean()

status = platform.build()

comp.build()

platform = client.get_component(name="platform_dht11")
status = platform.build()

comp = client.get_component(name="app_dht11")
comp.build()

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

platform = client.get_component(name="platform_txtlcd")
status = platform.build()

comp = client.get_component(name="app_txtlcd")
comp.build()

status = platform.build()

comp.build()

platform = client.create_platform_component(name = "platform_stopwatch",hw_design = "$COMPONENT_LOCATION/../../basys3_exam/soc_stop_watch_wrapper.xsa",os = "standalone",cpu = "microblaze_riscv_0",domain_name = "standalone_microblaze_riscv_0")

comp = client.create_app_component(name="app_stopwatch",platform = "$COMPONENT_LOCATION/../platform_stopwatch/export/platform_stopwatch/platform_stopwatch.xpfm",domain = "standalone_microblaze_riscv_0",template = "hello_world")

vitis.dispose()

